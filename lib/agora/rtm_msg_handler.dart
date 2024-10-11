import 'dart:convert';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/database/entity/app_her_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_app_rate.dart';
import 'package:oliapro/utils/cache/login_cache.dart';

import '../common/call_status.dart';
import '../database/entity/app_msg_entity.dart';
import '../entities/app_host_entity.dart';
import '../socket/socket_entity.dart';

void handleMsg(RtmMessage message, String peerId) {
  final String myId = UserInfo.to.userLogin?.userId ?? "emptyId";
  final int milliseconds = DateTime.now().millisecondsSinceEpoch;
  // AppLog.debug('rtm message come !! \npeerId: $peerId \n$message');
  final String text = message.text;

  /// text字符窜有我们定义的消息
  RTMText msg = RTMText.fromJson(json.decode(text));
  var her = msg.userInfo;

  /// 缓存主播信息用于聊天页面 -1是aic 9999是系统消息
  if (peerId != '-1' && peerId != '9999') {
    if (her != null &&
        her.uid != null &&
        her.portrait != null &&
        her.name != null) {
      var entity = HerEntity(her.name ?? '', her.uid!, portrait: her.portrait);
      StorageService.to.objectBoxMsg.putOrUpdateHer(entity);
      StorageService.to.eventBus.fire(entity);
    } else {
      // 发现服务端下发的话术消息只有id,"userInfo":{"auth":2,"uid":"108172243"}
      Http.instance.post<HostDetail>(NetPath.upDetailApi + peerId,
          errCallback: (err) {
        //AppLog.debug(err);
      }).then((value) {
        var entity =
            HerEntity(value.nickname ?? '', peerId, portrait: value.portrait);
        StorageService.to.objectBoxMsg.putOrUpdateHer(entity);
        StorageService.to.eventBus.fire(entity);
      });
    }
  }
  if (msg.messageContent == null || msg.messageContent!.isEmpty) {
    return;
  }

  /// messageContent字符窜可以序列化成具体文字图片bean
  final String messageContent = msg.messageContent!;

  /// 消息类型
  final int msgType = msg.type!;

  if (msgType == 28) {
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }

    /// app打分
    AppRate.rateApp(messageContent);
    return;
  }
  if (msgType == 29) {
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }
    // 电话涉黄警告
    StorageService.to.eventBus.fire(EventCommon(0, ""));
    return;
  }

  // type text = 10
  // type gift = 11
  // type call = 12
  // type imge = 13 图片消息
  // type voice = 14 语音消息
  // type video = 15
  // type severImge = 20//服务器图片消息
  // type severVoice = 21 //服务器语音消息
  // type = 24 //AIA下发的视频
  // type = 25 //AIB
  // type = 23    服务器会发送begincall
  // type = 31    主播索要礼物
  Map<String, dynamic> jsonMap;
  try {
    jsonMap = json.decode(messageContent);
  } catch (e) {
    return;
  }

  /// begincall
  if (msgType == RTMMsgBeginCall.typeCode) {
    RTMMsgBeginCall beginCall = RTMMsgBeginCall.fromJson(jsonMap);
    StorageService.to.eventBus.fire(beginCall);
    return;
  } else if (msgType == RTMMsgAIB.typeCode) {
    // if (AppConstants.isFakeMode) {
    //   // 审核模式
    //   return;
    // }
    // RTMMsgAIB aib = RTMMsgAIB.fromJson(jsonMap);
    //
    // /// Aib
    // if (!AppCheckCallingUtil.checkCanAib() ||
    //     AppCheckCallingUtil.checkCallHerRecently(aib.userId ?? '100')) {
    //   AppLog.debug('stop aib --> ${AppPages.history.last}');
    //   return;
    // }
    //
    // YuliaRemoteController.startMeAib(aib.userId!, messageContent);
    return;
  } else if (msgType == RTMMsgAIC.typeCode) {
    // if (AppConstants.isFakeMode) {
    //   // 审核模式
    //   return;
    // }
    // /// Aic
    // AppLog.debug('receive aic -->');
    // RTMMsgAIC aic = RTMMsgAIC.fromJson(jsonMap);
    // AppAicHandler().getAicMsg(aic);
    return;
  } else if (msgType == 29) {
    /// 鉴黄通知
  } else if (msgType == 27) {
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }

    /// 等级提升，充值加钻
    /// 只要有余额变动就会发这个，socket的balanceChanged消息也一样
    SocketEntity entity = SocketEntity.fromJson(jsonMap);
    SocketBalance socketBalance =
        SocketBalance.fromJson(json.decode(entity.data!));
    var changeState = -1;
    var myDiamonds = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    var newDiamonds = socketBalance.diamonds;
    var price = UserInfo.to.config?.chargePrice ?? 60;
    if (myDiamonds >= price && newDiamonds < price) {
      // 我的钻石从60以上掉到60以下的情况
      // GoraHttpUtil().post(GoraHttpUrls.initRobotApi);
      changeState = 1;
    } else if (myDiamonds < price && newDiamonds >= price) {
      // 我的钻石从60以下升高到到60以上的情况
      changeState = 0;
    }
    if (changeState > -1) {
      StorageService.to.eventBus.fire(EventCanCallStateChange(changeState));
    }
    UserInfo.to.handleBalanceChange(socketBalance);
    LoginCache.update(diamondCount: socketBalance.diamonds.toString());
  } else if (msgType == RTMMsgCallState.typeCode) {
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }

    /// 发来的通话记录
    RTMMsgCallState callState = RTMMsgCallState.fromJson(jsonMap);
    if (her != null && her.uid != null) {
      StorageService.to.objectBoxCall.savaCallHistory(
          herId: her.uid ?? '',
          herVirtualId: '',
          channelId: '',
          callType: 1,
          callStatus: callState.statusType ?? CallStatus.PICK_UP,
          dateInsert: DateTime.now().millisecondsSinceEpoch,
          duration: callState.duration ?? '00:00');
    }
    return;
  } else if (msgType == 31) {
    //TestRtmUtils.showRtmGift(msg: "rtm 收到 索要礼物");

    // print("msgType == 31==jsonMap====${jsonMap}");
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }
    RTMMsgGift gift = RTMMsgGift.fromJson(jsonMap);
    gift.anchorId = her?.uid ?? "-999";
    gift.anchorPortrait = her?.portrait ?? "";
    gift.anchorName = her?.name ?? "";
    StorageService.to.eventBus.fire(gift);
  } else if (msgType == 32) {
    // 体验卡变动
    if (AppConstants.isFakeMode) {
      // 审核模式
      return;
    }
    SocketEntity entity = SocketEntity.fromJson(jsonMap);
    var jsonMap2 = json.decode(entity.data!);
    // 体验卡数量变动
    if (jsonMap2['callCardCount'] is int) {
      int newCardCount = jsonMap2['callCardCount'];
      UserInfo.to.myDetail?.callCardCount = newCardCount;
      StorageService.to.eventBus.fire(EventCanCallStateChange(4));
      StorageService.to.eventBus.fire(eventBusRefreshMe);
    }
    return;
  }
  // 下面是聊天消息各类型
  final typeList = [
    // 收到电话状态
    RTMMsgCallState.typeCode,
    // 收到文字
    RTMMsgText.typeCode,
    // 收到图片
    ...RTMMsgPhoto.typeCodes,
    // 收到声音
    ...RTMMsgVoice.typeCodes
  ];
  MsgEntity msgEntity;
  if (typeList.contains(msgType)) {
    msgEntity =
        MsgEntity(myId, peerId, 1, "", milliseconds, messageContent, msgType);
    if (msgType == RTMMsgText.typeCode) {
      RTMMsgText textMsg = RTMMsgText.fromJson(jsonMap);
      msgEntity.content = textMsg.text ?? "";
    }
    if (RTMMsgVoice.typeCodes.contains(msgType)) {
      RTMMsgVoice textMsg = RTMMsgVoice.fromJson(jsonMap);
      msgEntity.content = (textMsg.duration ?? 0).toString();
    }
    StorageService.to.objectBoxMsg.insertOrUpdateMsg(msgEntity);
  }
}
