import 'package:flutter/material.dart';
import 'package:nyako/pages/main/main/index.dart';
import 'package:nyako/pages/main/match/index.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/utils/app_extends.dart';

class MusicBgm extends StatefulWidget {
  final MatchLogic logic;

  final Widget child;

  const MusicBgm(this.logic, {Key? key, required this.child}) : super(key: key);

  @override
  _MusicBgmState createState() => _MusicBgmState();
}

class _MusicBgmState extends State<MusicBgm>
    with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    super.initState();
    widget.logic.initBgm();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.logic.stopBgm();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // debugPrint("===>>> didPopNext");
    if (ARoutes.isMainPage) {
      widget.logic.resumeBgm();
    }
  }

  @override
  void didPushNext() {
    super.didPushNext();
    widget.logic.stopBgm();
    //debugPrint("===>>> didPushNext");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        widget.logic.setVolume(0);
        widget.logic.stopBgm();
        break;
      case AppLifecycleState.resumed:
        int select = (safeFind<MainLogic>()?.currentIndex) ?? 0;
        // debugPrint("select  ===>>> ${select}");
        if (ARoutes.isMainPage && select == 2) {
          widget.logic.setVolume(1);
          widget.logic.playBgm();
        }
        break;
      case AppLifecycleState.paused:
        widget.logic.setVolume(0);
        widget.logic.stopBgm();
        break;
      case AppLifecycleState.detached:
        widget.logic.setVolume(0);
        widget.logic.stopBgm();
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
