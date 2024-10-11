part of 'index.dart';

class PropBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropLogic>(() => PropLogic());
  }
}
