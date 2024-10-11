part of 'index.dart';

class SetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetLogic>(() => SetLogic());
  }
}
