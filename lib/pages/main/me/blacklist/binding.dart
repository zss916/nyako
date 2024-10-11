part of 'index.dart';

class BlackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlackLogic>(() => BlackLogic());
  }
}
