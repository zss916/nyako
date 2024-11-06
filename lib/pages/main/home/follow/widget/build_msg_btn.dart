import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/home/index.dart';

class BuildMsgBtn extends StatelessWidget {
  final HomeLogic logic;
  final String anchorId;

  const BuildMsgBtn(this.anchorId, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => logic.startMsg(anchorId),
      child: Container(
        width: 60,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xFF81E0FF),
              Color(0xFF4AC6FF),
            ])),
        child: UnconstrainedBox(
          child: Image.asset(
            Assets.iconToMsgIcon,
            width: 24,
            height: 24,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }
}
