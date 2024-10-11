import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';

class BuildDiamondCard extends StatelessWidget {
  final RechargeLogic logic;

  const BuildDiamondCard(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        alignment: AlignmentDirectional.centerStart,
        margin: const EdgeInsetsDirectional.only(
            start: 10, end: 10, top: 80, bottom: 10),
        padding: const EdgeInsetsDirectional.only(start: 0),
        child: Container(
          margin: const EdgeInsetsDirectional.only(top: 5),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 10),
                child: Text(
                  Tr.app_base_balance.trArgs([""]).replaceAll(":", ""),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFC3A0FF)),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 220.w),
                    child: Obx(
                      () => AutoSizeText(
                        "${logic.remainDiamonds.value}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxFontSize: 22,
                        minFontSize: 12,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    child: Image.asset(
                      Assets.imgDiamond,
                      width: 24,
                      height: 24,
                      matchTextDirection: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

/*  Widget buildAddCardTip() {
    return GetBuilder<RechargeLogic>(
        id: "addRechargeCard",
        init: RechargeLogic(),
        builder: (logic) {
          return logic.propDuration == 0
              ? const SizedBox.shrink()
              : Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color(0x1FFFF890),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  margin: const EdgeInsetsDirectional.only(
                      start: 15, end: 15, top: 0),
                  alignment: AlignmentDirectional.bottomCenter,
                  padding: const EdgeInsetsDirectional.only(
                      top: 8, start: 10, end: 10, bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imgSmallAddCard,
                        width: 30,
                        height: 20,
                        matchTextDirection: true,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                          child: Container(
                        margin:
                            const EdgeInsetsDirectional.only(start: 4, end: 4),
                        child: Text(
                          Tr.app_add_card_tip
                              .trArgs(["${logic.propDuration}%"]),
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Color(0xFFFFF890),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ))
                    ],
                  ),
                );
        });
  }*/
}
