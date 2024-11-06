import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';

class Banner3 extends StatelessWidget {
  Banner3({super.key});

  final List<String> content = [
    Tr.app_vip_sign_extra.tr,
    Tr.app_benefit_1.tr,
    Tr.app_benefit_2.tr,
    Tr.app_benefit_3.tr,
    Tr.app_benefit_4.tr,
    Tr.app_benefit_5.tr,
    Tr.app_benefit_6.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Image.asset(
                Assets.iconGou,
                width: 20,
                height: 20,
                matchTextDirection: true,
              ),
            ),
            Expanded(
              child: Text(
                "${Tr.app_benefit.trArgs(["7: "])}${content[6]}",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ],
    );
  }
}
