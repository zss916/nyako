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

  var currentOnline = 0.obs;

  @override
  void onInit() {
    currentOnline.value = Random().nextInt(2000) + 1500;
    super.onInit();
    sub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == vipRefresh) {
        getVip(showLoading: false);
        getMatchCount();
      }
      if (event == "userRefresh") {
        getVip(showLoading: false);
        getMatchCount();
      }
    });
    timeHandle();
  }

  void timeHandle() {
    bool add = Random().nextBool(); //   加还是减
    int value = Random().nextInt(40) + 20; // 变化幅度  20 - 60
    if (add) {
      if (value + currentOnline.value > 5000) {
        add = false;
      }
    } else {
      if (currentOnline.value - value < 800) {
        add = true;
      }
    }
    if (add) {
      currentOnline.value = currentOnline.value + value;
    } else {
      currentOnline.value = currentOnline.value - value;
    }
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

  getVip({bool showLoading = true}) async {
    final data = await ProfileAPI.info(showLoading: showLoading);
    UserInfo.to.setMyDetail = data;
    isUserVip = (data.isVip == 1);
    update(["vip", "count"]);
  }

  getMatchCount() async {
    final data = await MatchAPI.matchCount(showLoading: true);
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

  toMatch(MatchLogic logic) {
    if ((!logic.isLimit) || logic.isUserVip) {
      if (!AppConstants.isMatching) {
        AppConstants.isMatching = true;
        MatchAPI.matchOneLimit().then((data) {
          ARoutes.toMatching(
              anchor: data.anchor ?? HostMatchLimitEntityAnchor());
        }).whenComplete(() {
          AppConstants.isMatching = false;
        });
      } else {
        //AppLoading.toast("Waiting ....");
      }
    } else {
      sheetToVip(path: ChargePath.recharge_vip_dialog_match, index: 2);
    }
  }
}
