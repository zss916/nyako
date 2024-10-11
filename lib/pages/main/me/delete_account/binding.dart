part of 'index.dart';

class DeleteAccountBinding implements Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<DeleteAccountLogic>(() => DeleteAccountLogic());
}
