part of local_page;

class LocalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalLogic>(() => LocalLogic());
  }
}