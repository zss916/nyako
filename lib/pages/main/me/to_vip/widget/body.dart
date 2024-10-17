import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_banner.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/to_vip/index.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/vip_list.dart';

class ToVipBody extends StatelessWidget {
  ToVipBody({super.key});

  final String vipBenefits = Tr.app_to_update_vip.tr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: Image.asset(
                Assets.iconVipPageBg,
                matchTextDirection: true,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 70, bottom: 10),
                child: Text(
                  Tr.app_vip_tip1.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              VipBanner(
                index: 0,
              ),
              buildVip(),
            ],
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
