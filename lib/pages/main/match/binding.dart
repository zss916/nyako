part of match_page;

class GameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MatchLogic>(MatchLogic());
  }
}
