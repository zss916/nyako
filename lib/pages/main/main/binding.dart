part of 'index.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainLogic>(MainLogic());
    Get.put<MsgListLogic>(MsgListLogic());
    Get.put<MomentLogic>(MomentLogic());
    Get.put<HomeLogic>(HomeLogic());
    Get.put<MatchLogic>(MatchLogic());
    Get.put<MeLogic>(MeLogic());
  }
}
