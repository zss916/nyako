import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';

class CommonSignTitle extends StatelessWidget {
  const CommonSignTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 63,
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsetsDirectional.only(
          start: 25, bottom: 12, end: 10, top: 2),
      child: AutoSizeText(
        Tr.appCommonSignTitle.tr,
        maxLines: 1,
        maxFontSize: 14,
        minFontSize: 6,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
