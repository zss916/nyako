import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class VipBanner extends StatelessWidget {
  final int? index;

  VipBanner({super.key, this.index});

  List<String> icons = [
    Assets.imgAppLogo,
    Assets.imgAppLogo,
    Assets.imgAppLogo,
    Assets.imgAppLogo,
    Assets.imgAppLogo,
    Assets.imgAppLogo,
    Assets.imgAppLogo,
  ];

  List<String> contents = [
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
      alignment: Alignment.topCenter,
      height: 230,
      decoration: BoxDecoration(
        color: const Color(0x1A5600A0),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
      ),
      margin: const EdgeInsetsDirectional.only(
          top: 0, start: 15, end: 15, bottom: 15),
      padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 20),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    icons[index],
                    width: 180,
                    height: 118,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              AutoSizeText(
                contents[index],
                maxLines: 2,
                maxFontSize: 15,
                minFontSize: 8,
                style: const TextStyle(color: Colors.white54, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
        itemCount: icons.length,
        autoplay: true,
        autoplayDelay: 3000,
        duration: 1200,
        index: index,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 0),
          builder: DotSwiperPaginationBuilder(
              activeColor: Colors.white,
              color: Color(0x7FFFFFFF),
              size: 7,
              activeSize: 7),
        ),
      ),
    );
  }
}
