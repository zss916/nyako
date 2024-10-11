import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/dialogs/dialog_free_diamond_tip.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/entities/app_charge_entity.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';

import '../../entities/app_charge_quick_entity.dart';
import '../../generated/json/base/json_convert_content.dart';
import '../../services/user_info.dart';
import 'charge_quick_dialog.dart';

class ChargeDialogManager {
  static const String _discountKey = "discountkey";
  static const String _timeLimitDiscountKey = "timelimitdiscountkey";
  static bool isShowingChargeDialog = false;

  // 最新的弹窗
  static Future showChargeDialog(String createPath,
      {String? upid,
      Function? closeCallBack,
      bool showFreeDiamondPage = true,
      bool showBalanceText = false}) async {
    isShowingChargeDialog = true;
    PddUtil.instance.chargeDialogOpen();
    await AppCommonDialog.dialog(
        routeSettings: const RouteSettings(
            name: AppPages.homeQuickRechargeDialog, arguments: null),
        ChargeQuickDialog(
          createPath: createPath,
          upId: upid,
          closeCallBack: closeCallBack,
          hasDiscountProduct: true,
          closeBtnCallBack: () {
            if (showFreeDiamondPage) {
              _dealFreeDiamondTip();
            }
            PddUtil.instance.chargeDialogClose();
          },
        )).then((value) {
      isShowingChargeDialog = false;
    });
  }

  static _dealFreeDiamondTip() {
    if (UserInfo.to.rechargeClickCount >= 2) {
      UserInfo.to.rechargeClickCount = 1;
      showFreeDiamondTip();
    } else {
      UserInfo.to.rechargeClickCount++;
    }
  }

  static int lastLoadTime = 0;

  //缓存折扣商品数据 如果是限时折扣商品 本地有缓存则不做处理 本地无缓存则缓存至本地 每次获取到的商品是限时折扣商品则清除 首充/单次的缓存数据
  static saveDiscountProduct(PayQuickCommodite? payListDataCommodities) {
    String discountProductString = jsonEncode(payListDataCommodities?.toJson());
    var _prefs = StorageService.to.prefs;
    var myId = UserInfo.to.userLogin?.userId ?? "";
    //限时折扣商品
    if (payListDataCommodities?.discountType == 3) {
      //本地没有限时折扣的商品 则添加至缓存 本地有限时折扣则不做处理 且清除首充或者单次折扣的商品缓存
      if (timeLimitDiscountProduct == null) {
        _prefs.setString(_timeLimitDiscountKey + myId, discountProductString);
      }
      //缓存到的是限时折扣商品 则清除本地普通折扣商品的缓存
      _prefs.remove(_discountKey + myId);
    } else {
      //调用接口获取的最新优惠商品数据 首充/单次 非限时
      _prefs.setString(_discountKey + myId, discountProductString);
    }
  }

  //普通折扣商品的缓存
  static PayCutCommodite? get discountProduct {
    var _prefs = StorageService.to.prefs;
    var myId = UserInfo.to.userLogin?.userId ?? "";
    String? discountString = _prefs.getString(_discountKey + myId);
    if ((discountString ?? '').isNotEmpty && discountString != 'null') {
      PayCutCommodite payListDataCommodities =
          JsonConvert.fromJsonAsT<PayCutCommodite>(
              jsonDecode(discountString ?? ''))!;
      return payListDataCommodities;
    }
    return null;
  }

  //限时折扣商品的缓存
  static PayCutCommodite? get timeLimitDiscountProduct {
    var _prefs = StorageService.to.prefs;
    var myId = UserInfo.to.userLogin?.userId ?? "";
    String? discountString = _prefs.getString(_timeLimitDiscountKey + myId);
    if (discountString is String) {
      PayCutCommodite payListDataCommodities =
          JsonConvert.fromJsonAsT<PayCutCommodite>(jsonDecode(discountString))!;
      return payListDataCommodities;
    }
    return null;
  }

  static removeDiscountProduct() async {
    var _prefs = StorageService.to.prefs;
    var myId = UserInfo.to.userLogin?.userId ?? "";
    await _prefs.remove(_discountKey + myId);
  }

  static removeTimeLimitDiscountProduct() async {
    var _prefs = StorageService.to.prefs;
    var myId = UserInfo.to.userLogin?.userId ?? "";
    await _prefs.remove(_timeLimitDiscountKey + myId);
  }
}
