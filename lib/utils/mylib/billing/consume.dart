import 'package:nyako/http/api/index.dart';
import 'package:nyako/services/storage_service.dart';

class ConsumeUtil {
  static void updateOrderPayTime(String orderId) {
    StorageService.to.objectBoxOrder.updateOrderPayTime(orderId);
  }

  static void notify(
      {required String signature,
      required String jsonPurchaseInfo,
      required bool isfixOrder,
      Function? consume}) {
    BillingAPI.notify(
            signature: signature,
            jsonPurchaseInfo: jsonPurchaseInfo,
            isfixorder: isfixOrder)
        .then((value) {
      consume?.call();
    });
  }
}
