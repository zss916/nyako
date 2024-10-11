import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BaseButton2 extends StatelessWidget {
  String title;

  BaseButton2(this.title, {super.key});

  TextStyle baseTextStyle = const TextStyle(
      color: Color(0xFF8239FF), fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 54,
      alignment: Alignment.center,
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [Colors.white, Color(0xFFFFCAF8)]),
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
