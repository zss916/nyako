import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class Banner3 extends StatelessWidget {
  Banner3({super.key});

  final List<String> icons = [
    Assets.benefitBenefitDiamond,
    Assets.benefitBenefitMsg,
    Assets.benefitBenefitMatch,
    Assets.benefitBenefitLocation,
    Assets.benefitBenefitAlbum,
    Assets.benefitBenefitGift,
    Assets.benefitBenefitVip,
  ];

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
                icons[6],
                width: 42,
                height: 42,
                matchTextDirection: true,
              ),
            ),
            Expanded(
              child: Text(
                content[6],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60),
              ),
            )
          ],
        ),
      ],
    );
  }
}
