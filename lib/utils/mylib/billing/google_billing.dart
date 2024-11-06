import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:nyako/utils/mylib/billing/consume.dart';

class GoogleBilling {
  static BillingClient billingClient =
      BillingClient(purchasesUpdatedListener, null);

  static PurchasesUpdatedListener purchasesUpdatedListener =
      (PurchasesResultWrapper purchasesResult) {
    switch (purchasesResult.responseCode) {
      case BillingResponse.ok:

        ///购买商品成功
        for (var purchaseWrapper in purchasesResult.purchasesList) {
          consumeAsync(purchaseWrapper);
        }
        break;
      case BillingResponse.userCanceled:

        ///用户取消
        break;
      case BillingResponse.serviceUnavailable:

        ///网络断开
        break;
      case BillingResponse.serviceDisconnected:

        ///服务没有连接
        break;
      case BillingResponse.serviceTimeout:

        ///服务超时
        break;
      case BillingResponse.error:

        ///购买失败
        break;
      default:
        break;
    }
  };

  ///更正google价格
  static Future<(int? price, String? currencyCode)> correctQuickGooglePrice(
      String productId) async {
    BillingResultWrapper billingRw = await billingClient.startConnection(
        onBillingServiceDisconnected: () {});
    if (billingRw.responseCode == BillingResponse.ok) {
      List<ProductWrapper> productList = [];
      productList.add(
          ProductWrapper(productId: productId, productType: ProductType.inapp));
      ProductDetailsResponseWrapper skuDetailsResponseWrapper =
          await billingClient.queryProductDetails(productList: productList);
      List<ProductDetailsWrapper> skuDRW =
          skuDetailsResponseWrapper.productDetailsList;
      if (skuDRW.isNotEmpty) {
        ProductDetailsWrapper skuDetail = skuDRW.first;
        int gPrice =
            (skuDetail.oneTimePurchaseOfferDetails?.priceAmountMicros) ?? 0;
        String? gCurrencyCode =
            skuDetail.oneTimePurchaseOfferDetails?.priceCurrencyCode;
        int googlePrice = gPrice ~/ 10000;
        String? googleCurrencyCode = gCurrencyCode;
        return (googlePrice, googleCurrencyCode);
      } else {
        return (null, null);
      }
    } else {
      return (null, null);
    }
  }

  ///消费
  static consumeAsync(PurchaseWrapper purchaseWrapper,
      {bool isFixOrder = false}) async {
    //google pay 确认api 防止3天自动退款
    if (purchaseWrapper.purchaseState == PurchaseStateWrapper.purchased) {
      billingClient.acknowledgePurchase(purchaseWrapper.purchaseToken);
      var orderId = purchaseWrapper.obfuscatedProfileId;
      if (orderId != null) {
        ConsumeUtil.updateOrderPayTime(orderId);
      }
    }

    ConsumeUtil.notify(
        signature: purchaseWrapper.signature,
        jsonPurchaseInfo: purchaseWrapper.originalJson,
        isfixOrder: isFixOrder,
        consume: () {
          billingClient.consumeAsync(purchaseWrapper.purchaseToken);
        });
  }

  ///完成没有结束的交易
  static fixNoEndPurchase() async {
    BillingResultWrapper stateListener = await billingClient.startConnection(
        onBillingServiceDisconnected: () {});

    if (stateListener.responseCode == BillingResponse.ok) {
      ///获取购买过的 未结束的交易
      PurchasesResultWrapper purchasesRW =
          await billingClient.queryPurchases(ProductType.inapp);

      for (var purchaseWrapper in purchasesRW.purchasesList) {
        ///  调用接口获取该交易的状态 成功则结束该交易
        consumeAsync(purchaseWrapper, isFixOrder: true);
      }
    }
  }

  ///支付调用
  static callPay(
      {String? productId,
      String? accountId,
      String? orderNo,
      Function? paySuccessful,
      Function(int)? payFail}) async {
    BillingResultWrapper billingRW = await billingClient.startConnection(
        onBillingServiceDisconnected: () {});
    if (billingRW.responseCode == BillingResponse.ok) {
      ///支付连接成功
      List<ProductWrapper> productList = [];
      productList.add(ProductWrapper(
        productId: productId ?? "",
        productType: ProductType.inapp,
      ));
      ProductDetailsResponseWrapper skuDRW =
          await billingClient.queryProductDetails(productList: productList);
      if (skuDRW.productDetailsList.isNotEmpty) {
        ProductDetailsWrapper skuDW = skuDRW.productDetailsList.first;
        await billingClient.launchBillingFlow(
          product: skuDW.productId,
          accountId: accountId,
          obfuscatedProfileId: orderNo,
        );

        ///调起Google支付页面
        paySuccessful?.call();
      } else {
        /// 商品没有找到支付失败
        payFail?.call(3004);
      }
    } else {
      /// 支付连接失败
      payFail?.call(3003);
    }
  }
}
