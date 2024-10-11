import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/sign_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/services/user_info.dart';

class SignDayWidget extends StatelessWidget {
  final double w = (316 - 38) / 4;

  //Get.deviceLocale?.languageCode == "ar"?

  final List<String> arr = [
    "${Tr.appDays.tr} 1",
    "${Tr.appDays.tr} 2",
    "${Tr.appDays.tr} 3",
    "${Tr.appDays.tr} 4",
    "${Tr.appDays.tr} 5",
    "${Tr.appDays.tr} 6",
    "${Tr.appDays.tr} 7",
  ];

  final List<String> arArr = [
    "1 ${Tr.appDays.tr}",
    "2 ${Tr.appDays.tr}",
    "3 ${Tr.appDays.tr}",
    "4 ${Tr.appDays.tr}",
    "5 ${Tr.appDays.tr}",
    "6 ${Tr.appDays.tr}",
    "7 ${Tr.appDays.tr}",
  ];

  final List<SignBean> data;

  final int signDay;

  bool isOpenVip = UserInfo.to.isUserVip;

  SignDayWidget({super.key, required this.data, required this.signDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsetsDirectional.only(start: 8, end: 8, bottom: 10),
          child: Row(
            children: [
              dayWidget(
                  index: 0,
                  isSigned: data[0].isSigned,
                  isReady: (signDay == 0),
                  isFuture: (signDay <= 0)),
              const Spacer(),
              dayWidget(
                  index: 1,
                  isSigned: data[1].isSigned,
                  isReady: (signDay == 1),
                  isFuture: (signDay <= 1)),
              const Spacer(),
              dayWidget(
                  index: 2,
                  isSigned: data[2].isSigned,
                  isReady: (signDay == 2),
                  isFuture: (signDay <= 2)),
              const Spacer(),
              dayWidget(
                  index: 3,
                  isSigned: data[3].isSigned,
                  isReady: (signDay == 3),
                  isFuture: (signDay <= 3)),
            ],
          ),
        ),
        Container(
          margin:
              const EdgeInsetsDirectional.only(start: 8, end: 8, bottom: 10),
          child: Row(
            children: [
              dayWidget(
                  index: 4,
                  isSigned: data[4].isSigned,
                  isReady: (signDay == 4),
                  isFuture: (signDay <= 4)),
              const Spacer(),
              dayWidget(
                  index: 5,
                  isSigned: data[5].isSigned,
                  isReady: (signDay == 5),
                  isFuture: (signDay <= 5)),
              const Spacer(),
              dayWidget(
                  index: 6,
                  isSigned: data[6].isSigned,
                  isReady: (signDay == 6),
                  isFuture: (signDay <= 6)),
            ],
          ),
        ),
      ],
    );
  }

  Widget dayWidget(
      {int index = 0,
      bool isSigned = false,
      bool isReady = false,
      bool isFuture = true}) {
    return Container(
      width: index == 6 ? (w * 2) : w,
      height: 98,
      margin: const EdgeInsetsDirectional.only(bottom: 0),
      decoration: BoxDecoration(
          // color: const Color(0xFFF5F5F5),
          gradient: (isSigned || !isFuture)
              ? const LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  stops: [0.2, 1],
                  colors: [Color(0xFFFFFFFF), Color(0xFFEEEEEE)])
              : const LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [Color(0xFFFFFFFF), Color(0xFFFFC69F)]),
          border: (isReady && !isOpenVip)
              ? const GradientBoxBorder(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFF773C), Color(0xFFFF0013)]),
                  width: 2,
                )
              : null,
          borderRadius: BorderRadiusDirectional.circular(14)),
      child: Column(
        children: [
          if (index == 6) const Spacer(),
          Container(
            margin: EdgeInsetsDirectional.only(top: index == 6 ? 0 : 2),
            child: Image.asset(
              data[index].showDailyIcon(),
              width: index == 6 ? 80 : 40,
              height: 40,
              matchTextDirection: true,
            ),
          ),
          (index == 6)
              ? const Spacer()
              : Expanded(
                  child: Container(
                  alignment: AlignmentDirectional.center,
                  margin: const EdgeInsetsDirectional.only(
                      start: 2, end: 2, top: 1, bottom: 2),
                  width: double.maxFinite,
                  // color: Colors.blue,
                  child: AutoSizeText(
                    data[index].showName(),
                    maxLines: 2,
                    maxFontSize: 10,
                    minFontSize: 8,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10,
                        color: isSigned
                            ? const Color(0xFF959393)
                            : const Color(0xFFAA4C2D)),
                  ),
                )),
          Container(
            width: double.maxFinite,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: (isSigned || !isFuture)
                    ? null
                    : LinearGradient(
                        colors: (isReady && !isOpenVip)
                            ? [
                                const Color(0xFFFF9444),
                                const Color(0xFFFF4166),
                              ]
                            : [
                                const Color(0x80FF9444),
                                const Color(0x80FF4166),
                              ]),
                borderRadius: BorderRadiusDirectional.vertical(
                    bottom:
                        Radius.circular((isReady && !isOpenVip) ? 12 : 14))),
            padding: const EdgeInsetsDirectional.only(
                top: 5, start: 2, end: 2, bottom: 5),
            child: (isSigned || !isFuture)
                ? Image.asset(
                    (isSigned) ? Assets.signSignV : Assets.signSignX,
                    width: 18,
                    height: 18,
                    matchTextDirection: true,
                  )
                : AutoSizeText(
                    data[index].showSignName(),
                    maxFontSize: 12,
                    minFontSize: 5,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: (isReady && !isOpenVip)
                            ? Colors.white
                            : const Color(0xFFB34B24),
                        fontSize: 14,
                        fontFamily: index == 6 ? null : AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
