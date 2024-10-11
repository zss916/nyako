import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/widget/text_with_border.dart';

final String title = Tr.app_invite_friend.tr;

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      text: title,
      textStyle: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        shadows: [
          Shadow(
            offset: Offset(0, 2),
            blurRadius: 6.0,
            color: Colors.transparent,
          ),
        ],
        fontWeight: FontWeight.bold,
      ),
      strokeColor: Colors.transparent,
      strokeWidth: 3,
    );
  }
}
