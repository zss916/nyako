import 'package:oliapro/utils/mylib/billing/google_billing.dart';

class AppGoogleBilling {
  static fixNoEndPurchase() {
    GoogleBilling.fixNoEndPurchase();
  }

  static Future<(int? price, String? currencyCode)> correctQuickGooglePrice(
      String productId) {
    return GoogleBilling.correctQuickGooglePrice(productId);
    //return Future.value((null, null));
  }

  static callPay(
      {String? productId,
      String? accountId,
      String? orderNo,
      Function? paySuccessful,
      Function(int)? payFail}) async {
    GoogleBilling.callPay(
        productId: productId,
        accountId: accountId,
        orderNo: orderNo,
        paySuccessful: paySuccessful,
        payFail: payFail);
  }
}
