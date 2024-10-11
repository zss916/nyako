part of 'index.dart';

class RewardDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RewardDetailsLogic>(() => RewardDetailsLogic());
  }
}
