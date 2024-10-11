import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/database/entity/app_order_entity.dart';
import 'package:oliapro/entities/app_charge_entity.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/game/game_dialog_manager.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/mylib/billing/app_google_billing.dart';
import 'package:url_launcher/url_launcher.dart';

class Billing {
  static fixNoEndPurchase() => AppGoogleBilling.fixNoEndPurchase();

  static Future<bool> correctQuickGooglePrice(PayQuickChannel channel) async {
    (int? price, String? currencyCode) data =
        await AppGoogleBilling.correctQuickGooglePrice(channel.productCode!);
    channel.googlePrice = data.$1;
    channel.googleCurrencyCode = data.$2;
    return (data.$1 != null && data.$2 != null);
  }

  static _callPay({String? productId, String? orderNo}) async {
    if (productId == null) {
      handPayCallBack(3001);
      return;
    }
    if (orderNo == null) {
      handPayCallBack(3002);
      return;
    }

    AppGoogleBilling.callPay(
        productId: productId,
        accountId: UserInfo.to.uid,
        orderNo: orderNo,
        paySuccessful: () {
          handPayCallBack(3005, repay: () {
            _callPay(productId: productId, orderNo: orderNo);
          });
        },
        payFail: (code) {
          handPayCallBack(code, repay: () {
            _callPay(productId: productId, orderNo: orderNo);
          });
        });
  }

  static tryCorrectGooglePrice(List<PayQuickCommodite>? allProducts,
      {Function? fun}) {
    List<PayQuickCommodite> allList = [];
    if (allProducts != null) {
      allList.addAll(allProducts);
    }
    for (var comm in allList) {
      if (comm.ppp != null) {
        for (var channel in comm.ppp!) {
          if (channel.ppType == 1) {
            correctQuickGooglePrice(channel).then((value) {
              // 正在选择渠道的时候刷新页面
              fun?.call();
            });
            continue;
          }
        }
      }
    }
  }

  ///快捷支付
  static createQPay(PayQuickChannel channel,
      {String? createPath, String? upid, int? countryCode}) {
    AppConstants.isCreatePayOrder = true;
    var a = {
      "productCode": channel.productCode ?? "",
      "storeCode": channel.storeCode ?? "",
      "ccType": channel.ccType ?? "",
      "ppType": channel.ppType ?? "",
      "currencyCode": channel.currency ?? "",
      "currencyFee": channel.currencyPrice ?? "",
      "refereeUserId": upid ?? "",
      'productId': channel.productId ?? "",
      "createPath": createPath ?? ChargePath.android_recharge_center,
      if (countryCode != null) "countryCode": countryCode,
    };
    // debugPrint("createQPay ==>${a.toString()}");

    Http.instance
        .post<CreateOrderBean>(
      NetPath.createOrderApi2,
      data: {
        "productCode": channel.productCode ?? "",
        "storeCode": channel.storeCode ?? "",
        "ccType": channel.ccType ?? "",
        "ppType": channel.ppType ?? "",
        "currencyCode": channel.currency ?? "",
        "currencyFee": channel.currencyPrice ?? "",
        "refereeUserId": upid ?? "",
        'productId': channel.productId ?? "",
        "createPath": createPath ?? ChargePath.android_recharge_center,
        if (countryCode != null) "countryCode": countryCode,
      },
      showLoading: true,
    )
        .then((value) {
      // 放进数据库
      StorageService.to.objectBoxOrder.putOrUpdateOrder(OrderEntity(
        userId: UserInfo.to.myDetail?.userId ?? '',
        orderNo: value.orderNo,
        productId: channel.productCode ?? "",
        price: channel.uploadUsd == 1
            ? (channel.price ?? '')
            : (channel.currencyPrice ?? 0).toString(),
        currency: channel.uploadUsd == 1 ? "USD" : channel.currency,
        payType: (channel.ppType ?? 0).toString(),
        type: 'Diamond',
        payTime: '',
        orderCreateTime: DateTime.now().millisecondsSinceEpoch.toString(),
      ));
      if (channel.ppType == 1) {
        if (AppConstants.openGooglePay) {
          _callPay(productId: channel.productCode, orderNo: value.orderNo);
        } else {
          AppLoading.toast("test mode google pay error");
        }
      } else if (channel.browserOpen == 1) {
        if ((value.ppUrl ?? "").isNotEmpty) {
          _openInOutBrowser(value.ppUrl!);
        }
      } else {
        if ((value.ppUrl ?? "").isNotEmpty) {
          ARoutes.toWeb(value.ppUrl!, false);
        }
        // GameDialogManager.openWeb(value.payUrl!);
      }
    });
  }

  static _openInOutBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    }
  }

  ///处理支付返回
  static void handPayCallBack(int code, {Function? repay}) {
    payCallBack(type: type, code: code);
    switch (code) {
      case 3001:
        AppLoading.toast(Tr.app_invoke_err.tr);
        break;
      case 3002:
        AppLoading.toast(Tr.app_err_unknown.tr);
        break;
      case 3003:
        AppLoading.toast(Tr.app_google_billing_init_failure.tr);
        GameDialogManager.showRechargeFail(
            state: "billing_init_failure",
            call: () {
              repay?.call();
            });
        break;
      case 3004:
        AppLoading.toast(Tr.app_google_billing_goods_not_find.tr);
        GameDialogManager.showRechargeFail(
            state: "goods_not_find",
            call: () {
              repay?.call();
            });
        break;
      case 3005:
        debugPrint("pay successful");

        break;
    }
  }

  ///支付埋点
  static Future<void> payCallBack({int? type, int? code}) async {
    BillingAPI.update(type: type ?? -1, code: code ?? -1);
  }

  static int type = 3000;
}
