import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/call/call/index.dart';

class WarnTip extends StatelessWidget {
  final CallLogic logic;

  const WarnTip(this.logic, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () => logic.closeWarn(),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, bottom: 10, top: 10),
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, top: 10),
                child: AutoSizeText(
                  Tr.app_video_warning.tr,
                  style: TextStyle(
                      fontFamily: AppConstants.fontsRegular,
                      color: const Color(0xFFFFF599),
                      fontSize: 11),
                  maxFontSize: 11,
                  minFontSize: 4,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
