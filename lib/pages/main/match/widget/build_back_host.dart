import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class BuildBackHost extends StatelessWidget {
  final String portrait;
  final String name;

  const BuildBackHost(this.portrait, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.pageBg,
          image: DecorationImage(
              image: NetworkImage(portrait), fit: BoxFit.cover)),
      child: AppConstants.isFakeMode
          ? const SizedBox.shrink()
          : Container(
              width: double.maxFinite,
              height: 30,
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.only(
                  top: 2, start: 2, end: 2, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 3),
                    child: Image.asset(
                      Assets.imgCallIcon,
                      width: 17,
                      height: 17,
                      matchTextDirection: true,
                    ),
                  ),
                  AutoSizeText(
                    Tr.app_grade_video_chat.tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    maxFontSize: 12,
                    minFontSize: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.red, blurRadius: 3)],
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
    );
  }
}
