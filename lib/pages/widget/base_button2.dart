import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BaseButton2 extends StatelessWidget {
  final String title;

  const BaseButton2(this.title, {super.key});

  final TextStyle baseTextStyle = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 54,
      alignment: Alignment.center,
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF9341FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: AutoSizeText(
        title,
        maxFontSize: 16,
        minFontSize: 8,
        maxLines: 1,
        style: baseTextStyle,
      ),
    );
  }
}
