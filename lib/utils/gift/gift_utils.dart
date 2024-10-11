import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/agora/rtm_msg_sender.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/database/entity/app_msg_entity.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';

class GiftUtils {
  ///显示余额不足dialog
  static _toShowRecharge(GiftEntity gift, String anchorId) {
    if (gift.isPropGift != true) {
      int remain = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
      if (remain < (gift.diamonds ?? 0)) {
        // debugPrint("=====>>> sendChatGift");
        ChargeDialogManager.showChargeDialog(
            ChargePath.chating_send_gift_no_money,
            upid: anchorId,
            showBalanceText: true);
      }
    }
  }

  ///聊天发送礼物
  static sendChatGift(GiftEntity gift, String anchorId, {Function? success}) {
    _toShowRecharge(gift, anchorId);

    if (gift.isPropGift == true) {
      ///gift loading
      MsgEntity msg = _createMsgSending(anchorId, gift);
      var id = StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg);
      msg.id = id;

      CommonAPI.sendPackagesGift(
          receiverId: anchorId,
          gid: gift.gid,
          showLoading: false,
          errCall: () {
            ///gift fail
            Future.delayed(const Duration(seconds: 1), () {
              StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
                ..msgEventType = MsgEventType.sendErr
                ..sendState = 2);
            });
          }).then((value) {
        /// gift successful
        Future.delayed(const Duration(seconds: 1), () {
          msg.rawData =
              RtmMsgSender.makeRTMMsgGift(anchorId, gift, value.gid.toString());
          StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
            ..msgEventType = MsgEventType.sendDone
            ..sendState = 0);

          success?.call();
        });
      });
    } else {
      if (gift.isSendDiamondGift) {
        ///gift loading

        MsgEntity msg = _createMsgSending(anchorId, gift);
        var id = StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg);
        msg.id = id;

        CommonAPI.sendDiamondGift(
            receiverId: anchorId,
            gid: gift.gid,
            showLoading: false,
            errCall: () {
              /// gift fail
              Future.delayed(const Duration(seconds: 1), () {
                StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
                  ..msgEventType = MsgEventType.sendErr
                  ..sendState = 2);
              });
            }).then((value) {
          ///gift successful
          Future.delayed(const Duration(seconds: 1), () {
            msg.rawData = RtmMsgSender.makeRTMMsgGift(
                anchorId, gift, value.gid.toString());
            StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
              ..msgEventType = MsgEventType.sendDone
              ..sendState = 0);

            success?.call();
          });
        });
      }
    }
  }

  ///主播视频通话发送礼物
  static sendCallGift(GiftEntity gift, String anchorId,
      {Function? success, Function? fail, Function? onEnd}) {
    onEnd?.call();
    if (gift.vipVisible == 1 && UserInfo.to.myDetail!.isVip == 0) {
      sheetToVip(path: ChargePath.fake_gift_recharge, index: 0);
    } else {
      _toShowRecharge(gift, anchorId);
    }

    if (gift.isPropGift == true) {
      CommonAPI.sendPackagesGift(
          receiverId: anchorId,
          gid: gift.gid,
          errCall: () {
            fail?.call();
          }).then((value) {
        var json =
            RtmMsgSender.makeRTMMsgGift(anchorId, gift, value.gid.toString());
        var msg = MsgEntity(UserInfo.to.uid, anchorId, 0, 'gift',
            DateTime.now().millisecondsSinceEpoch, json, RTMMsgGift.typeCode,
            msgEventType: MsgEventType.sending, sendState: 1);
        StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
          ..msgEventType = MsgEventType.sendDone
          ..sendState = 0);

        success?.call();
      });
    } else {
      if (gift.isSendDiamondGift) {
        CommonAPI.sendDiamondGift(
            receiverId: anchorId,
            gid: gift.gid,
            errCall: () {
              fail?.call();
            }).then((value) {
          var json =
              RtmMsgSender.makeRTMMsgGift(anchorId, gift, value.gid.toString());
          var msg = MsgEntity(UserInfo.to.uid, anchorId, 0, 'gift',
              DateTime.now().millisecondsSinceEpoch, json, RTMMsgGift.typeCode,
              msgEventType: MsgEventType.sending, sendState: 1);
          StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
            ..msgEventType = MsgEventType.sendDone
            ..sendState = 0);

          success?.call();
        });
      }
    }
  }

  ///虚拟视频发送礼物
  static sendAivGift(GiftEntity gift, String anchorId, {Function? success}) {
    if (gift.isPropGift == true) {
      CommonAPI.sendPackagesGift(
              receiverId: anchorId, gid: gift.gid, isSystem: true)
          .then((value) {
        var json =
            RtmMsgSender.makeRTMMsgGift(anchorId, gift, value.gid.toString());
        var msg = MsgEntity(UserInfo.to.uid, anchorId, 0, 'gift',
            DateTime.now().millisecondsSinceEpoch, json, RTMMsgGift.typeCode,
            msgEventType: MsgEventType.sending, sendState: 1);
        StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
          ..msgEventType = MsgEventType.sendDone
          ..sendState = 0);
        success?.call();
      });
    } else {
      CommonAPI.sendDiamondGift(
              receiverId: anchorId, gid: gift.gid, isSystem: true)
          .then((value) {
        var json =
            RtmMsgSender.makeRTMMsgGift(anchorId, gift, value.gid.toString());
        var msg = MsgEntity(UserInfo.to.uid, anchorId, 0, 'gift',
            DateTime.now().millisecondsSinceEpoch, json, RTMMsgGift.typeCode,
            msgEventType: MsgEventType.sending, sendState: 1);
        StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
          ..msgEventType = MsgEventType.sendDone
          ..sendState = 0);
        success?.call();
      });
    }
  }

  ///创建发送状态消息
  static MsgEntity _createMsgSending(String anchorId, GiftEntity gift) {
    return MsgEntity(
        UserInfo.to.uid,
        anchorId,
        0,
        'gift',
        DateTime.now().millisecondsSinceEpoch,
        RtmMsgSender.makeRTMMsgGift(anchorId, gift, ''),
        RTMMsgGift.typeCode,
        msgEventType: MsgEventType.sending,
        sendState: 1);
  }
}
