import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/dialogs/reward_dialog/widget/build_scale_transition.dart';
import 'package:oliapro/dialogs/reward_dialog/widget/limit_time.dart';
import 'package:oliapro/dialogs/reward_dialog/widget/top_bg.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_check_calling_util.dart';
import 'package:oliapro/utils/app_some_extension.dart';

showRewardDiamondDialog() {
  ///1限时中奖 2折扣 3.直降
  if (!AppConstants.isFakeMode) {
    if (ARoutes.isShowReward()) {
      return;
    }
    RewardProductAPI.getDrawProduct(select: 1).then((value) {
      if (!AppCheckCallingUtil.checkCalling()) {
        Get.dialog(RewardDiamondDialog(data: value),
            barrierDismissible: false,
            routeSettings:
                const RouteSettings(name: AppPages.rewardDiamondDialog),
            barrierColor: Colors.black.withOpacity(0.8));
      }
    });
  }
}

class RewardDiamondDialog extends StatelessWidget {
  final PayQuickCommodite data;

  RewardDiamondDialog({Key? key, required this.data}) : super(key: key);

  String topTitle = Tr.appRewardDialog1Title.tr;

  String diamondTip = Tr.appSpecialPrice.tr;

  String btn = Tr.appGetYourRewardsNow.tr;

  @override
  Widget build(BuildContext context) {
    return badWidget();
  }

  Widget badWidget() {
    return Column(
      children: [
        const Spacer(),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.asset(
              Assets.rewardRewardDialogBg,
              matchTextDirection: true,
            ),
            TopBg(
              url: data.drawImageIcon ?? "",
              cachePath: data.cacheDrawImageIcon,
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(
                  start: 25, end: 25, top: 120),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [Color(0xFFF1A0F4), Colors.white]),
                  borderRadius: BorderRadiusDirectional.circular(30),
                  color: Colors.white),
              child: Container(
                constraints: const BoxConstraints(minHeight: 330),
                padding: const EdgeInsetsDirectional.only(top: 0),
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 30),
                      child: Text(
                        topTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFF5C0B4C),
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 5),
                            child: Image.asset(
                              Assets.imgDiamond,
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Text(
                            "${data.showValue}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.transparent,
                          Color(0x33FF13CC),
                          Colors.transparent,
                        ])),
                        padding:
                            const EdgeInsetsDirectional.only(top: 3, bottom: 3),
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, start: 30, end: 30),
                        child: Text(
                          diamondTip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF5C0B4C),
                              fontSize: 14,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.normal),
                        )),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: Text(
                        data.showDialogPrice,
                        style: TextStyle(
                            color: const Color(0xFFFF13CC),
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontsBold,
                            fontSize: 24),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: BuildScaleTransition(
                        child: Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            GestureDetector(
                              onTap: () {
                                toQuickPayChannel(data,
                                    createPath: ChargePath.rechargeForPdd,
                                    area: data.area);
                              },
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    bottom: 5, top: 5),
                                width: 285,
                                height: 84,
                                alignment: AlignmentDirectional.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                            Assets.rewardRewardBtn))),
                                child: Container(
                                  // width: double.maxFinite,
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: Get.isPt ? 10 : 5,
                                      vertical: Get.isPt ? 12 : 6),
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 18, start: 5, end: 5),
                                  child: AutoSizeText(
                                    btn,
                                    maxLines: Get.isPt ? 2 : 1,
                                    maxFontSize: 17,
                                    minFontSize: 12,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                                start: 15,
                                child: Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.white),
                                      color: const Color(0xFFFF4337),
                                      borderRadius:
                                          const BorderRadiusDirectional.only(
                                        topStart: Radius.circular(30),
                                        bottomStart: Radius.zero,
                                        topEnd: Radius.circular(30),
                                        bottomEnd: Radius.circular(30),
                                      )),
                                  child: LimitTime(
                                      duration: data.discountDuration),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
                top: 115,
                end: 15,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    Assets.imgCloseDialog,
                    width: 30,
                    height: 30,
                  ),
                ))
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
