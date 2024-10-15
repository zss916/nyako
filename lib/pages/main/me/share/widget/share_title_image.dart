import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';

class ShareTitleImage extends StatelessWidget {
  const ShareTitleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return buildTitle("ar");
    return buildTitle(Get.locale?.languageCode ?? "en");
  }

  Widget buildTitle(String code) {
    return switch (code) {
      _ when code == "tr" => Image.asset(
          Assets.iconShareTr,
          scale: 3,
        ),
      _ when code == "th" => Image.asset(
          Assets.iconShareTh,
          scale: 3,
        ),
      _ when code == "pt" => Image.asset(
          Assets.iconSharePt,
          scale: 3,
        ),
      _ when code == "en" => Image.asset(
          Assets.iconShareEn,
          scale: 3,
        ),
      _ when code == "vi" => Image.asset(
          Assets.iconShareVi,
          scale: 3,
        ),
      _ when code == "ar" => Container(
          margin: const EdgeInsetsDirectional.only(start: 30, bottom: 0),
          child: Image.asset(
            Assets.iconShareAr,
            scale: 3.3,
          ),
        ),
      _ when code == "es" => Image.asset(
          Assets.iconShareEs,
          scale: 3,
        ),
      _ when code == "hi" => Image.asset(
          Assets.iconShareHi,
          scale: 3,
        ),
      _ when code == "id" => Image.asset(
          Assets.iconShareInd,
          scale: 3,
        ),
      _ => Image.asset(
          Assets.iconShareEn,
          scale: 3,
        ),
    };
  }
}
