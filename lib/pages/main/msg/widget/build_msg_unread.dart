import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';

class BuildMsgUnRead extends StatelessWidget {
  final int count;
  const BuildMsgUnRead(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return buildContent(count);
  }

  Widget buildContent(int count) {
    return switch (count) {
      _ when (count > 0 && count < 10) => Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            color: const Color(0xFFFF2A48),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$count',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: AppConstants.fontsRegular,
            ),
          ),
        ),
      _ when (count >= 10 && count < 100) => Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 0),
          clipBehavior: Clip.none,
          //height: 18,
          width: 26,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            color: const Color(0xFFFF2A48),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AutoSizeText(
            '$count',
            textAlign: TextAlign.center,
            maxLines: 1,
            maxFontSize: 12,
            minFontSize: 12,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: AppConstants.fontsRegular,
            ),
          ),
        ),
      _ when (count >= 100) => Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsetsDirectional.only(start: 4, end: 4),
          clipBehavior: Clip.none,
          // height: 18,
          // width: 28,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.5),
            color: const Color(0xFFFF2A48),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "99+",
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      _ => const SizedBox(
          width: 20,
          height: 20,
        ),
    };
  }
}
