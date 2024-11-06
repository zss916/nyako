import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/pages/main/match/index.dart';

class BuildMatchNum extends StatelessWidget {
  const BuildMatchNum({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchLogic>(
        id: "count",
        init: MatchLogic(),
        builder: (logic) {
          return logic.isUserVip
              ? const SizedBox.shrink()
              : AutoSizeText(
                  "(${(10 - logic.count).toString()})",
                  textAlign: TextAlign.center,
                  maxFontSize: 18,
                  minFontSize: 10,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                );
        });
  }
}
