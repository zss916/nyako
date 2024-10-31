import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
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
              defaultIcon: Assets.rewardBg1,
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
                constraints: const BoxConstraints(minHeight: 340),
                padding: const EdgeInsetsDirectional.only(top: 0),
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 20, end: 20, bottom: 0, top: 20),
                      child: Text(
                        topTitle,
                        style: const TextStyle(
                            color: Color(0xFF5F0538),
                            fontWeight: FontWeight.w900,
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsetsDirectional.only(
                          start: 25, end: 25, bottom: 20, top: 0),
                      child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: t1,
                              style: const TextStyle(
                                  color: Color(0xFF5F0538),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: " ${data.discount ?? 0}% ",
                                    style: TextStyle(
                                        color: const Color(0xFFFF33A7),
                                        fontSize: 17,
                                        fontFamily: AppConstants.fontsBold,
                                        fontWeight: FontWeight.bold),
                                    children: []),
                                TextSpan(
                                  text: t2,
                                  style: const TextStyle(
                                      color: Color(0xFF5F0538),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ])),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsetsDirectional.all(5),
                                margin:
                                    const EdgeInsetsDirectional.only(end: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10)),
                                width: 106,
                                height: 94,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  end: 3),
                                          child: Image.asset(
                                            Assets.iconDiamond,
                                            width: 20,
                                            height: 20,
                                            matchTextDirection: true,
                                          ),
                                        ),
                                        Text(
                                          "${data.showValue}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily:
                                                  AppConstants.fontsBold,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          top: 10),
                                      child: Text(
                                        data.showOldPrice,
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration: TextDecoration.combine([
                                              TextDecoration.lineThrough, // 删除线
                                            ]),
                                            decorationThickness: 2,
                                            decorationColor:
                                                const Color(0x80FF4864),
                                            color: const Color(0x80FF4864),
                                            fontFamily: AppConstants.fontsBold,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        start: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: const Color(0xFFFF33A7)),
                                        gradient: const LinearGradient(
                                            begin: AlignmentDirectional
                                                .bottomStart,
                                            end: AlignmentDirectional.topEnd,
                                            colors: [
                                              Color(0xFFFFB34F),
                                              Color(0xFFFFE87F),
                                            ]),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10)),
                                    width: double.maxFinite,
                                    padding: const EdgeInsetsDirectional.all(5),
                                    height: 94,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 3),
                                              child: Image.asset(
                                                Assets.iconDiamond,
                                                width: 20,
                                                height: 20,
                                                matchTextDirection: true,
                                              ),
                                            ),
                                            Text(
                                              "${data.showValue}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily:
                                                      AppConstants.fontsBold,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  top: 10),
                                          child: Text(
                                            data.showDialogPrice,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: const Color(0xFFFF4864),
                                                fontFamily:
                                                    AppConstants.fontsBold,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (data.discount != null)
                                    Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 9, vertical: 2),
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                                  topStart: Radius.circular(6),
                                                  bottomStart:
                                                      Radius.circular(6),
                                                  topEnd: Radius.circular(6),
                                                  bottomEnd: Radius.zero),
                                          gradient: LinearGradient(colors: [
                                            Color(0xFFFF1A45),
                                            Color(0xFFFF17D6)
                                          ])),
                                      child: Text(
                                        Tr.app_off
                                            .trArgs(["${data.discount ?? 0}"]),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                ],
                              ))
                            ],
                          ),
                          PositionedDirectional(
                              start: 85,
                              child: Image.asset(
                                Assets.rewardDownIcon,
                                width: 64,
                                height: 64,
                                matchTextDirection: true,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          toQuickPayChannel(data,
                              createPath: ChargePath.rechargeForPdd,
                              area: data.area);
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              bottom: 5, top: 20),
                          width: 275,
                          height: 65,
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      ExactAssetImage(Assets.rewardRewardBtn))),
                          child: Container(
                            margin:
                                const EdgeInsetsDirectional.only(bottom: 18),
                            child: AutoSizeText(
                              btn,
                              maxLines: 1,
                              maxFontSize: 16,
                              minFontSize: 12,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
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
                top: 0,
                end: 25,
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
