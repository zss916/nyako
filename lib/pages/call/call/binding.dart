part of 'index.dart';

class CallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallLogic>(() => CallLogic());
  }
}
