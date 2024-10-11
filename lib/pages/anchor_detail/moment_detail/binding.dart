part of moment_detail_page;

class MomentDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MomentDetailLogic>(() => MomentDetailLogic());
  }
}
