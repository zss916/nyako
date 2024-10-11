library rtc;

import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

part 'rtc.dart';
part 'widget/local_rtc.dart';
part 'widget/remote_rtc.dart';

/*   userJoined = (RtcConnection connection, int remoteUid, int elapsed) {
      _userJoined(connection, remoteUid, elapsed);
    };

    userOffline =
        (RtcConnection connection, int uid, UserOfflineReasonType reason) {
      _userOffline(connection, uid, reason);
    };

    connectionLost = (RtcConnection connection) {
      _connectionLost(connection);
    };

    remoteVideoStats = (RtcConnection connection, RemoteVideoStats stats) {
      _remoteVideoStats(connection, stats);
    };

    connectionBanned = (RtcConnection connection) {
      _connectionBanned(connection);
    };*/

// /// 对方进入
// void _userJoined(RtcConnection connection, int uid, int elapsed) {
//   // debugPrint("rtc _userJoined ===>  $uid");
//   // 这个判断是为了监控端可能进入
//   if (uid.toString() != herId) return;
//   if (hadBeginCall) return;
//   hadBeginCall = true;
//   _timerLink?.cancel();
//   _timerLink = null;
//   _refreshCall();
//   _beginTimer(rtmMsgCall);
//   connecting = false;
//   update();
//   AppPages.closeDialog();
// }
//
// /// 对方挂断
// void _userOffline(
//     RtcConnection connection, int uid, UserOfflineReasonType reason) {
//   // debugPrint("rtc _userOffline ==> $uid, ${reason.name}");
//   // 这个判断是为了监控端可能进入
//   if (uid.toString() != herId) return;
//   Get.dialog(AppDialogConfirm(
//     title: Tr.app_video_hang_up_tip.tr,
//     onlyConfirm: true,
//     callback: (int callback) {},
//   )).then((value) {
//     _endCall(reason == UserOfflineReasonType.userOfflineQuit
//         ? EndType2.otherHang
//         : EndType2.otherOff);
//   });
// }
//
// /// 对方视频状态
// void _remoteVideoStats(RtcConnection connection, RemoteVideoStats stats) {
//   // 这个判断是为了监控端可能进入
//   if (stats.uid.toString() != herId) return;
//   if ((stats.decoderOutputFrameRate ?? 0) <= 0) {
//     audioMode.value = true;
//     update();
//   } else {
//     audioMode.value = false;
//     update();
//   }
// }
//
// /// 连接中断
// void _connectionLost(RtcConnection connection) {
//   _endCall(EndType2.netErr);
// }
//
// void _connectionBanned(RtcConnection connection) {
//   _endCall(EndType2.hostBan);
// }
