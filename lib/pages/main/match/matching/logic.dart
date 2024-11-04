part of matching_page;

class MatchingLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3), () {
      toShowDialog();
      //showMatch(HostMatchLimitEntityAnchor());
    });
  }

  Future<void> toShowDialog() async {
    final data = await MatchAPI.matchOneLimit();
    showMatch(data.anchor ?? HostMatchLimitEntityAnchor());
  }
}
