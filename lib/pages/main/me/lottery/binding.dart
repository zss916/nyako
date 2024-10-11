part of 'index.dart';

class LotteryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LotteryLogic>(() => LotteryLogic());
  }
}
