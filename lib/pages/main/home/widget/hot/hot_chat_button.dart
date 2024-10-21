import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class HotChatButton extends StatelessWidget {
  final bool isCall;

  const HotChatButton({super.key, required this.isCall});

  @override
  Widget build(BuildContext context) {
    return isCall
        ? Container(
            width: 48,
            height: 48,
            child: Center(
              child: RepaintBoundary(
                child: Image.asset(
                  Assets.iconHotCall,
                  width: 48,
                  height: 48,
                  matchTextDirection: true,
                ),
              ),
            ),
          )
        : Image.asset(
            Assets.iconHotMsg,
            width: 48,
            height: 48,
            matchTextDirection: true,
          );
  }
}
