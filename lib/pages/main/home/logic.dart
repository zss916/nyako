part of 'index.dart';

class HomeLogic extends GetxController implements ILoadService {
  late int anchorPage = 1;
  late int followPage = 1;
  late List<HostDetail> followList = [];
  late List<HostDetail> upDetailList = [];
  late List<BannerBean> banners = [];
  late String areaCode = (StorageService.to.getAreaCode()).toString();
  AreaData? currentArea;

  /// 当前地区

  late StreamSubscription<FollowEvent> followEvent;
  // late final StreamSubscription<AreaData> areaEvent;
  late final StreamSubscription<SocketHostState> sub;
  late final StreamSubscription<BlackEvent> blackEvent;

  late final StreamSubscription<ReportEvent> reportEvent;

  late bool state = AppLoading.isShow();

  late RefreshController refreshCtrl = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);
  late RefreshController refreshCtrlF = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);

  late int followState = Status.INIT.index; // 0 empty, 1 loading ,2 list

  @override
  void onInit() {
    super.onInit();
    followState = Status.INIT.index;
    update();

    followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {
      refreshFollowData();
    });

    /* areaEvent = AppEventBus.eventBus.on<AreaData>().listen((event) {
      //ctl.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
      ctl.jumpTo(0);
      update();
      areaCode = (event.areaCode ?? -1).toString();
      refreshData();
    });*/

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

    blackEvent = AppEventBus.eventBus.on<BlackEvent>().listen((event) {
      upDetailList.removeWhere((element) => element.userId == event.uid);
      followList.removeWhere((element) => element.userId == event.uid);
      update();
    });

    /*reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      if (ReportEnum.anchorDetailImage.index == event.type) {
        upDetailList.removeWhere((element) => element.userId == event.uid);
        followList.removeWhere((element) => element.userId == event.uid);
        update();
      }
    });*/
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
    blackEvent.cancel();
    reportEvent.cancel();
    AppLoading.dismiss();
    super.dispose();
  }

  @override
  void onClose() {
    refreshCtrl.dispose();
    refreshCtrlF.dispose();
    followEvent.cancel();
    //areaEvent.cancel();
    sub.cancel();
    super.onClose();
    //ctl.dispose();
  }

  @override
  void refreshData() {
    _loadDta(anchorPage = 1, areaCode: areaCode);
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
    followList.clear();
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
          // debugPrint("_loadDta====>>> ${value.anchorLists?.length}");
          setCurrentArea(value);
          StorageService.to.saveAreaCode(currentArea?.areaCode ?? -1);
          setAnchorData(page, value);
          saveHostSimpleInfo(value.anchorLists);
          saveAreaList(value.getArea());
          refreshAndLoadCtl(page == 1);
        })
        .catchError((err) {
          AppLoading.toast(err.message);
          refreshAndLoadCtl(page == 1);
        });
  }

  void handleData(
    List<HostDetail> list,
  ) {
    // compute((message) => null, message);
    //dataList.clear();
    for (var host in list) {
      if (host.videos != null && host.videos!.isNotEmpty) {
        // 做下资源去除拉黑的
        for (var video in host.videos!) {
          if (StorageService.to
              .checkMediaReportList((video.mid ?? 0).toString())) {
            host.videos!.remove(video);
          }
        }
        if (host.videos != null && host.videos!.isNotEmpty) {
          // dataList.add(host);
        }
      }
    }
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
      upDetailList.clear();
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
          //debugPrint("====>>> list len:${value.length},===>> $page");
          followList.addAll(value);
          refreshAndLoadFollowCtl(page == 1);
          followState =
              followList.isEmpty ? Status.EMPTY.index : Status.DATA.index;
          update();
        });
  }

  getBanner() async {
    final value = await CommonAPI.loadBanner();
    banners.clear();
    banners.addAll(value);
    update();
  }

  pushAnchorDetail(HostDetail mo) {
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

  void sort() {
    upDetailList.sort((a, b) => b.sortOnline.compareTo(a.sortOnline));
    update();
  }

  ///缓存地区数据
  void saveAreaList(List<AreaData> data) {
    StorageService.to.saveAreaList(data);
  }

  void areaRefreshData(int code) {
    update();
    areaCode = code.toString();
    refreshData();
  }
}
