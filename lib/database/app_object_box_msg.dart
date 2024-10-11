import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/database/entity/app_msg_entity.dart';
import 'package:oliapro/objectbox.g.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';

import '../common/app_constants.dart';
import 'entity/app_conversation_entity.dart';
import 'entity/app_her_entity.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
/// 有数据模型更新要执行下面语句 =>>
/// flutter pub run build_runner build
/// flutter pub run build_runner build --delete-conflicting-outputs
class ObjectBoxMsg {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<HerEntity> herBox;
  late final Box<MsgEntity> msgBox;
  late final Box<ConversationEntity> conversationBox;

  /// A stream of all notes ordered by date.
  late final Stream<Query<HerEntity>> queryStream;

  String get _getMyId => (UserInfo.to.userLogin?.userId) ?? "emptyId";

  ObjectBoxMsg._create(this.store) {
    herBox = Box<HerEntity>(store);
    msgBox = Box<MsgEntity>(store);
    conversationBox = Box<ConversationEntity>(store);

    final qBuilder = herBox.query()
      ..order(HerEntity_.date, flags: Order.descending);
    queryStream = qBuilder.watch(triggerImmediately: true);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static ObjectBoxMsg create(Store store) {
    // Future<Store> openStore() {...} is defined in the generated noramuztiobjectbox.g.dart
    return ObjectBoxMsg._create(store);
  }

  HerEntity? queryHer(String uid) {
    var queryBuilder = herBox.query(HerEntity_.uid.equals(uid));
    var query = queryBuilder.build();
    HerEntity? her = query.findUnique();
    query.close();
    return her;
  }

  void putOrUpdateHer(HerEntity her) {
    var queryBuilder = herBox.query(HerEntity_.uid.equals(her.uid));
    var query = queryBuilder.build();
    HerEntity? herOld = query.findUnique();
    query.close();
    if (herOld != null) {
      her.id = herOld.id;
    }
    // 有则更新，无则插入
    herBox.put(her);
  }

  /// 获取和主播聊天记录
  List<MsgEntity> queryHostMsgs(String herId, int time) {
    var queryBuilder = msgBox.query(MsgEntity_.myId.equals(_getMyId) &
        MsgEntity_.herId.equals(herId) &
        MsgEntity_.dateInsert.lessThan(time))
      ..order(MsgEntity_.dateInsert, flags: Order.descending);

    // offset偏移 limit限制
    var query = queryBuilder.build()
      // ..offset = 10
      ..limit = 10;
    List<MsgEntity> list = query.find();
    query.close();
    return list;
  }

  /// 获取和主播会话记录
  List<ConversationEntity> queryHostCon(int time) {
    var queryBuilder = conversationBox.query(
        ConversationEntity_.myId.equals(_getMyId) &
            ConversationEntity_.dateInsert.lessThan(time))
      ..order(ConversationEntity_.top, flags: Order.descending)
      ..order(ConversationEntity_.dateInsert, flags: Order.descending);

    // offset偏移 limit限制
    var query = queryBuilder.build()
      // ..offset = 10
      ..limit = 120;
    List<ConversationEntity> list = query.find();

    query.close();
    return list;
  }

  /// 把主播聊天设为已读
  void setRead(String herId) {
    var queryBuilder = msgBox.query(
        MsgEntity_.myId.equals(_getMyId) & MsgEntity_.herId.equals(herId));

    // offset偏移 limit限制
    var query = queryBuilder.build();
    // ..offset = 10
    //   ..limit = 10;
    List<MsgEntity> list = query.find();
    query.close();
    if (list.isEmpty) return;
    list = list.map((e) => e..readState = 0).toList();
    msgBox.putMany(list);

    // 更新会话
    var queryBuilder2 = conversationBox.query(
        ConversationEntity_.myId.equals(_getMyId) &
            ConversationEntity_.herId.equals(herId));
    var query2 = queryBuilder2.build();
    ConversationEntity? con = query2.findUnique();
    query2.close();
    if (con != null) {
      UserInfo.to.msgUnreadNum.value -= con.unReadQuality;
      UserInfo.to.updateMessageUnRead(UserInfo.to.msgUnreadNum.value);
      con.unReadQuality = 0;
      conversationBox.put(con);
    }
    StorageService.to.eventBus.fire(EventMsgClear(0));
  }

  /// 把所有主播聊天设为已读
  void setAllRead() {
    var queryBuilder = msgBox.query(MsgEntity_.myId.equals(_getMyId));

    // offset偏移 limit限制
    var query = queryBuilder.build();
    // ..offset = 10
    //   ..limit = 10;
    List<MsgEntity> list = query.find();
    query.close();
    if (list.isEmpty) return;
    list = list.map((e) => e..readState = 0).toList();
    msgBox.putMany(list);

    // 更新会话
    var queryBuilder2 =
        conversationBox.query(ConversationEntity_.myId.equals(_getMyId));
    var query2 = queryBuilder2.build();
    List<ConversationEntity> cons = query2.find();
    query2.close();
    if (cons.isNotEmpty) {
      for (var con in cons) {
        con.unReadQuality = 0;
      }
      conversationBox.putMany(cons);
    }
    StorageService.to.eventBus.fire(EventMsgClear(0));
    UserInfo.to.msgUnreadNum.value = 0;
    UserInfo.to.updateMessageUnRead(UserInfo.to.msgUnreadNum.value);
  }

  ///刷新我的所有未读消息数
  refreshUnreadNum() {
    // 更新会话
    var queryBuilder2 =
        conversationBox.query(ConversationEntity_.myId.equals(_getMyId));
    var query2 = queryBuilder2.build()..limit = 120;
    List<ConversationEntity> cons = query2.find();
    query2.close();
    var num = 0;
    if (cons.isNotEmpty) {
      for (var con in cons) {
        /*if (con.herId != AppConstants.systemId &&
            con.herId != AppConstants.serviceId) {
          // 去除系统消息数量
          num += con.unReadQuality;
        }*/
        num += con.unReadQuality;
      }
    }
    UserInfo.to.msgUnreadNum.value = num;
    UserInfo.to.updateMessageUnRead(UserInfo.to.msgUnreadNum.value);
  }

  /// 清空所有聊天记录
  void clearAllMsg() {
    msgBox.removeAll();
    conversationBox.removeAll();
    StorageService.to.eventBus.fire(EventMsgClear(1));
    UserInfo.to.msgUnreadNum.value = 0;
    UserInfo.to.updateMessageUnRead(UserInfo.to.msgUnreadNum.value);
  }

  /// 插入或更新聊天消息
  int insertOrUpdateMsg(MsgEntity msg, {bool setRead = false}) {
    // 当前是否在和她聊天，和她聊天当前消息已读，
    final bool chattingWithHer = UserInfo.to.chattingWithHer == msg.herId;
    // 收到的消息并且不在和她聊天，未读
    if (!setRead && msg.sendType == 1 && !chattingWithHer) {
      msg.readState = 1;
      UserInfo.to.msgUnreadNum.value += 1;
      UserInfo.to.updateMessageUnRead(UserInfo.to.msgUnreadNum.value);
    } else {
      msg.readState = 0;
    }
    var id = msgBox.put(msg);
    // 插入了消息要更新会话
    var queryBuilder =
        conversationBox.query(ConversationEntity_.groupId.equals(msg.groupId));
    var query = queryBuilder.build();
    List<int> ids = query.findIds();
    query.close();
    // 没有会话就新建一个
    ConversationEntity con =
        _makeCon(msg, ids.isEmpty ? 0 : ids.first, chattingWithHer);
    // 根据id有则更新，无则插入
    conversationBox.putAsync(con, mode: PutMode.put).then((value) {
      // 事件总线发送有消息插入的事件
      StorageService.to.eventBus.fire(msg);
    });
    return id;
  }

  /// id有值说明是更新，无值设为0会插入一条
  ConversationEntity _makeCon(MsgEntity msg, int id, bool chattingWithHer) {
    ConversationEntity con = ConversationEntity(msg.myId, msg.herId,
        msg.sendType, msg.content, msg.dateInsert, msg.rawData,
        id: id,
        top: msg.herId == AppConstants.systemId ? 1 : 0,
        lastMsgType: msg.msgType,
        sendState: msg.sendState);
    // 不是在和她聊天，就把未读消息更新
    if (!chattingWithHer) {
      var queryBuilder = msgBox.query(MsgEntity_.groupId.equals(msg.groupId) &
          MsgEntity_.readState.equals(1));
      var query = queryBuilder.build();
      // List<int> list = query.findIds();
      int size = query.count();
      query.close();
      con.unReadQuality = size;
    }
    return con;
  }

  /// 插入一个10000号的会话，给审核模式看
  Future<int> make10000() async {
    String myId = UserInfo.to.myDetail!.userId!;
    var queryBuilder = conversationBox.query(ConversationEntity_.groupId
        .equals("${myId}_${AppConstants.serviceId}"));
    var query = queryBuilder.build();
    List<int> ids = query.findIds();
    query.close();
    if (ids.isNotEmpty) return 0;
    ConversationEntity con = ConversationEntity(myId, AppConstants.serviceId, 1,
        '', DateTime.now().millisecondsSinceEpoch, '',
        id: 0, top: 2, lastMsgType: RTMMsgText.typeCode);
    return await conversationBox.putAsync(con, mode: PutMode.put);
  }

  /// 删除主播聊天记录
  void removeHer(String herId) {
    var queryBuilder = msgBox.query(
        MsgEntity_.myId.equals(_getMyId) & MsgEntity_.herId.equals(herId));
    var query = queryBuilder.build();
    List<int> list = query.findIds();
    query.close();
    msgBox.removeMany(list);

    var queryBuilder2 = conversationBox.query(
        ConversationEntity_.myId.equals(_getMyId) &
            ConversationEntity_.herId.equals(herId));
    var query2 = queryBuilder2.build();
    List<int> ids = query2.findIds();
    query2.close();
    conversationBox.removeMany(ids);
    StorageService.to.eventBus.fire(EventMsgClear(3));
  }
}
