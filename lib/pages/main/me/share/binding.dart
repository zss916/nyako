part of 'index.dart';

class ShareBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareLogic>(() => ShareLogic());
  }
}
