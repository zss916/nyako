import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class BenefitList extends StatelessWidget {
  BenefitList({super.key});

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
    return Container(
      width: Get.width,
      padding: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 15),
      decoration:
          BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(
                start: 10, end: 10, bottom: 5, top: 15),
            alignment: AlignmentDirectional.center,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: Image.asset(
                    Assets.benefitStarTitleIcon,
                    width: 21,
                    height: 21,
                    matchTextDirection: true,
                  ),
                ),
                Text(
                  Tr.app_benefit.trArgs([""]),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 2),
                  child: Image.asset(
                    Assets.benefitStarTitleIcon,
                    width: 21,
                    height: 21,
                    matchTextDirection: true,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              cacheExtent: 47,
              itemCount: icons.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildItem(index);
              })
        ],
      ),
    );
  }

  Widget buildItem(int index) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 14),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 10),
            child: Image.asset(
              icons[index],
              width: 47,
              height: 47,
              matchTextDirection: true,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* Text(
                  Tr.app_benefit.trArgs(["${index + 1}"]),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),*/
                Text(
                  content[index],
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
