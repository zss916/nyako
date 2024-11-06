import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:nyako/agora/rtm/rtm_callback.dart';

class Rtm with RtmCallback {
  Rtm._internal();

  static final Rtm _instance = Rtm._internal();

  static Rtm get instance => _instance;

  int connectState = 0;
  int connectTimes = 0;
  AgoraRtmClient? _client;
  RemoteInvitation? _remoteInvitation;
  LocalInvitation? _localInvitation;

  initIM() {
    _init().then((_) => connectRtm());
  }

  Future _init() async {
    if (appId.isEmpty) return;
    _client = await AgoraRtmClient.createInstance(appId);
    var callManager = _client?.getRtmCallManager();
    _client?.onConnectionStateChanged2 =
        (RtmConnectionState state, RtmConnectionChangeReason reason) {
      switch (state) {
        case RtmConnectionState.disconnected:
          connectState = 0;
          break;
        case RtmConnectionState.connecting:
          connectState = 0;
          break;
        case RtmConnectionState.connected:
          //AppLog.debug("rtm connected!!!!! 😁");
          connectState = 1;
          break;
        case RtmConnectionState.reconnecting:
          connectState = 2;
          break;
        case RtmConnectionState.aborted:
          connectState = 2;
          break;
        default:
          break;
      }
    };

    ///token 失效
    _client?.onTokenExpired = onTokenExpired;

    ///收到点对点消息
    _client?.onMessageReceived = onMessageReceived;

    ///本地邀请收到
    callManager?.onLocalInvitationReceivedByPeer =
        (LocalInvitation localInvitation) {
      _localInvitation = localInvitation;
      onLocalInvitationReceivedByPeer.call(localInvitation);
    };

    ///本地邀请接受
    callManager?.onLocalInvitationAccepted =
        (LocalInvitation localInvitation, String response) {
      _localInvitation = localInvitation;
      onLocalInvitationAccepted.call(localInvitation, response);
    };

    ///本地邀请拒绝
    callManager?.onLocalInvitationRefused =
        (LocalInvitation localInvitation, String response) {
      onLocalInvitationRefused.call(localInvitation, response);
    };

    ///本地邀请取消
    callManager?.onLocalInvitationCanceled =
        (LocalInvitation localInvitation) async {
      cancelInvitation();
      onLocalInvitationCanceled.call(localInvitation);
    };

    ///本地邀请失败
    callManager?.onLocalInvitationFailure = onLocalInvitationFailure;

    /// 远端邀请接受
    callManager?.onRemoteInvitationReceived =
        (RemoteInvitation remoteInvitation) {
      _remoteInvitation = remoteInvitation;
      onRemoteInvitationReceived.call(remoteInvitation);
    };

    ///远端邀请接受
    callManager?.onRemoteInvitationAccepted = onRemoteInvitationAccepted;

    ///远端邀请拒绝
    callManager?.onRemoteInvitationRefused = onRemoteInvitationRefused;

    /// 远端邀请取消
    callManager?.onRemoteInvitationCanceled =
        (RemoteInvitation remoteInvitation) {
      onRemoteInvitationCanceled.call(remoteInvitation);
    };

    /// 远端邀请失败
    callManager?.onRemoteInvitationFailure = onRemoteInvitationFailure;

    ///收到错误事件
    callManager?.onError = onError;
  }

  /// 登录rtm
  void connectRtm() async {
    if (connectState == 0) {
      if (connectTimes < 3) {
        connectTimes++;
        if (_client != null) {
          //debugPrint("rtmToken: ${rtmToken}, uid:${uid} ");
          try {
            await _client?.login(rtmToken, uid);
          } on AgoraRtmClientException catch (e) {
            debugPrint(
                "rtm login failed: ${rtmToken}, uid:${uid} ,${e.reason}");
          } catch (e) {
            debugPrint("rtm login failed: ${rtmToken}, uid:${uid}");
          }
        }
      } else {
        connectTimes = 0;
        onRefreshToken();
      }
    }
  }

  ///接受邀请
  Future<bool> acceptInvitation() async {
    try {
      if (_remoteInvitation != null && _client != null) {
        await _client
            ?.getRtmCallManager()
            .acceptRemoteInvitation(_remoteInvitation!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///拒绝邀请
  Future<bool> rejectInvitation() async {
    try {
      if (_remoteInvitation != null && _client != null) {
        await _client
            ?.getRtmCallManager()
            .refuseRemoteInvitation(_remoteInvitation!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///发送邀请
  Future<bool> sendLocalInvitation(LocalInvitation localInvitation) async {
    try {
      await _client?.getRtmCallManager().sendLocalInvitation(localInvitation);
      return true;
    } catch (e) {
      return false;
    }
  }

  ///取消邀请
  Future<bool> cancelInvitation() async {
    try {
      if (_localInvitation != null) {
        await _client
            ?.getRtmCallManager()
            .cancelLocalInvitation(_localInvitation!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///发送消息
  Future<bool> sendRtmMsg(String peerId, RtmMessage msg) async {
    try {
      await _client?.sendMessageToPeer2(
          peerId,
          msg,
          SendMessageOptions(
              enableOfflineMessaging: true, enableHistoricalMessaging: false));
      return true;
    } catch (e) {
      return false;
    }
  }

  ///退出登录
  closeIM() {
    _client?.logout();
    _client == null;
  }

  ///释放
  releaseRtm() {
    _client?.release();
    _client == null;
  }
}
