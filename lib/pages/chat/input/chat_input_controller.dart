import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/agora/rtm_msg_sender.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/widget/app_voice_widget_record.dart';

import '../../../common/charge_path.dart';
import '../../../database/entity/app_msg_entity.dart';
import '../../../services/storage_service.dart';
import '../../../services/user_info.dart';
import '../../../utils/image_update/app_choose_image_util.dart';

class ChatInputController extends GetxController {
  final String userId;
  final String tag;

  ChatInputController(this.userId, {required this.tag});

  late final AppUpLoadCallBack upLoadCallBack;
  late String myId;
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  late AppUploadCallBack voiceRecord;

  final isShowEmoji = false.obs;
  final isShowRecord = false.obs;
  late ChatLogic _chatController;

  @override
  void onInit() {
    super.onInit();
    myId = UserInfo.to.userLogin?.userId ?? "";
    initImageHandler();
    initVoiceHandler();
  }

  @override
  void onReady() {
    super.onReady();
    _chatController = Get.find<ChatLogic>(tag: tag);
  }

  void onPointerDown() {
    isShowEmoji.value = false;
    isShowRecord.value = false;
    hideKeyboard();
  }

  ///隐藏键盘
  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  // 发送文字消息
  void sendTextMsg() {
    if (!_chatController.canSendMsg()) {
      askVip(anchorId: userId);
      return;
    }
    var str = textEditingController.text;
    if (str.isEmpty) return;
    var json = RtmMsgSender.makeRTMMsgText(userId, str);
    var msg = MsgEntity(myId, userId, 0, str,
        DateTime.now().millisecondsSinceEpoch, json, RTMMsgText.typeCode,
        msgEventType: MsgEventType.sending, sendState: 1);
    textEditingController.clear();
    // 有敏感词或者3个数字，假发送
    bool hasSenstiveWord = false;
    List<String> containSensitiveWord = [];
    UserInfo.to.sensitiveList?.forEach((element) {
      String eleString = element;
      if (str.toLowerCase().contains(eleString.toLowerCase()) == true) {
        hasSenstiveWord = true;
        containSensitiveWord.add(element);
      }
    });
    RegExp rep = RegExp(r"\d{4,}");
    bool hasContinuousNum = rep.hasMatch(str);
    //输入了敏感词或者3个相邻的数字 直接存本地 不存在实际发送
    if (hasSenstiveWord == true || hasContinuousNum == true) {
      StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
        ..msgEventType = MsgEventType.none
        ..sendState = 0);
      Http.instance.post<void>(NetPath.uploadSensitiveRecord,
          data: {"targetId": userId, "sendAuth": "0", "payload": str});
      // costFeeForMsg(msg);
      return;
    }
    StorageService.to.eventBus.fire(msg);

