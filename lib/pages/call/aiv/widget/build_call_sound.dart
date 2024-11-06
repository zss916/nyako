import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/call/aiv/index.dart';

class BuildCallSound extends StatelessWidget {
  final AivLogic logic;

  BuildCallSound(this.logic, {super.key});

  final String title = Tr.app_call_unlock.tr;
  final String recharge = Tr.app_recharge.tr;

  @override
  Widget build(BuildContext context) {
    return (logic.haveVoice)
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () => logic.clickCharge(),
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 0),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF1A84), Color(0xFFFFAE17)]),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    Assets.iconSoundClose,
                    matchTextDirection: true,
                    height: 24,
                    width: 24,
                  ),
                  Expanded(
                      child: Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      softWrap: true,
                    ),
                  )),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 30,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    child: AutoSizeText(
                      recharge,
                      maxLines: 1,
                      maxFontSize: 13,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFFFF33A7),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
