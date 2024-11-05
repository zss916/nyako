import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';
import 'package:oliapro/pages/main/me/mine/widget/build_identity.dart';
import 'package:oliapro/pages/main/me/mine/widget/build_name.dart';
import 'package:oliapro/pages/main/me/mine/widget/build_open_vip.dart';
import 'package:oliapro/pages/main/me/mine/widget/build_portrait.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildTopInfo extends StatelessWidget {
  final MeLogic logic;
  BuildTopInfo(this.logic, {super.key});

  final String diamondShop = Tr.app_mine_my_diamond.tr;
  final String vipBenefits = Tr.app_to_update_vip.tr;
  //final String renew = Tr.app_renew.tr;
  final String myDiamonds = Tr.app_recharge_my_diamonds.tr;
  final String openVip = Tr.app_open_vip.tr;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                    Color(0xFFDFD2FF),
                    Color(0xFFFFEAFB),
                    Colors.white
                  ])),
              padding: const EdgeInsetsDirectional.only(top: 45),
              margin: const EdgeInsetsDirectional.only(top: 0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      BuildPortrait(logic),
                      const BuildName(),
                      BuildIdentity(logic),
                      Container(
                        height: 46,
                        margin: const EdgeInsetsDirectional.only(
                            top: 15, bottom: 20, start: 15, end: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () => ARoutes.toFollow(),
                                child: Container(
                                  width: double.maxFinite,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 2),
                                  color: Colors.amber.withOpacity(0),
                                  child: Column(
                                    children: [
                                      Text(
                                        logic.state.followedNum,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            color: const Color(0xFF642A4B),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Tr.app_details_following.tr,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            color: const Color(0xFF9B989D),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            const VerticalDivider(
                              width: 1,
                              indent: 8,
                              endIndent: 8,
                              color: Color(0x1F642A4B),
                            ),
                            Expanded(
                                child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () => logic.toPackages(),
                                child: Container(
                                  width: double.maxFinite,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 2),
                                  color: Colors.blue.withOpacity(0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${logic.state.totalPropCount}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            color: const Color(0xFF642A4B),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Tr.app_prop_package.tr,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            color: const Color(0xFF9B989D),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            const VerticalDivider(
                              width: 1,
                              indent: 8,
                              endIndent: 8,
                              color: Color(0x1F642A4B),
                            ),
                            Expanded(
                                child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () => logic.toLottery(),
                                child: Container(
                                  width: double.maxFinite,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 2),
                                  color: Colors.green.withOpacity(0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${logic.state.propCount}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            color: const Color(0xFF642A4B),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        Tr.app_lottery.tr,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            color: const Color(0xFF9B989D),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => logic.toRecharge(),
                        child: Container(
                          width: double.maxFinite,
                          height: 54,
                          padding: const EdgeInsetsDirectional.all(12),
                          margin: const EdgeInsetsDirectional.only(
                              start: 15, end: 15, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(14),
                              gradient: const LinearGradient(colors: [
                                Color(0xFFFF807F),
                                Color(0xFFF880FF),
                                Color(0xFFC694FF)
                              ])),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(end: 10),
                                child: Text(
                                  diamondShop,
                                  style: TextStyle(
                                      fontFamily: AppConstants.fontsRegular,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GetBuilder<MeLogic>(
                                    init: MeLogic(),
                                    builder: (logic) => Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 180),
                                      child: AutoSizeText(
                                        "${logic.state.remainDiamonds}",
                                        maxLines: 1,
                                        maxFontSize: 18,
                                        minFontSize: 12,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    Assets.iconDiamond,
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              )),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(start: 0),
                                child: Image.asset(
                                  Assets.iconNextW,
                                  matchTextDirection: true,
                                  width: 20,
                                  height: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (!logic.state.isVip)
              BuildOpenVip(
                logic: logic,
              ),
          ],
        ),
        PositionedDirectional(
            top: 35,
            end: 5,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // highlightColor: Colors.black38,
                borderRadius: BorderRadius.circular(50),
                onTap: () => logic.toEdit(),
                child: Container(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Image.asset(
                    Assets.iconEdit,
                    width: 24,
                    height: 24,
                    matchTextDirection: true,
                  ),
                ),
              ),
            )),
        PositionedDirectional(
            top: 35,
            start: 5,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // highlightColor: Colors.black38,
                borderRadius: BorderRadius.circular(50),
                onTap: () => logic.toBindGoogle(),
                child: Container(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Lottie.asset(
                    Assets.jsonAnimaBindGoogle,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
