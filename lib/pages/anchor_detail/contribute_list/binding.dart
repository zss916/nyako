part of contribute_list_page;

class ContributeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributeListLogic>(() => ContributeListLogic());
  }
}
