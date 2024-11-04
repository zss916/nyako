part of matching_page;

class MatchingLogic extends GetxController {
  late Debouncer debouncer;

  @override
  void onInit() {
    super.onInit();
    HostMatchLimitEntityAnchor anchor =
        Get.arguments as HostMatchLimitEntityAnchor;
    debouncer = Debouncer(delay: const Duration(seconds: 3));
    debouncer.call(() => showMatch(anchor));
  }

  @override
  void onReady() {
    super.onReady();
    safeFind<MatchLogic>()?.getMatchCount();
  }

  @override
  void onClose() {
    super.onClose();
    debouncer.cancel();
  }
}
