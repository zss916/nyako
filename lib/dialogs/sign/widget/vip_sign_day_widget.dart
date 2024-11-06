import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/sign_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/services/user_info.dart';

class VipSignDayWidget extends StatelessWidget {
  final double w = (316 - 38) / 4;

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

  VipSignDayWidget({super.key, required this.data, required this.signDay});

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
    return Stack(
      children: [
        Container(
          width: index == 6 ? (w * 2) : w,
          height: 98,
          margin: const EdgeInsetsDirectional.only(bottom: 0),
          decoration: BoxDecoration(
              gradient: (index == 6)
                  ? const LinearGradient(colors: [
                      Color(0xFFFFFFBA),
                      Color(0xFFFFE393),
                    ])
                  : LinearGradient(
                      colors: (isReady && !isOpenVip)
                          ? [
                              const Color(0xFFFFFFFF),
                              const Color(0xFFFFFFFF),
                            ]
                          : [const Color(0x26FFFFFF), const Color(0x26FFFFFF)]),
              // color: Colors.white,
              /*gradient: (isSigned || !isFuture)
                  ? const LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      stops: [0.2, 1],
                      colors: [Color(0xFFFFFFFF), Color(0xFFEEEEEE)])
                  : LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                          isReady
                              ? const Color(0xFFFFDD04)
                              : const Color(0xFFFFF4AD),
                          const Color(0xFFFFFFFF)
                        ]),
              border: (isReady)
                  ? const GradientBoxBorder(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFC63C), Color(0xFFFF9000)]),
                      width: 2,
                    )
                  : null,*/
              borderRadius: BorderRadiusDirectional.circular(6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              (index == 6)
                  ? Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 10),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 10),
                            child: Image.asset(
                              data[index].showDailyIcon(),
                              width: 44,
                              height: 44,
                              matchTextDirection: true,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            data[index].showSignName(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppConstants.fontsRegular,
                                color: const Color(0xFF9341FF),
                                fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 2),
                              child: Image.asset(
                                data[index].showDailyIcon(),
                                width: index == 6 ? 44 : 22,
                                height: index == 6 ? 44 : 22,
                                matchTextDirection: true,
                              ),
                            ),
                            Text(
                              data[index].showSignName(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: (isReady && !isOpenVip)
                                      ? AppConstants.fontsBold
                                      : AppConstants.fontsRegular,
                                  fontWeight: (isReady && !isOpenVip)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: (isReady && !isOpenVip)
                                      ? const Color(0xFFFF33A7)
                                      : ((isSigned || !isFuture)
                                          ? Colors.white
                                          : const Color(0xFFFFF395))),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "+${data[index].vipDiamonds ?? 0}",
                              style: TextStyle(
                                  color: (isReady && !isOpenVip)
                                      ? const Color(0xFF9341FF)
                                      : Colors.white,
                                  fontFamily: AppConstants.fontsRegular,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 2),
                              child: Image.asset(
                                Assets.iconDiamond,
                                width: 14,
                                height: 14,
                                matchTextDirection: true,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
              const Spacer(),
              Container(
                width: double.maxFinite,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    //(isReady && !isOpenVip)
                    color: (index == 6)
                        ? const Color(0xFFFFB138)
                        : ((isReady && !isOpenVip)
                            ? const Color(0xFFFF33A7)
                            : const Color(0x1AFFFFFF)),
                    /*gradient: (isSigned || !isFuture)
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
                              ]),*/
                    borderRadius: const BorderRadiusDirectional.vertical(
                        bottom: Radius.circular(6))),
                padding: const EdgeInsetsDirectional.only(
                    top: 5, start: 2, end: 2, bottom: 5),
                child: (isSigned || !isFuture)
                    ? Image.asset(
                        (isSigned)
                            ? Assets.signNyakoSignV
                            : Assets.signNyakoSignX,
                        width: 16,
                        height: 16,
                        matchTextDirection: true,
                      )
                    : AutoSizeText(
                        arr[index],
                        maxFontSize: 12,
                        minFontSize: 5,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.w600),
                      ),
              ),
            ],
          ),
        ),
        if (index == 6)
          Container(
            margin: const EdgeInsetsDirectional.only(top: 2, start: 2),
            padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(14),
                  topEnd: Radius.circular(14),
                  bottomStart: Radius.circular(14),
                  bottomEnd: Radius.circular(14),
                ),
                gradient: LinearGradient(
                    colors: [Color(0xFFFF8929), Color(0xFFFF5112)])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "+${data[index].vipDiamonds ?? 0}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: AppConstants.fontsRegular,
                      fontSize: 11),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 1),
                  child: Image.asset(
                    Assets.iconDiamond,
                    width: 12,
                    height: 12,
                    matchTextDirection: true,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