    Http.instance.post<void>(NetPath.rtmServerSendApi, data: {
      "recipientId": userId,
      "payload": json,
    }, errCallback: (err) {
      StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
        ..msgEventType = MsgEventType.sendErr
        ..sendState = 2);
      StorageService.to.eventBus.fire(msg);
      if (err.code == 8) {
        ChargeDialogManager.showChargeDialog(ChargePath.chating_click_recharge,
            upid: userId, showBalanceText: true);
      } else if (err.code == 28) {
        askVip(anchorId: userId);
      }
    }).then((value) {
      StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
        ..msgEventType = MsgEventType.sendDone
        ..sendState = 0);
      StorageService.to.eventBus.fire(msg);
      // _chatController.minusFreeMsg();
    });
  }

  void askVip({String? anchorId, int index = 1}) => sheetToVip(
      path: ChargePath.rtm_msg_send_no_money, upid: anchorId, index: index);

  void initVoiceHandler() {
    voiceRecord = (String duration, String localPath) {
      var msg = MsgEntity(myId, userId, 0, duration,
          DateTime.now().millisecondsSinceEpoch, '', RTMMsgVoice.typeCodes[0],
          msgEventType: MsgEventType.uploading, sendState: 1);
      msg.extra = localPath;

      Http.instance.post<String>(NetPath.s3UploadUrl, data: {'endType': '.wav'},
          errCallback: (err) {
        AppLoading.toast(err.message);
      }, showLoading: false).then((url) {
        uploadFile(File(localPath), url).then((value) {
          var realUrl = url.split('?')[0];
          if (value == 200) {
            var json = RtmMsgSender.makeRTMMsgVoice(
              userId,
              realUrl,
              int.parse(duration),
              msg,
            );
            msg.msgEventType = MsgEventType.sending;
            msg.sendState = 1;
            StorageService.to.eventBus.fire(msg);

            Http.instance.post<void>(NetPath.rtmServerSendApi,
                showLoading: false,
                data: {
                  "recipientId": userId,
                  "payload": json,
                }, errCallback: (err) {
              StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
                ..msgEventType = MsgEventType.sendErr
                ..sendState = 2);
              if (err.code == 8) {
                ChargeDialogManager.showChargeDialog(
                  ChargePath.chating_click_recharge,
                  upid: userId,
                );
              } else if (err.code == 28) {
                sheetToVip(path: ChargePath.chating_click_recharge, index: 0);
              }
            }).then((value) {
              StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
                ..msgEventType = MsgEventType.sendDone
                ..sendState = 0);
            });
          }
        });
      });
    };
  }

  Future<int> uploadFile(File file, String uri) async {
    var req = await HttpClient().putUrl(Uri.parse(uri));
    req.headers.add('Content-Type', 'audio/wav');
    req.headers.add('Accept', '*/*');
    req.headers.add('Connection', 'keep-alive');
    // 读文件
    req.bufferOutput = true;
    var s = await file.open();
    var x = 0;
    var size = file.lengthSync();
    req.headers.add('Content-Length', size.toString());
    var chunkSize = 65536;
    while (x < size) {
      var len = size - x >= chunkSize ? chunkSize : size - x;
      var val = s.readSync(len).toList();
      x = x + len;
      req.add(val);
      await req.flush();
    }
    await s.close();

    // 文件发送完成
    await req.close();
    // 获取返回数据
    final response = await req.done;
    // 其它处理逻辑
    // print("response statusCode: ${response.statusCode}");
    return response.statusCode;
  }

  void initImageHandler() {
    upLoadCallBack = (uploader, type, url, path) {
      switch (type) {
        case AppUploadType.cancel:
          {}
          break;
        case AppUploadType.begin:
          var msg = MsgEntity(
              myId,
              userId,
              0,
              'image',
              DateTime.now().millisecondsSinceEpoch,
              '',
              RTMMsgPhoto.typeCodes[0],
              msgEventType: MsgEventType.uploading,
              sendState: 1);
          msg.extra = path;
          StorageService.to.eventBus.fire(msg);
          uploader.msg = msg;
          break;
        case AppUploadType.success:
          var json = RtmMsgSender.makeRTMMsgImage(userId, url!);
          var msg = uploader.msg!;
          msg.rawData = json;
          msg.msgEventType = MsgEventType.sending;
          msg.sendState = 1;
          // StorageService.to.eventBus.fire(msg);
          Http.instance.post<void>(NetPath.rtmServerSendApi, data: {
            "recipientId": userId,
            "payload": json,
          }, errCallback: (err) {
            StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
              ..msgEventType = MsgEventType.sendErr
              ..sendState = 2);
            if (err.code == 8) {
              ChargeDialogManager.showChargeDialog(
                  ChargePath.chating_click_recharge,
                  upid: userId,
                  showBalanceText: true);
            } else if (err.code == 28) {
              sheetToVip(path: ChargePath.chating_click_recharge, index: 0);
            }
          }).then((value) {
            StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg
              ..msgEventType = MsgEventType.sendDone
              ..sendState = 0);
          });
          break;
        case AppUploadType.failed:
          {}
          break;
      }
    };
  }
}
