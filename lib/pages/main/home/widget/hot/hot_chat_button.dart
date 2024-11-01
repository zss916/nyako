import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/generated/assets.dart';

class HotChatButton extends StatelessWidget {
  final bool isCall;

  const HotChatButton({super.key, required this.isCall});

  @override
  Widget build(BuildContext context) {
    return isCall
        ? RepaintBoundary(
            child: Lottie.asset(Assets.jsonAnimaCallBtn, width: 48, height: 48),
          )
        : Image.asset(
            Assets.iconHotMsg,
            width: 48,
            height: 48,
            matchTextDirection: true,
          );
  }
}
