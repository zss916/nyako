import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/banber1.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/banber2.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/banber3.dart';

class VipBanner extends StatelessWidget {
  final int? index;

  VipBanner({super.key, this.index});

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
    Tr.app_benefit.trArgs([]),
    Tr.app_vip_sign_extra.tr,
    Tr.app_benefit_1.tr,
    Tr.app_benefit_2.tr,
    Tr.app_benefit_3.tr,
    Tr.app_benefit_4.tr,
    Tr.app_benefit_5.tr,
    Tr.app_benefit_6.tr,
  ];

  final List<Widget> w = [
    Banner1(),
    Banner2(),
    Banner3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 170,
      //color: Colors.blue,
      margin: const EdgeInsetsDirectional.only(
          top: 20, start: 20, end: 20, bottom: 10),
      padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 10),
      child: RepaintBoundary(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsetsDirectional.only(top: 0, bottom: 10),
              child: w[index],
            );
          },
          itemCount: w.length,
          autoplay: true,
          autoplayDelay: 3000,
          duration: 1200,
          index: 0,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xFF9341FF),
                color: Color(0x339341FF),
                size: 7,
                activeSize: 7),
          ),
        ),
      ),
    );
  }
}
