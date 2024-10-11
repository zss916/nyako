part of 'index.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutLogic>(() => AboutLogic());
  }
}
