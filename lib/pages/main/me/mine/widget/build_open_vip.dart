import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';

class BuildOpenVip extends StatelessWidget {
  final MeLogic logic;
  BuildOpenVip({Key? key, required this.logic}) : super(key: key);

  final String openVip = Tr.app_open_vip.tr;
  final String appVip = "Nyako VIP";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logic.toVip(),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsetsDirectional.only(start: 16, end: 16),
        height: 54,
        padding: const EdgeInsetsDirectional.only(start: 95, end: 12),
        decoration: const BoxDecoration(
            image: DecorationImage(
                matchTextDirection: true,
                fit: BoxFit.fill,
                image: ExactAssetImage(Assets.iconVipOpenBg))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appVip,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstants.fontsBold,
                  fontSize: 18),
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                openVip,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
