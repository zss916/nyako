import 'dart:async';
import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/widget/long_press_gesture_detector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_loading.dart';

typedef AppUploadCallBack = Function(String duration, String localPath);

class AppVoiceRecord extends StatefulWidget {
  final Function? startRecord;
  final Function? stopRecord;
  final AppUploadCallBack? uploadCallBack;
  final EdgeInsets? margin;
  final Function? onClose;

  /// startRecord 开始录制回调  stopRecord回调
  const AppVoiceRecord(
      {Key? key,
      this.startRecord,
      this.stopRecord,
      this.uploadCallBack,
      this.margin,
      this.onClose})
      : super(key: key);

  @override
  State<AppVoiceRecord> createState() => _AppVoiceRecordState();
}

class _AppVoiceRecordState extends State<AppVoiceRecord> {
  // 倒计时总时长
  final int _countTotal = 60;
  bool isUp = false;
  String textShow = Tr.app_enter_speck.tr;
  String toastShow = Tr.app_loosen_stop.tr;

  ///默认隐藏状态
  bool voiceState = true;
  OverlayEntry? overlayEntry;
  bool canSend = false;
  var dragToDeleteView = false;
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();

  StreamSubscription? _recorderSubscription;
  final Codec _codec = Codec.pcm16WAV;
  String _mPath = '';
  int seconds = 0;
  String text = '00:00';
  double startY = 0.0;
  double offset = 0.0;

  //bool outTimeSend = false;

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openRecorder();
    await _mRecorder!
        .setSubscriptionDuration(const Duration(milliseconds: 100));
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  @override
  void initState() {
    super.initState();
    openTheRecorder();
  }

  ///显示录音悬浮布局
  buildOverLayView(BuildContext context, {bool refresh = false}) {
    if (overlayEntry != null && refresh) {
      overlayEntry?.markNeedsBuild();
      return;
    }
    overlayEntry?.remove();
    overlayEntry = null;
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (content) {
        bool isUp = dragToDeleteView;
        canSend = !isUp;
        return IgnorePointer(
          ignoring: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 255,
                height: 214,
                decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.75),
                    borderRadius: BorderRadius.circular(25)),
                margin: const EdgeInsetsDirectional.only(bottom: 50),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 124,
                      height: 63,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              matchTextDirection: true,
                              fit: BoxFit.fill,
                              image: AssetImage(isUp == true
                                  ? Assets.iconVoiceRecordStopBg
                                  : Assets.iconVoiceRecordingBg))),
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsetsDirectional.only(bottom: 7),
                      child: isUp == true
                          ? Image.asset(
                              Assets.iconVoiceStop,
                              width: 30,
                              height: 30,
                              matchTextDirection: true,
                            )
                          : RepaintBoundary(
                              child: Lottie.asset(
                                Assets.jsonAnimaVoiceRecording,
                                width: 43,
                                height: 18,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      textShow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConstants.fontsRegular,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  void showVoiceView() {
    setState(() {
      textShow = Tr.app_loosen_stop.tr;
      voiceState = false;
    });

    ///显示录音悬浮布局
    buildOverLayView(context);

    record();
  }

  void hideVoiceView() {
    /* if (outTimeSend) return;
    outTimeSend = false;*/
    if (seconds < 1) {
      isUp = true;
    }

    setState(() {
      textShow = Tr.app_enter_speck.tr;
      voiceState = true;
    });

    stopRecorder();
    Timer.run(() {
      if (overlayEntry != null) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
    });
  }

  void moveVoiceView() {
    bool isUpNow = dragToDeleteView;
    if (isUp == isUpNow) return;
    setState(() {
      isUp = isUpNow;
      if (isUp) {
        textShow = Tr.app_cancel_send.tr;
        toastShow = textShow;
      } else {
        textShow = Tr.app_loosen_stop.tr;
        toastShow = Tr.app_voice_send.tr;
      }
      buildOverLayView(context, refresh: true);
    });
  }

  void record() async {
    Directory directory = await getApplicationDocumentsDirectory();
    _mPath = "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.wav";
    await _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: AudioSource.microphone,
      bitRate: 8000,
      numChannels: 1,
      sampleRate: (_codec == Codec.pcm16) ? 44000 : 8000,
    )
        .then((value) {
      setState(() {});
      if (widget.startRecord != null) widget.startRecord!();

      _recorderSubscription = _mRecorder!.onProgress!.listen((e) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);

        seconds = e.duration.inSeconds;
        text = DateFormat('mm:ss').format(date);
        if (seconds == _countTotal) {
          hideVoiceView();
          // outTimeSend = true;
        } else {
          buildOverLayView(context, refresh: true);
        }
      });
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      bool timeEnough = seconds >= 1;
      if (canSend) {
        if (_mPath.isNotEmpty && timeEnough) {
          widget.uploadCallBack?.call(seconds.toString(), _mPath);
        } else if (timeEnough) {
          AppLoading.toast(Tr.app_order_failed.tr);
        }
      }
      canSend = false;
      if (widget.stopRecord != null) {
        widget.stopRecord!(_mPath, seconds);
      }

      if (_recorderSubscription != null) {
        _recorderSubscription!.cancel();
        _recorderSubscription = null;
      }

      if (overlayEntry != null) {
        overlayEntry?.remove();
        overlayEntry = null;
      }
    });
  }

  final itKey = GlobalKey();

  bool isPress = false;

  @override
  Widget build(BuildContext context) {
    return LongPressGestureDetector(
        onLongPress: () {
          dragToDeleteView = false;
          isUp = false;
          showVoiceView();
          setState(() {
            isPress = true;
          });
        },
        /*onLongPressDown: (d) {
                  dragToDeleteView = false;
                  isUp = false;
                  showVoiceView();
                },*/
        onLongPressMoveUpdate: (detail) {
          offset = detail.globalPosition.dy;
          dragToDeleteView =
              (offset != 0 && startY - offset > 100) ? true : false;
          moveVoiceView();
        },
        onLongPressStart: (d) {
          startY = d.globalPosition.dy;
        },
        onLongPressEnd: (detail) {
          hideVoiceView();
          startY = 0.0;
          offset = 0.0;
          setState(() {
            isPress = false;
          });
        },
        onLongPressCancel: () {
          hideVoiceView();
          setState(() {
            isPress = false;
          });
        },
        child: Container(
          key: itKey,
          margin: const EdgeInsetsDirectional.only(
              start: 2, end: 2, top: 3, bottom: 10),
          padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
          decoration: BoxDecoration(
              color:
                  isPress ? const Color(0xFFF5F4F6) : const Color(0xFFAE71FF),
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          height: 48,
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          child: Text(
            Tr.app_enter_speck.tr,
            style: TextStyle(
                color: isPress ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ));
  }

  @override
  void dispose() {
    _mRecorder!.closeRecorder();
    _mRecorder = null;

    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
    super.dispose();
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}
