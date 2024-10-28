import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/generated/assets.dart';

class BuildAvatarBg extends StatelessWidget {
  const BuildAvatarBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Assets.jsonAnimaAvatarBg, width: 140, height: 140);
  }
}
