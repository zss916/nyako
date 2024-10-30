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

showRewardTimeDialog() {
  if (!AppConstants.isFakeMode) {
    if (ARoutes.isShowReward()) {
      return;
    }
    RewardProductAPI.getDrawProduct(select: 3).then((value) {
      if (!AppCheckCallingUtil.checkCalling()) {
        Get.dialog(RewardTimeDialog(data: value),
            barrierDismissible: false,
            routeSettings: const RouteSettings(name: AppPages.rewardTimeDialog),
            barrierColor: Colors.black.withOpacity(0.8));
      }
    });
  }
}

class RewardTimeDialog extends StatelessWidget {
  final PayQuickCommodite data;

  RewardTimeDialog({Key? key, required this.data}) : super(key: key);

  String btn = Tr.appGetYourRewardsNow.tr;

  String tip = Tr.appDownTo.tr;

  String title = Tr.appRewardDialog3Title.tr;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            TopBg(
              url: data.drawImageIcon ?? "",
              cachePath: data.cacheDrawImageIcon,
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
                      margin: const EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 20, bottom: 12),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF5F0538)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 10),
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
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 15, start: 20, end: 20),
                      child: Text(
                        tip,
                        style: TextStyle(
                            color: const Color(0xFFFF4864),
                            fontWeight: FontWeight.normal,
                            fontFamily: AppConstants.fontsRegular,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 5),
                      child: Image.asset(
                        Assets.rewardQuickDownPrice,
                        width: 111,
                        height: 62,
                        matchTextDirection: true,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      child: Text(
                        data.showDialogPrice,
                        style: TextStyle(
                            color: const Color(0xFFFF4864),
                            fontWeight: FontWeight.bold,
                            fontFamily: AppConstants.fontsBold,
                            fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        toQuickPayChannel(data,
                            createPath: ChargePath.rechargeForPdd,
                            area: data.area);
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            bottom: 10, top: 15),
                        width: 275,
                        height: 65,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    ExactAssetImage(Assets.rewardRewardBtn))),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 18),
                          child: AutoSizeText(
                            btn,
                            maxLines: 1,
                            maxFontSize: 16,
                            minFontSize: 12,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
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
