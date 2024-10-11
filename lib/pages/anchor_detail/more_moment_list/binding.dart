part of more_moments_page;

class MoreDynamicBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreDynamicLogic>(() => MoreDynamicLogic());
  }
}
