part of aiv_page;

class AivBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AivLogic>(() => AivLogic());
  }
}