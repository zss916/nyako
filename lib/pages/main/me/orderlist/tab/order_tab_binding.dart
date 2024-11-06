import 'package:get/get.dart';
import 'package:nyako/pages/main/me/orderlist/cost_list/cost_list_logic.dart';
import 'package:nyako/pages/main/me/orderlist/order_list/order_list_logic.dart';

class OrderTabBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CostListLogic>(CostListLogic());
    Get.put<OrderListLogic>(OrderListLogic());
  }
}
