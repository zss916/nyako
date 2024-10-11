import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_banner.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_list.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';

class VipListSheet extends StatelessWidget {
  PayQuickCommodite? discountVip;
  final List<PayQuickCommodite> data;
  final int? selectIndex;
  final String? path;

  final AreaData? area;

  VipListSheet(
      {super.key,
      this.discountVip,
      required this.data,
      required this.path,
      this.selectIndex,
      this.area});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                Color(0xFF201436),
                Color(0xFF0C0C32),
              ]),
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(30), bottom: Radius.zero)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
              child: Text(
                Tr.app_buy_vip.tr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            VipList(
                discountVip: discountVip,
                data: data,
                path: path,
                area: area,
                selectIndex: selectIndex),
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
            VipBanner(
              index: selectIndex,
            ),
          ],
        ),
      ),
    );
  }
}
