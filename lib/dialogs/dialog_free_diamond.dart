import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_dialog.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/base_button3.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/user_info.dart';

void showFreeDiamond({required int diamond}) {
  AppCommonDialog.dialog(
      AppFreeDiamondDialog(
        diamondCount: UserInfo.to.config?.vipDailyDiamonds ?? 0,
      ),
      routeSettings: const RouteSettings(name: AppPages.freeDiamondDialog));
}

class AppFreeDiamondDialog extends StatelessWidget {
  final int diamondCount;

  const AppFreeDiamondDialog({super.key, required this.diamondCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 5),
            child: Image.asset(
              Assets.iconDiamond,
              matchTextDirection: true,
              height: 160,
              width: 160,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '+${UserInfo.to.config?.vipDailyDiamonds ?? 0}',
                style: TextStyle(
                    color: const Color(0xFFFFF890),
                    fontFamily: AppConstants.fontsBold,
                    fontSize: 18),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 5),
                child: Image.asset(
                  Assets.iconDiamond,
                  width: 23,
                  height: 23,
                  matchTextDirection: true,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Tr.app_congratulations_get.trArgs([""]),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 10),
            child: Text(
              Tr.app_luck_diamond
                  .trArgs(['${UserInfo.to.config?.vipDailyDiamonds ?? 0}']),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
                child: BaseButton3(Tr.app_base_confirm.tr),
              )),
        ],
      ),
    );
  }
}
