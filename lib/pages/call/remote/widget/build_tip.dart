import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/services/user_info.dart';

class BuildTip extends StatelessWidget {
  const BuildTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsetsDirectional.only(
                top: 35, end: 30, start: 30, bottom: 5),
            padding: const EdgeInsetsDirectional.only(
                start: 10, end: 10, bottom: 13, top: 10),
            decoration: const BoxDecoration(),
            child: Container(
              constraints: const BoxConstraints(minHeight: 35),
              child: AutoSizeText(
                Tr.app_video_called_free_card_tip.trArgs([
                  ((UserInfo.to.myDetail?.callCardDuration ?? 30000) ~/ 1000)
                      .toString()
                ]),
                maxFontSize: 14,
                minFontSize: 14,
                softWrap: true,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            )),
      ],
    );
  }
}
