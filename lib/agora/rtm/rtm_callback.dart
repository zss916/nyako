import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:nyako/pages/call/remote/index.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_check_calling_util.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/agora/rtm_msg_handler.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/http/index.dart';

mixin class RtmCallback {
  String get appId => UserInfo.to.config?.agoraAppId ?? "";

  String? get rtmToken => UserInfo.to.token?.rtmToken;

  String get uid => UserInfo.to.userLogin?.userId ?? "";

  /// 刷新rtmToken再登录
  void onRefreshToken() {
    Http.instance
        .post<String>(
      NetPath.genRtmToken,
    )
        .then((value) {
      UserInfo.to.token?.rtmToken = value;
      Rtm.instance.connectRtm();
    });
  }

  ///token 失效
  void onTokenExpired() {
    onRefreshToken();
  }

  ///接收到消息
  void onMessageReceived(RtmMessage message, String peerId) {
    handleMsg(message, peerId);
  }

  void onLocalInvitationReceivedByPeer(LocalInvitation localInvitation) {}

  void onLocalInvitationAccepted(
      LocalInvitation localInvitation, String response) {
    StorageService.to.eventBus.fire(EventRtmCall(1, invite: localInvitation));
  }

  void onLocalInvitationRefused(
      LocalInvitation localInvitation, String response) {
    debugPrint("onLocalInvitationRefused response:${response}");

    StorageService.to.eventBus.fire(EventRtmCall(2, invite: localInvitation));
  }

  void onLocalInvitationCanceled(LocalInvitation localInvitation) {}

  void onLocalInvitationFailure(
      LocalInvitation localInvitation, int errorCode) {}

  void onRemoteInvitationAccepted(RemoteInvitation remoteInvitation) {}

  void onRemoteInvitationRefused(RemoteInvitation remoteInvitation) {}

  void onRemoteInvitationCanceled(RemoteInvitation remoteInvitation) {
    StorageService.to.eventBus
        .fire(EventRtmCall(3, herInvite: remoteInvitation));
  }

  ///远端邀请接收到
  void onRemoteInvitationReceived(RemoteInvitation remoteInvitation) {
    if (AppConstants.isFakeMode) {
      return;
    }
    if (!AppCheckCallingUtil.checkCanBeCalled()) {
      Rtm.instance.rejectInvitation();
      return;
    }
    RemoteLogic.startMe(remoteInvitation.callerId, remoteInvitation.channelId!,
        remoteInvitation.content ?? '');
  }

  void onRemoteInvitationFailure(
      RemoteInvitation remoteInvitation, int errorCode) {}

  void onError(dynamic error) {}

  ///发送本地邀请
  void sendInvitation(String calleeId, String channelId,
      {String? content, int? aiType}) {
    final invite = LocalInvitation.fromJson({
      'calleeId': calleeId,
      'content': content ?? "",
      'channelId': channelId,
    });
    Rtm.instance.sendLocalInvitation(invite);
  }
}
