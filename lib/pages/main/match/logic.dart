part of match_page;

class MatchLogic extends GetxController with BgmControl {
  ///前
  late List<HostDetail> hostList = [];

  ///后
  late bool isUserVip = false;
  late bool isLimit = false;
  late int count = 10;
  late HostMatchLimitEntityAnchor host = HostMatchLimitEntityAnchor();
  late final StreamSubscription<String> sub;
  @override
  void onInit() {
    super.onInit();
    sub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == "vipRefresh") {
        getVip();
        getMatchCount();
      }
      if (event == "userRefresh") {
        getVip();
        getMatchCount();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getVip();
    loadMatch();
    getMatchCount();
    //debounce(listener, (callback) => null);
  }

  @override
  void onClose() {
    sub.cancel();
    super.onClose();
  }

  shuffle() {
    update(["anchors"]);
    AppLoading.show();
    Future.delayed(const Duration(seconds: 1), () {
      AppLoading.dismiss();
      update(["anchors"]);
    });
  }

  getVip() async {
    final data = await ProfileAPI.info();
    UserInfo.to.setMyDetail = data;
    isUserVip = (data.isVip == 1);
    update(["vip", "count"]);
  }

  getMatchCount() async {
    final data = await MatchAPI.matchCount();
    int matchNum = data;
    count = (matchNum < 10) ? matchNum : 10;
    isLimit = (matchNum >= 10);
    update(["count"]);
  }

  getMatchResult({Function? onRestart, MatchLogic? logic}) async {
    final data = await MatchAPI.matchOneLimit();
    // debugPrint("anchor33==> ${data.toJson()}");
    getMatchCount();
    host = data.anchor!;
    // hostList.shuffle();
    // update(["anchors"]);
    showMatch(host, onRestart: onRestart, logic: logic);
    loadMatch();
  }

  void loadMatch() {
    Http.instance
        .post<List<HostDetail>>("${NetPath.getMatchUpListApi}10",
            errCallback: (err) {
          AppLoading.toast(err.message);
        })
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
          hostList.addAll((value));
          hostList.shuffle();
          update(["anchors"]);
        })
        .catchError((err) {
          AppLoading.toast(err.message);
        });
  }
}
