part of 'index.dart';

class FollowBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FollowLogic>(FollowLogic());
  }
}
