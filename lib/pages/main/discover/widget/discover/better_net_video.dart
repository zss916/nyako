import 'dart:async';

import 'package:better_player/better_player.dart';
//import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_check_calling_util.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class BetterNetVideo extends StatefulWidget {
  final String video;
  final double width;
  final double height;

  const BetterNetVideo(this.video, this.width, this.height, {super.key});

  @override
  State<BetterNetVideo> createState() => _BetterNetVideoState();
}

class _BetterNetVideoState extends State<BetterNetVideo>
    with WidgetsBindingObserver {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  late VoidCallback listener;
  late final StreamSubscription<String> sub;
  late bool isPlay = true;
  late bool pause = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ScreenProtector.preventScreenshotOn();
    WakelockPlus.enable();
    super.initState();
    initVideoCtrl();
    listener = () {
      var value = _betterPlayerController.videoPlayerController!.value;
      double playedPartPercent =
          value.position.inMilliseconds / value.duration!.inMilliseconds;
      if (playedPartPercent.isNaN) {
        playedPartPercent = 0;
      }
      setState(() {
        isPlay = _betterPlayerController.isPlaying() ?? false;
      });
    };

    /// event bus 监听
    sub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == 'pauseDiscover') {
        pause = true;
        if (isPlay) {
          setState(() {
            _betterPlayerController.pause();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    sub.cancel();
    _betterPlayerController.videoPlayerController?.removeListener(listener);
    _betterPlayerController.pause();
    _betterPlayerController.dispose();
    super.dispose();
    WakelockPlus.disable();
    ScreenProtector.preventScreenshotOff();
  }

  initVideoCtrl() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      looping: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableMute: false,
        enableAudioTracks: false,
        enableFullscreen: false,
        enableOverflowMenu: false,
        enableSubtitles: false,
        enableQualities: false,
        enablePip: false,
        enablePlaybackSpeed: false,
        enablePlayPause: false,
        enableRetry: false,
        enableSkips: false,
        enableProgressBar: false,
        enableProgressBarDrag: false,
        enableProgressText: false,
        playerTheme: BetterPlayerTheme.custom,
        controlBarColor: Colors.transparent,
        showControlsOnInitialize: false,
      ),
      aspectRatio: 0.5,
      fit: BoxFit.cover,
    );
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
        key: widget.video,
      ),
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setControlsAlwaysVisible(true);
    _betterPlayerController.setControlsEnabled(true);
    super.initState();
    _betterPlayerController.setupDataSource(_betterPlayerDataSource).then((d) {
      if (!mounted) return;
      _betterPlayerController.videoPlayerController?.addListener(listener);
      setState(() {
        if (AppCheckCallingUtil.checkCalling() ||
            !ARoutes.isMainPage ||
            pause) {
          _betterPlayerController.pause();
        } else {
          _betterPlayerController.play();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.circular(0),
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: _betterPlayerController.isVideoInitialized() == true
              ? GestureDetector(
                  onTap: () {
                    if (_betterPlayerController.isPlaying() == true) {
                      _betterPlayerController.pause();
                    } else {
                      _betterPlayerController.play();
                    }
                  },
                  child: SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        BetterPlayer(controller: _betterPlayerController),
                        if (!isPlay)
                          const Center(
                            child: Icon(
                              Icons.play_circle_outlined,
                              color: Colors.black,
                              size: 100,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        _betterPlayerController.play();
        break;
      case AppLifecycleState.paused:
        if (isPlay) {
          _betterPlayerController.pause();
        }
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }
}
