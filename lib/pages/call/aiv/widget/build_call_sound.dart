import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/index.dart';

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
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 0),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 7, vertical: 5),
              decoration: const BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.imgSoundClose,
                    matchTextDirection: true,
                    height: 22,
                    width: 22,
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 24,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 3, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFAC53FB),
                          Color(0xFF7934F0),
                        ]),
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    child: AutoSizeText(
                      recharge,
                      maxLines: 1,
                      maxFontSize: 12,
                      minFontSize: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
