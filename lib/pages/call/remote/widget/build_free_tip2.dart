import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_some_extension.dart';

class BuildFreeTip2 extends StatelessWidget {
  const BuildFreeTip2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsetsDirectional.only(bottom: 2),
      constraints: const BoxConstraints(minWidth: 68),
      padding: EdgeInsetsDirectional.only(
          start: 25, end: 5, bottom: 0, top: Get.isHi ? 8 : 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              matchTextDirection: true,
              image: AssetImage((Get.isTr || Get.isVi)
                  ? Assets.iconCardFreeBg2
                  : Assets.iconCardFreeBg))),
      child: AutoSizeText(
        Tr.app_call_free.tr,
        maxLines: 1,
        maxFontSize: 14,
        minFontSize: 11,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
