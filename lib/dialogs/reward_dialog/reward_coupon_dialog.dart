import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/dialogs/reward_dialog/widget/build_scale_transition.dart';
import 'package:oliapro/dialogs/reward_dialog/widget/top_bg.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_check_calling_util.dart';

showRewardCouponDialog() {
  if (!AppConstants.isFakeMode) {
    if (ARoutes.isShowReward()) {
      return;
    }
    RewardProductAPI.getDrawProduct(select: 2).then((value) {
      if (!AppCheckCallingUtil.checkCalling()) {
        Get.dialog(RewardCouponDialog(data: value),
            barrierDismissible: false,
            routeSettings:
                const RouteSettings(name: AppPages.rewardCouponDialog),
            barrierColor: Colors.black.withOpacity(0.8));
      }
    });
  }
}

class RewardCouponDialog extends StatelessWidget {
  final PayQuickCommodite data;
  RewardCouponDialog({Key? key, required this.data}) : super(key: key);

  String topTitle = Tr.appCouponDialog2Title.tr;

  String btn = Tr.appGetYourRewardsNow.tr;

  String t1 = Tr.appCouponDialog2Content1.tr.split("%s").first;

  String t2 = Tr.appCouponDialog2Content1.tr.split("%s").last;

  @override
  Widget build(BuildContext context) {
    return bad();
  }

  Widget bad() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
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
                          margin: const EdgeInsetsDirectional.only(
                              start: 20, end: 20, bottom: 0, top: 20),
                          child: Text(
                            topTitle,
                            style: const TextStyle(
                                color: Color(0xFF5C0B4C),
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          margin: const EdgeInsetsDirectional.only(
                              start: 17, end: 17, bottom: 20, top: 0),
                          child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                  text: t1,
                                  style: const TextStyle(
                                      color: Color(0xFF5C0B4C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                        text: " ${data.discount ?? 0}% ",
                                        style: TextStyle(
                                            color: const Color(0xFFFF2121),
                                            fontSize: 30,
                                            fontFamily: AppConstants.fontsBold,
                                            fontWeight: FontWeight.w900),
                                        children: []),
                                    TextSpan(
                                      text: t2,
                                      style: const TextStyle(
                                          color: Color(0xFF5C0B4C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ])),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 64,
                              margin: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 45),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0xFFFCCAFF),
                                          offset: Offset(8, 8),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: Color(0xFFFCCAFF),
                                          offset: Offset(-8, -8),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                    color: Colors.white),
                                foregroundDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(12),
                                    color: const Color(0x66FBEEFC)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsetsDirectional.all(10),
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 0),
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        width: 48,
                                        height: 48,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${data.showValue}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily:
                                                  AppConstants.fontsBold,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.showOldPrice,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.combine([
                                                TextDecoration
                                                    .lineThrough, // 删除线
                                              ]),
                                              color: Colors.black,
                                              fontFamily:
                                                  AppConstants.fontsBold,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 64,
                              margin: const EdgeInsetsDirectional.only(
                                  start: 25, end: 25, top: 60),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFFFCCAFF),
                                        offset: Offset(8, 8),
                                        blurRadius: 10,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        color: Color(0xFFFCCAFF),
                                        offset: Offset(-8, -8),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12),
                                  color: const Color(0xFFFFF9E8)),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsetsDirectional.all(10),
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 0),
                                    child: Image.asset(
                                      Assets.imgDiamond,
                                      width: 48,
                                      height: 48,
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${data.showValue}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data.showDialogPrice,
                                        style: TextStyle(
                                            color: const Color(0xFFFF13CC),
                                            fontSize: 14,
                                            fontFamily: AppConstants.fontsBold,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            PositionedDirectional(
                                top: 28,
                                end: 35,
                                child: Image.asset(
                                  Assets.imgDownPrice,
                                  width: 70,
                                  height: 70,
                                  matchTextDirection: true,
                                ))
                          ],
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              toQuickPayChannel(data,
                                  createPath: ChargePath.rechargeForPdd,
                                  area: data.area);
                            },
                            child: BuildScaleTransition(
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
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 18),
                                  child: AutoSizeText(
                                    btn,
                                    maxLines: 1,
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
        )
      ],
    );
  }
}
