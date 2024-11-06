import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';

class BuildVipImage extends StatelessWidget {
  final List<String> arr2 = [
    Assets.finalM0,
    Assets.finalM1,
    Assets.finalM2,
    Assets.finalM3,
    Assets.finalM4,
    Assets.finalM5,
    Assets.finalM6,
    Assets.finalM7,
    Assets.finalM8,
    Assets.finalM9,
  ];

  BuildVipImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Opacity(
          opacity: 0.5,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
            child: Image.asset(
              arr2[next2()],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  int next({int min = 1, int max = 3}) => min + Random().nextInt(max - min);

  int next2({int min = 0, int max = 10}) => min + Random().nextInt(max - min);
}
