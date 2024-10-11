part of 'index.dart';

class FollowLogic extends GetxController implements ILoadService {
  late int anchorPage = 1;
  late int followPage = 1;
  late List<HostDetail> upDetailList = [];
  late List<HostDetail> followList = [];
  late List<BannerBean> banners = [];
  late String areaCode = (StorageService.to.getAreaCode()).toString();
  AreaData? currentArea;

  /// 当前地区

  late RefreshController refreshCtrl = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);
  late RefreshController refreshCtrlF = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);
  late ScrollController ctl = ScrollController();

  late StreamSubscription<FollowEvent> followEvent;
  late StreamSubscription<BlackEvent> blackEvent;
  late final StreamSubscription<AreaData> areaEvent;
  late final StreamSubscription<SocketHostState> sub;

  @override
  void onInit() {
    super.onInit();

    followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {
      refreshFollowData();
    });

    blackEvent = AppEventBus.eventBus.on<BlackEvent>().listen((event) {
      refreshFollowData();
    });

    areaEvent = AppEventBus.eventBus.on<AreaData>().listen((event) {
      //ctl.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      ctl.jumpTo(0);
      update();
      areaCode = (event.areaCode ?? -1).toString();
      refreshData();
    });

    ///主播状态更新
    sub = StorageService.to.eventBus.on<SocketHostState>().listen((event) {
      // debugPrint("HostDetail ===>> ${event.toJson()}");
      bool needRefresh = false;
      for (HostDetail her in upDetailList) {
        if (her.userId == event.userId) {
          her.isOnline = event.isOnline;
          her.isDoNotDisturb = event.isDoNotDisturb;
          needRefresh = true;
          break;
        }
      }
      if (needRefresh) {
        update();
      }
    });

    AppLoading.show();
    // AppTestFbEvent.start();
  }

  @override
  void onReady() {
    super.onReady();
    //NotificationManager.getToken();
    refreshData();
    getBanner();
    refreshFollowData();
  }

  @override
  void dispose() {
    super.dispose();
    ctl.dispose();
    AppLoading.dismiss();
  }

  @override
  void onClose() {
    super.onClose();
    refreshCtrl.dispose();
    refreshCtrlF.dispose();
    followEvent.cancel();
    areaEvent.cancel();
    blackEvent.cancel();
    sub.cancel();
    //ctl.dispose();
  }

  @override
  void refreshData() {
    _loadDta(anchorPage = 1, areaCode: areaCode);
    // TradeCenter.to.reloadAllData();
  }

  @override
  void loadMoreData() {
    _loadDta(++anchorPage, areaCode: areaCode);
  }

  @override
  void refreshAndLoadCtl(bool isRefresh) {
    isRefresh ? refreshCtrl.refreshCompleted() : refreshCtrl.loadComplete();
  }

  @override
  void refreshFollowData() {
    _loadFollow(followPage = 1);
  }

  @override
  void loadMoreFollowData() {
    _loadFollow(++followPage);
  }

  @override
  void refreshAndLoadFollowCtl(bool isRefresh) {
    isRefresh ? refreshCtrlF.refreshCompleted() : refreshCtrlF.loadComplete();
  }

  _loadDta(int page, {String areaCode = "-1"}) {
    Http.instance
        .post<UpListData>(NetPath.upListApi + areaCode, data: {
          "page": page,
          "pageSize": 30,
          "isShowResource": 1,
        }, errCallback: (err) {
          AppLoading.toast(err.message);
          refreshAndLoadCtl(page == 1);
        })
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
          // debugPrint("_loadDta====>>>> ${value.anchorLists?.length}");
          upDetailList.clear();
          setCurrentArea(value);
          setAnchorData(page, value);
          saveHostSimpleInfo(value.anchorLists);
          refreshAndLoadCtl(page == 1);
        })
        .catchError((err) {
          AppLoading.toast(err.message);
          refreshAndLoadCtl(page == 1);
        });
  }

  void saveHostSimpleInfo(List<HostDetail>? anchorLists) {
    if (anchorLists == null || anchorLists.isEmpty) return;
    for (HostDetail her in anchorLists) {
      StorageService.to.objectBoxMsg.putOrUpdateHer(
          HerEntity(her.nickname ?? '', her.userId!, portrait: her.portrait));
    }
  }

  ///刷新当前地区
  setCurrentArea(UpListData value) {
    if (value.curAreaCode != null) {
      for (var element in (value.areaList ?? [])) {
        if (element.areaCode == (value.curAreaCode ?? '')) {
          currentArea = element;
          update(['currentAreaId']);
        }
      }
    }
  }

  ///刷新主播数据
  setAnchorData(int page, UpListData data) {
    if (page == 1) {
      if (data.anchorLists != null) {
        upDetailList.addAll(data.anchorLists ?? []);
      }
    } else {
      final List<String> userIds =
          upDetailList.map((e) => e.userId ?? '').toList();
      for (final item in data.anchorLists!) {
        if (!userIds.contains(item.userId)) {
          upDetailList.add(item);
        }
      }
    }
    update();
  }

  _loadFollow(int page) {
    Http.instance
        .post<List<HostDetail>>("${NetPath.followUpListApi}1", data: {
          "page": page,
          "pageSize": 10,
        }, errCallback: (err) {
          AppLoading.toast(err.message);
          refreshAndLoadFollowCtl(page == 1);
        })
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
          // debugPrint("black ===> ddd ${value.length}");
          if (page == 1) {
            followList.clear();
          }
          followList.addAll(value);
          update();
          refreshAndLoadFollowCtl(page == 1);
        });
  }

  getBanner() async {
    final value = await CommonAPI.loadBanner();
    banners.clear();
    banners.addAll(value);
    update();
  }

  pushAnchorDetail(HostDetail mo) {
    // debugPrint("pushAnchorDetail ===>>> ${mo.toJson()}");
    if (mo.userId != null) {
      ARoutes.toAnchorDetail(mo.userId);
    }
  }

  ///呼叫主播
  callUp(HostDetail item) {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      ARoutes.toCalling(anchorId: item.getUid, portrait: item.showPortrait);
    });
  }

  ///与主播私聊
  startMsg(String anchorId) => ARoutes.toChat(anchorId);

  remove(int i) {
    if (upDetailList.isNotEmpty && (i != -1)) {
      upDetailList.removeAt(i);
      update();
    }
  }
}
