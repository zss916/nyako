part of 'index.dart';

class ToVipBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VipLogic>(() => VipLogic());
  }
}
