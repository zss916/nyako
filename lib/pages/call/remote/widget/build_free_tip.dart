import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_some_extension.dart';

class BuildFreeTip extends StatelessWidget {
  const BuildFreeTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      margin: const EdgeInsetsDirectional.only(bottom: 2),
      constraints: const BoxConstraints(minWidth: 52),
      padding: EdgeInsetsDirectional.only(
          start: 5, end: 5, bottom: Get.isHi ? 0 : 4, top: Get.isHi ? 6 : 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              matchTextDirection: true,
              image: AssetImage((Get.isTr || Get.isVi)
                  ? Assets.iconFreeBg2
                  : Assets.iconFreeBg))),
      child: AutoSizeText(
        Tr.app_call_free.tr,
        maxLines: 1,
        maxFontSize: 14,
        minFontSize: 12,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
