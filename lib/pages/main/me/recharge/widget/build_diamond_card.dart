import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/recharge/index.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 10),
                child: Text(
                  Tr.app_base_balance.trArgs([""]).replaceAll(":", ""),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 10, end: 5),
                    child: Image.asset(
                      Assets.iconDiamond,
                      width: 16,
                      height: 16,
                      matchTextDirection: true,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 220.w),
                    child: Obx(
                      () => AutoSizeText(
                        "${logic.remainDiamonds.value}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxFontSize: 15,
                        minFontSize: 10,
                        style: TextStyle(
                            color: const Color(0xFF9341FF),
                            fontSize: 15,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
