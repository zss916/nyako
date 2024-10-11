part of settlement_page;

class EndBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<EndLogic>(() => EndLogic());
    //Get.put<EndLogic>(EndLogic(),tag: (Get.arguments).toString());
  }
}
