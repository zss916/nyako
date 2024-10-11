part of 'index.dart';

class DynamicBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicLogic>(() => DynamicLogic());
  }
}
