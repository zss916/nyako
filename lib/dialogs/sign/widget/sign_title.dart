import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';

class SignTitle extends StatelessWidget {
  final bool isVip;
  const SignTitle({super.key, required this.isVip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: double.maxFinite,
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsetsDirectional.only(
          start: 20, bottom: 12, end: 25, top: 2),
      child: AutoSizeText(
        isVip ? Tr.appVipSignTitle.tr : Tr.appCommonSignTitle.tr,
        maxLines: 1,
        maxFontSize: 14,
        minFontSize: 6,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
