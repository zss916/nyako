import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/generated/assets.dart';

class VipSignButton extends StatelessWidget {
  final String title = Tr.app_buy_vip.tr;

  VipSignButton({super.key});

  final TextStyle baseTextStyle = TextStyle(
      color: const Color(0xFF9C4704),
      fontFamily: AppConstants.fontsBold,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        sheetToVip(path: ChargePath.recharge_vip_dialog_user_center, index: 6);
      },
      child: Container(
        width: 265,
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.only(start: 0, end: 0),
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                matchTextDirection: true,
                image: ExactAssetImage(Assets.signNyakoQuickSignBtn))),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          //color: Colors.white60,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(
              top: 4, start: 2, end: 2, bottom: 0),
          child: AutoSizeText(
            title,
            maxFontSize: 16,
            minFontSize: 8,
            maxLines: 1,
            style: baseTextStyle,
          ),
        ),
      ),
    );
  }
}
