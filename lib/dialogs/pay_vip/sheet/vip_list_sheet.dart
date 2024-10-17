import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_list.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/to_vip/index.dart';

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

  final String title = "Nyako VIP";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(0), bottom: Radius.zero)),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 2),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFFFF7A26),
                  Color(0xFFFFB140),
                ])),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: Image.asset(
                        Assets.iconKingVip,
                        width: 24,
                        height: 24,
                        matchTextDirection: true,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      Tr.app_vip_tip1.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ))
                  ],
                ),
              ),
              Image.asset(
                Assets.iconVipPageBg,
                fit: BoxFit.fitWidth,
                matchTextDirection: true,
              )
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 220),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, bottom: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 3),
                        child: Image.asset(
                          Assets.iconNyakoVipIc,
                          width: 40,
                          height: 15,
                        ),
                      )
                    ],
                  ),
                ),
                buildVip()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildVip() {
    return GetBuilder<VipLogic>(
      init: VipLogic(),
      builder: (logic) => VipList(
        discountVip: logic.discountVip,
        data: logic.data,
        path: ChargePath.recharge_vip,
        selectIndex: 0,
        area: logic.area,
      ),
    );
  }
}
