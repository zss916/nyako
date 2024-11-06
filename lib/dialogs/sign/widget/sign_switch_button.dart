import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';

class SignSwitchButton extends StatelessWidget {
  final bool isShow;
  final Widget child;

  const SignSwitchButton(
      {super.key, required this.isShow, required this.child});

  final TextStyle baseTextStyle = const TextStyle(
      color: Color(0xFF773913), fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Container(
            width: 265,
            height: 60,
            alignment: Alignment.center,
            margin: const EdgeInsetsDirectional.only(start: 0, end: 0),
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    matchTextDirection: true,
                    image: ExactAssetImage(Assets.signNyakoSignedBtn))),
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              //color: Colors.white60,
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.only(
                  top: 2, start: 2, end: 2, bottom: 25),
              child: AutoSizeText(
                Tr.appSignNow.tr,
                maxFontSize: 16,
                minFontSize: 8,
                maxLines: 1,
                style: baseTextStyle,
              ),
            ),
          )
        : child;
  }
}
