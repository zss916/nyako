import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/sign_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';

void showSignReward(SignBean data) {
  Get.dialog(
    SignReward(data),
    routeSettings: const RouteSettings(name: AppPages.signRewardDialog),
  );
}

class SignReward extends StatelessWidget {
  final SignBean data;

  const SignReward(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      stops: [0, 0.9],
                      begin: AlignmentDirectional.topEnd,
                      end: AlignmentDirectional.bottomStart,
                      colors: [
                        Color(0xFFFFFBC1),
                        Color(0xFFFFFFFD),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              padding: const EdgeInsetsDirectional.only(top: 60, bottom: 20),
              margin:
                  const EdgeInsetsDirectional.only(start: 30, end: 30, top: 60),
              width: 315,
              // constraints: const BoxConstraints(minHeight: 285),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                          text: Tr.appCgGain.trArgs([data.showName()]),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          children: [
                            TextSpan(
                              text: Tr.appSignRewardTip
                                  .trArgs([Tr.app_prop_package.tr]),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConstants.fontsRegular,
                                  fontSize: 15),
                            )
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // if (data.isVip == 1 && ((data.vipDiamonds ?? 0) > 0))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "+${data.vipDiamonds ?? 0}",
                        style: TextStyle(
                            color: const Color(0xFF9341FF),
                            fontSize: 24,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 2),
                        child: Image.asset(
                          Assets.iconDiamond,
                          width: 25,
                          height: 25,
                          matchTextDirection: true,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(closeOverlays: true);
                      if (data.type == 8) {
                        ARoutes.toLottery();
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 52,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          color: const Color(0xFF9341FF),
                          borderRadius: BorderRadiusDirectional.circular(30)),
                      margin: const EdgeInsetsDirectional.only(
                          bottom: 5, top: 5, start: 30, end: 30),
                      child: Text(
                        data.type == 8
                            ? Tr.app_lottery.tr
                            : Tr.app_base_confirm.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.signNyakoSucceeful,
              matchTextDirection: true,
              width: 114,
              height: 114,
            )
          ],
        )
      ],
    );
  }
}
