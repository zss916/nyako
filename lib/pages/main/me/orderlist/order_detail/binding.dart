import 'package:get/get.dart';
import 'package:oliapro/pages/main/me/orderlist/order_detail/logic.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OrderDetailLogic>(OrderDetailLogic());
  }
}
