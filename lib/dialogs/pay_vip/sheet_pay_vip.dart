import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_list_sheet.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/game/game_dialog_manager.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/utils/app_loading.dart';

///开通vip
void sheetToVip(
    {String? path,
    int index = 0,
    bool isSheet = true,
    String? upid,
    bool isBot = false}) {
  Http.instance.post<PayQuickData>(
    '${NetPath.getCompositeProduct2}3',
    showLoading: true,
    errCallback: (err) {
      AppLoading.toast(err.message);
    },
  ).then((value) {
    List<PayQuickCommodite> list = value.vipProducts ?? [];
    PayQuickCommodite? discountVip = value.discountVip;
    if (list.isNotEmpty) {
      if (list.length >= 3) {
        list[0].isSelect = true;
      } else {
        list[0].isSelect = true;
      }
    }
    if (isBot) {
      GameDialogManager.openVipDialog(index, path, list);
    } else {
      Get.bottomSheet(
        BottomArrowWidget(
          child: VipListSheet(
              discountVip: discountVip,
              data: list,
              area: value.area,
              path: path ?? ChargePath.android_recharge_center,
              selectIndex: index),
          onBack: () => Get.back(),
        ),
        settings: const RouteSettings(name: AppPages.vipRechargeSheet),
        persistent: true,
        isScrollControlled: true,
      );
    }
  }).catchError((error) {
    AppLoading.toast(error.message);
  });
}