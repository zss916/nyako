part of connect_fail;

class FailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FailLogic>(FailLogic());
  }
}
