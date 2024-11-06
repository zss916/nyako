import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final double? w;
  final double? h;
  final double r;

  const CommonButton(this.title, this.r, {super.key, this.w, this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF9341FF),
        borderRadius: BorderRadiusDirectional.circular(30),
      ),
      child: AutoSizeText(
        title,
        maxFontSize: 12,
        minFontSize: 6,
        maxLines: 1,
        style: TextStyle(
            color: Colors.white,
            fontFamily: AppConstants.fontsBold,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
