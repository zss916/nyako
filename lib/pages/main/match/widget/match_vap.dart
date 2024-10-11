import 'package:flutter/material.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';

class MatchVap extends StatefulWidget {
  // final MatchLogic logic;

  final Function? onFinish;
  const MatchVap({Key? key, this.onFinish}) : super(key: key);

  @override
  _MatchVapState createState() => _MatchVapState();
}

class _MatchVapState extends State<MatchVap> {
  AppVapController myVapController = AppVapController();

  @override
  void initState() {
    super.initState();
    setState(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        // myVapController.playAssets(Assets.matchMatchVap);
      });
    });
  }

  @override
  void dispose() {
    // myVapController.state?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      // color: Colors.white30,
      // width: Get.width,
      // height: Get.height,
      /*child: AppVapPlayer(
        vapController: myVapController,
        onFinish: () {
          widget.onFinish?.call();
        },
      ),*/
    );
  }
}
