import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/index.dart';

class BuildMsgBtn extends StatelessWidget {
  final HomeLogic logic;
  final String anchorId;

  const BuildMsgBtn(this.anchorId, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => logic.startMsg(anchorId),
      child: Image.asset(
        Assets.imgHotMsgIcon,
        width: 44,
        height: 44,
        matchTextDirection: true,
      ),
    );
  }
}
