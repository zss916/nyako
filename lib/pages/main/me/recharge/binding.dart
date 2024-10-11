part of 'index.dart';

class RechargeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeLogic>(() => RechargeLogic());
  }
}
