import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:nyako/dialogs/reward_dialog/widget/limit_time.dart';
import 'package:nyako/dialogs/reward_dialog/widget/top_bg.dart';
import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/utils/app_check_calling_util.dart';
import 'package:nyako/utils/app_some_extension.dart';

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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(
                top: 35,
                child: Image.asset(
                  Assets.rewardDialogBg,
                  width: Get.width,
                  height: Get.width,
                  matchTextDirection: true,
                )),
            TopBg(
              url: data.drawImageIcon ?? "",
              cachePath: data.cacheDrawImageIcon,
              defaultIcon: Assets.rewardBg2,
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.only(
                  start: 30, end: 30, top: 115),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: Color(0xFFFF33A7), offset: Offset(0, 10))
                  ],
                  border: Border.all(width: 2, color: Colors.white),
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [Color(0xFFFFCDF4), Color(0xFFFFF5FD)]),
                  borderRadius: BorderRadiusDirectional.circular(24),
                  color: Colors.white),
              child: Container(
                constraints: const BoxConstraints(minHeight: 360),
                padding: const EdgeInsetsDirectional.only(top: 0),
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 5),
                            child: Image.asset(
                              Assets.iconDiamond,
                              width: 36,
                              height: 36,
                              matchTextDirection: true,
                            ),
                          ),
                          Text(
                            "${data.showValue}",
                            style: TextStyle(
                                color: const Color(0xFF9341FF),
                                fontSize: 28,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                        width: 140,
                        height: 43,
                        alignment: AlignmentDirectional.bottomCenter,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                matchTextDirection: true,
                                image: ExactAssetImage(
                                    Assets.rewardDiamondRewardIconBg))),
                        padding: const EdgeInsetsDirectional.only(
                            start: 3, end: 3, bottom: 15),
                        margin: const EdgeInsetsDirectional.only(
                            top: 15, start: 20, end: 20),
                        child: AutoSizeText(
                          diamondTip,
                          maxLines: 1,
                          maxFontSize: 14,
                          minFontSize: 12,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.normal),
                        )),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: Text(
                        data.showDialogPrice,
                        style: TextStyle(
                            color: const Color(0xFFFF4864),
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontsBold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
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
                                  bottom: 5, top: 15),
                              width: 275,
                              height: 65,
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
                              top: 0,
                              start: 5,
                              child: Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(10),
                                      bottomStart: Radius.zero,
                                      topEnd: Radius.zero,
                                      bottomEnd: Radius.circular(10),
                                    )),
                                child:
                                    LimitTime(duration: data.discountDuration),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
                top: 0,
                end: 20,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    Assets.iconCloseDialog,
                    width: 42,
                    height: 42,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
