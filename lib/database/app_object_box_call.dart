import 'dart:convert';

import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/objectbox.g.dart';
import 'package:oliapro/services/user_info.dart';

import '../services/storage_service.dart';
import 'entity/app_aic_entity.dart';
import 'entity/app_call_entity.dart';
import 'entity/app_msg_entity.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
/// 有数据模型更新要执行下面语句 =>>
/// flutter pub run build_runner build
/// flutter pub run build_runner build --delete-conflicting-outputs
class ObjectBoxCall {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<AicEntity> aicBox;
  late final Box<CallEntity> callBox;

  String get _getMyId => (UserInfo.to.userLogin?.userId) ?? "emptyId";

  ObjectBoxCall._create(this.store) {
    aicBox = Box<AicEntity>(store);
    callBox = Box<CallEntity>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static ObjectBoxCall create(Store store) {
    // Future<Store> openStore() {...} is defined in the generated noramuztiobjectbox.g.dart
    return ObjectBoxCall._create(store);
  }

  List<AicEntity>? queryAicList() {
    var queryBuilder = aicBox.query();
    var query = queryBuilder.build();
    List<AicEntity>? list = query.find();
    query.close();
    return list;
  }

  AicEntity? queryAic(String url) {
    var queryBuilder = aicBox.query(AicEntity_.filename.equals(url));
    var query = queryBuilder.build();
    AicEntity? aic = query.findUnique();
    query.close();
    return aic;
  }

  void deleteAicHadShow() {
    var queryBuilder = aicBox.query(AicEntity_.playState.greaterThan(1));
    var query = queryBuilder.build();
    int aic = query.remove();
    query.close();
  }

  AicEntity? queryAicCanShow() {
    var queryBuilder = aicBox
        .query(AicEntity_.playState.equals(1) & AicEntity_.localPath.notNull())
      ..order(AicEntity_.dateInsert);
    var query = queryBuilder.build();
    AicEntity? aic = query.findFirst();
    query.close();
    return aic;
  }

  void putOrUpdateAic(AicEntity aic) {
    var queryBuilder = aicBox.query(AicEntity_.extra.equals(aic.extra ?? ''));
    var query = queryBuilder.build();
    AicEntity? aicOld = query.findUnique();
    query.close();
    if (aicOld != null) {
      aic.id = aicOld.id;
    }
    // 有则更新，无则插入
    aicBox.put(aic);
  }

  /// 获取和主播会话记录
  List<CallEntity> queryCallHistory(int time) {
    var queryBuilder = callBox.query(CallEntity_.myId.equals(_getMyId) &
        CallEntity_.dateInsert.lessThan(time))
      ..order(CallEntity_.dateInsert, flags: Order.descending);

    // offset偏移 limit限制
    var query = queryBuilder.build()
      // ..offset = 10
      ..limit = 20;
    List<CallEntity> list = query.find();

    query.close();
    return list;
  }

  /// callType 0拨打，1被叫，
  /// 2aib拨打(aib是被叫页面，实际是要去拨打),
  /// 3aic
  void savaCallHistory({
    required String herId,
    required String herVirtualId,
    required String channelId,
    required int callType,
    required int callStatus,
    required int dateInsert,
    required String duration,
    String extra = '',
  }) {
    // 老的存单独的数据库的通话消息
    CallEntity entity = CallEntity(
        myId: _getMyId,
        herId: herId,
        herVirtualId: herVirtualId,
        channelId: channelId,
        callType: callType,
        callStatus: callStatus,
        dateInsert: dateInsert,
        duration: duration,
        extra: extra);
    callBox.put(entity);
    // 插入消息数据库
    //AppLog.debug('savaCallHistory duration=$duration');
    var call = RTMMsgCallState()
      ..statusType = callStatus
      ..duration = duration;
    MsgEntity msgEntity = MsgEntity(
      _getMyId,
      herId,
      callType > 0 ? 1 : 0,
      "",
      dateInsert,
      json.encode(call),
      RTMMsgCallState.typeCode,
    );
    StorageService.to.objectBoxMsg.insertOrUpdateMsg(msgEntity, setRead: true);
  }
}
