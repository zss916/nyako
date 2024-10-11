part of 'index.dart';

class AccountLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountLoginLogic>(() => AccountLoginLogic());
  }
}
