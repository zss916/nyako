import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nyako/common/app_colors.dart';

class BaseButton3 extends StatelessWidget {
  final String title;

  const BaseButton3(this.title, {super.key});

  final TextStyle baseTextStyle = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 52,
      alignment: Alignment.center,
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: AppColors.btnGradientF,
          // border: Border.all(width: 2, color: const Color(0xFFFF3978)),
          borderRadius: BorderRadiusDirectional.circular(80)),
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
