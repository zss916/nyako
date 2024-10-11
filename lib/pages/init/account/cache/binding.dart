part of 'index.dart';

class AccountCacheBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AccountCacheLogic());
  }
}
