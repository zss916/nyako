part of 'index.dart';

abstract class BillingAPI {
  static Future notify({
    required String signature,
    required String jsonPurchaseInfo,
    required bool isfixorder,
  }) async {
    await Http.instance.post<void>(NetPath.googleNotifyApi, data: {
      "signature": signature,
      "jsonPurchaseInfo": jsonPurchaseInfo,
      "isfixorder": isfixorder,
    });
  }

  ///埋点
  static Future update({required int type, required int code}) async {
    await Http.instance.post<void>(
      '${NetPath.appCallStatistics}/$type/$code',
    );
  }
}
