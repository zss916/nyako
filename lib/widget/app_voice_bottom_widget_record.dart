// import 'dart:async';
// import 'dart:io';
//
// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:oliapro/common/language_key.dart';
// import 'package:oliapro/generated/assets.dart';
// import 'package:oliapro/widget/long_press_gesture_detector.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../utils/app_loading.dart';
//
// typedef AppUploadCallBack = Function(String duration, String localPath);
//
// class AppVoiceBottomWidgetRecord extends StatefulWidget {
//   final Function? startRecord;
//   final Function? stopRecord;
//   final AppUploadCallBack? uploadCallBack;
//   final EdgeInsets? margin;
//   final Function? onClose;
//
//   /// startRecord 开始录制回调  stopRecord回调
//   const AppVoiceBottomWidgetRecord(
//       {Key? key,
//       this.startRecord,
//       this.stopRecord,
//       this.uploadCallBack,
//       this.margin,
//       this.onClose})
//       : super(key: key);
//
//   @override
//   State<AppVoiceBottomWidgetRecord> createState() =>
//       _AppVoiceBottomWidgetRecordState();
// }
//
// class _AppVoiceBottomWidgetRecordState
//     extends State<AppVoiceBottomWidgetRecord> {
//   // 倒计时总时长
//   int _countTotal = 60;
//   double keyBordHeight = 278;
//   bool isUp = false;
//   String textShow = Tr.app_enter_speck.tr;
//   String toastShow = Tr.app_loosen_stop.tr;
//
//   ///默认隐藏状态
//   bool voiceState = true;
//   OverlayEntry? overlayEntry;
//   bool canSend = false;
//   var dragToDeleteView = false;
//   FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
//
//   StreamSubscription? _recorderSubscription;
//   final Codec _codec = Codec.pcm16WAV;
//   String _mPath = '';
//   int seconds = 0;
//   String text = '00:00';
//   double startY = 0.0;
//   double offset = 0.0;
//
//   //bool outTimeSend = false;
//
//   Future<void> openTheRecorder() async {
//     var status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Microphone permission not granted');
//     }
//     await _mRecorder!.openRecorder();
//     await _mRecorder!
//         .setSubscriptionDuration(const Duration(milliseconds: 100));
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     openTheRecorder();
//   }
//
//   ///显示录音悬浮布局
//   buildOverLayView(BuildContext context, {bool refresh = false}) {
//     if (overlayEntry != null && refresh) {
//       overlayEntry?.markNeedsBuild();
//       return;
//     }
//     overlayEntry?.remove();
//     overlayEntry = null;
//     if (overlayEntry == null) {
//       overlayEntry = OverlayEntry(builder: (content) {
//         bool isUp = dragToDeleteView;
//         canSend = !isUp;
//         return IgnorePointer(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             color: Colors.transparent,
//             child: Center(
//               child: Container(
//                 width: 225,
//                 height: 180,
//                 decoration: BoxDecoration(
//                     color: const Color(0xFF090909).withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(30)),
//                 margin: const EdgeInsetsDirectional.only(bottom: 100),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text(
//                       text,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       width: 124,
//                       height: 63,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               matchTextDirection: true,
//                               fit: BoxFit.fill,
//                               image: AssetImage(isUp == true
//                                   ? Assets.imgVoiceRecordStopBg
//                                   : Assets.imgVoiceRecordingBg))),
//                       alignment: AlignmentDirectional.center,
//                       margin: const EdgeInsets.only(bottom: 5),
//                       padding: const EdgeInsetsDirectional.only(bottom: 7),
//                       child: isUp == true
//                           ? Image.asset(
//                               Assets.imgVoiceStop,
//                               width: 32,
//                               height: 32,
//                               matchTextDirection: true,
//                             )
//                           : RepaintBoundary(
//                               child: Image.asset(
//                                 Assets.animaVoiceRecording,
//                                 width: 43,
//                                 height: 18,
//                                 matchTextDirection: true,
//                               ),
//                             ),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Text(
//                       textShow,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Color(0xFFC8C8C8),
//                         fontSize: 12,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
//       Overlay.of(context).insert(overlayEntry!);
//     }
//   }
//
//   void showVoiceView() {
//     setState(() {
//       textShow = Tr.app_loosen_stop.tr;
//       voiceState = false;
//     });
//
//     ///显示录音悬浮布局
//     buildOverLayView(context);
//
//     record();
//   }
//
//   void hideVoiceView() {
//     /* if (outTimeSend) return;
//     outTimeSend = false;*/
//     if (seconds < 1) {
//       isUp = true;
//     }
//
//     setState(() {
//       textShow = Tr.app_enter_speck.tr;
//       voiceState = true;
//     });
//
//     stopRecorder();
//     Timer.run(() {
//       if (overlayEntry != null) {
//         overlayEntry?.remove();
//         overlayEntry = null;
//       }
//     });
//   }
//
//   void moveVoiceView() {
//     bool isUpNow = dragToDeleteView;
//     if (isUp == isUpNow) return;
//     setState(() {
//       isUp = isUpNow;
//       if (isUp) {
//         textShow = Tr.app_cancel_send.tr;
//         toastShow = textShow;
//       } else {
//         textShow = Tr.app_loosen_stop.tr;
//         toastShow = Tr.app_voice_send.tr;
//       }
//       buildOverLayView(context, refresh: true);
//     });
//   }
//
//   void record() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     _mPath = "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.wav";
//     await _mRecorder!
//         .startRecorder(
//       toFile: _mPath,
//       codec: _codec,
//       audioSource: AudioSource.microphone,
//       bitRate: 8000,
//       numChannels: 1,
//       sampleRate: (_codec == Codec.pcm16) ? 44000 : 8000,
//     )
//         .then((value) {
//       setState(() {});
//       if (widget.startRecord != null) widget.startRecord!();
//
//       _recorderSubscription = _mRecorder!.onProgress!.listen((e) {
//         var date = DateTime.fromMillisecondsSinceEpoch(
//             e.duration.inMilliseconds,
//             isUtc: true);
//
//         seconds = e.duration.inSeconds;
//         text = DateFormat('mm:ss').format(date);
//         if (seconds == _countTotal) {
//           hideVoiceView();
//           // outTimeSend = true;
//         } else {
//           buildOverLayView(context, refresh: true);
//         }
//       });
//     });
//   }
//
//   void stopRecorder() async {
//     await _mRecorder!.stopRecorder().then((value) {
//       bool timeEnough = seconds >= 1;
//       if (canSend) {
//         if (_mPath.isNotEmpty && timeEnough) {
//           widget.uploadCallBack?.call(seconds.toString(), _mPath);
//         } else if (timeEnough) {
//           AppLoading.toast(Tr.app_order_failed.tr);
//         }
//       }
//       canSend = false;
//       if (widget.stopRecord != null) {
//         widget.stopRecord!(_mPath, seconds);
//       }
//
//       if (_recorderSubscription != null) {
//         _recorderSubscription!.cancel();
//         _recorderSubscription = null;
//       }
//
//       if (overlayEntry != null) {
//         overlayEntry?.remove();
//         overlayEntry = null;
//       }
//     });
//   }
//
//   final itKey = GlobalKey();
//
//   double _scale = 1;
//
//   updateState({double scale = 1}) {
//     if (mounted) {
//       setState(() {
//         _scale = scale;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       key: itKey,
//       width: double.maxFinite,
//       height: keyBordHeight,
//       decoration: const BoxDecoration(
//         color: Color(0xFF1E1226),
//       ),
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               LongPressGestureDetector(
//                 onLongPress: () {
//                   dragToDeleteView = false;
//                   isUp = false;
//                   showVoiceView();
//
//                   updateState(scale: 1.2);
//                 },
//                 /*onLongPressDown: (d) {
//                   dragToDeleteView = false;
//                   isUp = false;
//                   showVoiceView();
//                 },*/
//                 onLongPressMoveUpdate: (detail) {
//                   offset = detail.globalPosition.dy;
//                   dragToDeleteView =
//                       (offset != 0 && startY - offset > 100) ? true : false;
//                   moveVoiceView();
//                   updateState(scale: 1.2);
//                 },
//                 onLongPressStart: (d) {
//                   startY = d.globalPosition.dy;
//                   updateState(scale: 1.2);
//                 },
//                 onLongPressEnd: (detail) {
//                   hideVoiceView();
//                   startY = 0.0;
//                   offset = 0.0;
//                   updateState(scale: 1);
//                 },
//                 onLongPressCancel: () {
//                   hideVoiceView();
//                   updateState(scale: 1);
//                 },
//                 child: Transform.scale(
//                   scale: _scale,
//                   child: Image.asset(
//                     Assets.imgVoiceMike,
//                     width: 85,
//                     height: 85,
//                     matchTextDirection: true,
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsetsDirectional.only(top: 15),
//                 child: Text(
//                   textShow,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _mRecorder!.closeRecorder();
//     _mRecorder = null;
//
//     if (_recorderSubscription != null) {
//       _recorderSubscription!.cancel();
//       _recorderSubscription = null;
//     }
//     super.dispose();
//     if (overlayEntry != null) {
//       overlayEntry?.remove();
//       overlayEntry = null;
//     }
//   }
// }
