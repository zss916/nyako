part of 'index.dart';

class PublicBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicLogic>(() => PublicLogic());
  }
}
