part of 'index.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginLogic>(LoginLogic());
  }
}
