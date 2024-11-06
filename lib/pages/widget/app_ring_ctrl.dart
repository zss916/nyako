import 'package:nyako/common/app_constants.dart';
import 'package:nyako/utils/app_voice_player.dart';
import 'package:nyako/utils/music/app_ring_manager.dart';
import 'package:flutter/material.dart';

class AppRingCtrl extends StatefulWidget {
  final Widget child;

  const AppRingCtrl(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppRingCtrl> createState() => _AppRingCtrlState();
}

class _AppRingCtrlState extends State<AppRingCtrl> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        if (AppConstants.isBeCall) {
          //AppAudioCenter.setVolume(0);
          AppRingManager.instance.pauseRing();
        } else {
          AppRingManager.instance.stopPlayRing();
        }
        AppAudioPlayer().stop();
        break;
      case AppLifecycleState.resumed:
        if (AppConstants.isBeCall) {
          // AppAudioCenter.setVolume(1);
          AppRingManager.instance.resumeRing();
        }
        break;
      case AppLifecycleState.detached:
        AppRingManager.instance.stopPlayRing();
        break;
      case AppLifecycleState.inactive:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
