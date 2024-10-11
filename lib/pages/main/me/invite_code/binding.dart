part of 'index.dart';

class InviteCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteCodeLogic>(() => InviteCodeLogic());
  }
}
