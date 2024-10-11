import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/main/me/recharge/widget/limit/count_time.dart';
import 'package:oliapro/services/app_time_service.dart';
import 'package:oliapro/utils/app_some_extension.dart';

class LimitTime extends StatelessWidget {
  final int? discount;
  final int? duration;
  final Widget child;
  const LimitTime(
      {super.key, required this.child, this.duration, this.discount});

  @override
  Widget build(BuildContext context) {
    AppTimeService.to.startCountDown = true;
    return duration != null
        ? Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 15),
                padding: const EdgeInsetsDirectional.only(
                    top: 5, start: 3, end: 3, bottom: 3),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xFFFF3978),
                      Color(0xFFFF9242),
                    ]),
                    borderRadius: BorderRadiusDirectional.circular(18)),
                child: Column(
                  children: [
                    if (duration != null)
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 20),
                        alignment: AlignmentDirectional.centerEnd,
                        child: CountTime(
                          duration: duration!,
                        ),
                      ),
                    child
                  ],
                ),
              ),
              if (discount != null)
                PositionedDirectional(
                  top: 10,
                  start: 5,
                  child: Container(
                    width: 74,
                    height: 50,
                    padding: const EdgeInsetsDirectional.only(
                        start: 6, top: 2, bottom: 1),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage("Assets.imgDiscountBg"),
                            fit: BoxFit.fill,
                            matchTextDirection: true)),
                    child: Center(
                      child: Column(
                        children: [
                          AutoSizeText(
                            Get.isTr ? "%$discount" : "$discount%",
                            maxLines: 1,
                            maxFontSize: 17,
                            minFontSize: 8,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          AutoSizeText(
                            Tr.app_off
                                .trArgs([""]).replaceAll(RegExp(r'%'), ""),
                            maxLines: 1,
                            maxFontSize: 12,
                            minFontSize: 6,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              /* if (discount != null)
                PositionedDirectional(
                    top: 0,
                    start: 10,
                    child: Image.asset(
                      Assets.imgStart,
                      matchTextDirection: true,
                      width: 30,
                      height: 30,
                    )),*/
            ],
          )
        : child;
  }
}
