part of 'index.dart';

class RemoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteLogic>(() => RemoteLogic());
  }
}
