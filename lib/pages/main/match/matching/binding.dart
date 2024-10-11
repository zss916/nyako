part of matching_page;

class MatchingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MatchingLogic>(MatchingLogic());
  }
}
