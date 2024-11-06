import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Image.asset(
              Assets.iconSplashBg,
            ))
      ],
    );
  }
}
