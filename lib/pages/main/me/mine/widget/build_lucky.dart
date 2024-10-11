import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';

class BuildLucky extends StatelessWidget {
  final MeLogic logic;

  BuildLucky(this.logic, {super.key});
  final String tip1 = Tr.app_lucky_title1.tr;
  final String tip2 = Tr.app_lucky_title2.tr;
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return AppConstants.isFakeMode ? const SizedBox.shrink() : toLucky(logic);
  }

  Widget toLucky(MeLogic logic) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 20),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        onTap: () => logic.toLottery(),
        child: Container(
          width: double.maxFinite,
          height: 50,
          padding: const EdgeInsetsDirectional.only(start: 12, end: 10),
          alignment: AlignmentDirectional.centerStart,
          decoration: const BoxDecoration(
              color: Color(0x14FFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 5),
                child: Image.asset(
                  Assets.imgSmallLottery,
                  matchTextDirection: true,
                  width: 28,
                  height: 28,
                ),
              ),
              Expanded(
                  child: Obx(() => AutoSizeText.rich(
                        TextSpan(
                            style: TextStyle(
                                color: textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: tip1,
                              ),
                              TextSpan(
                                  text: " ${logic.state.num} ",
                                  style: const TextStyle(
                                      color: Color(0xFFFFF890), fontSize: 13)),
                              TextSpan(
                                text: tip2,
                              )
                            ]),
                        maxLines: 1,
                        maxFontSize: 14,
                        minFontSize: 6,
                      ))),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 5),
                child: Image.asset(
                  Assets.imgArrowEnd,
                  matchTextDirection: true,
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
