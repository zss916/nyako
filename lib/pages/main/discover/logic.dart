part of 'index.dart';

class MomentLogic extends GetxController implements ILoadService {
  late RefreshController refreshCtrl = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);
  late List<MomentDetail> data = [];
  late int pageIndex = 1;
  late final StreamSubscription<ReportEvent> reportEvent;
  late String areaCode = (StorageService.to.getAreaCode()).toString();

  late final StreamSubscription<SocketHostState> sub;

  ///发现
  late List<HostDetail> dataList = [];
  late List<HostDetail> dataList2 = [];
  late int page = 1;

  @override
  void onInit() {
    super.onInit();
    sub = StorageService.to.eventBus.on<SocketHostState>().listen((event) {
      for (HostDetail her in dataList) {
        if (her.userId == event.userId) {
          her.isOnline = event.isOnline;
          her.isDoNotDisturb = event.isDoNotDisturb;
          break;
        }
      }
    });

    reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      if ((ReportEnum.moment.index == event.type) ||
          (ReportEnum.momentDetail.index == event.type)) {
        data.removeWhere(
            (e) => StorageService.to.checkMomentReportList(e.momentId));
        update();
      }

      if (ReportEnum.discover.index == event.type) {
        if (event.discoverIndex != null) {
          int index = int.parse(event.discoverIndex ?? "-1");
          if (index != -1) {
            dataList2.clear();
            dataList.removeAt(index);
            dataList2.addAll(dataList);
            dataList.clear();
            dataList.addAll(dataList2);
            update(["discover"]);
          }
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    reportEvent.cancel();
    sub.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    //refreshData();
    refreshDiscoverData();
  }

  @override
  void refreshData() {
    data.clear();
    _loadDta(pageIndex = 1);
  }

  @override
  void loadMoreData() {
    _loadDta((++pageIndex));
  }

  @override
  void refreshAndLoadCtl(bool isRefresh) {
    isRefresh ? refreshCtrl.refreshCompleted() : refreshCtrl.loadComplete();
  }

  ///呼叫主播
  callUp(String anchorId, String portrait) {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      ARoutes.toCalling(anchorId: anchorId, portrait: portrait);
    });
  }

  ///与主播私聊
  startMsg(String anchorId) => ARoutes.toChat(anchorId);

  ///主播详情
  toAnchorDetail(String userId) => ARoutes.toAnchorDetail(userId);

  _loadDta(int page) {
    Http.instance.post<List<MomentDetail>>(NetPath.getMoments2, data: {
      "page": page,
      "pageSize": 20,
    }, errCallback: (err) {
      AppLoading.toast(err.message);
      refreshAndLoadCtl(page == 1);
    }).then((value) {
      if (page == 1) {
        data.clear();
        data.addAll(value);

        ///删除拉黑
        // data.removeWhere((e) => StorageService.to.checkMomentReportList(e.momentId));
        update();
      } else {
        // 去重
        for (var an in value) {
          if (!data.contains(an)) {
            data.add(an);
          }
        }
        // data.removeWhere((e) => StorageService.to.checkMomentReportList(e.momentId));
        update();
      }

      refreshAndLoadCtl(page == 1);
    }).catchError((e) {
      AppLoading.toast(e.message);
      refreshAndLoadCtl(page == 1);
    });
  }

  ///刷新发现数据
  void refreshDiscoverData({bool isLoading = false, bool isShowClean = false}) {
    page = 1;
    dataList.clear();
    if (isShowClean) update(["discover"]);
    Http.instance
        .post<UpListData>(NetPath.upListApi + areaCode,
            data: {
              "page": 1,
              "pageSize": 30,
              "isShowResource": 1,
              "onlyVideo": 1,
            },
            showLoading: isLoading)
        .then((data) {
      areaCode = (data.curAreaCode ?? -1).toString();
      List<HostDetail> result = [];
      for (var an in data.anchorLists!) {
        if (an.videos != null &&
            an.videos!.isNotEmpty &&
            !dataList.contains(an)) {
          // 做下资源去除拉黑的
          for (var video in an.videos!) {
            if (StorageService.to
                .checkMediaReportList((video.mid ?? 0).toString())) {
              an.videos!.remove(video);
            }
          }
          if (an.videos != null && an.videos!.isNotEmpty) {
            result.add(an);
          }
        }
      }
      dataList.addAll(result);
      update(["discover"]);
    });
  }

  ///刷新
  void shuffleDiscover() {
    List<HostDetail> onLines =
        dataList.where((element) => element.isChat).toList()..shuffle();
    List<HostDetail> onOffs =
        dataList.where((element) => !element.isChat).toList()..shuffle();
    dataList.clear();
    update(["discover"]);
    dataList
      ..addAll(onLines)
      ..addAll(onOffs);
    update(["discover"]);
  }

  ///加载更多发现数据
  loadMoreDiscoverData({bool loading = false}) {
    _getDiscoverData(page, loading: loading);
  }

  ///发现数据
  _getDiscoverData(int page, {bool loading = false}) async {
    page = page + 1;
    Http.instance
        .post<UpListData>(NetPath.upListApi + areaCode,
            data: {
              "page": page,
              "pageSize": 30,
              "isShowResource": 1,
              "onlyVideo": 1,
            },
            showLoading: loading)
        .then((data) {
      areaCode = (data.curAreaCode ?? -1).toString();
      List<HostDetail> result = [];
      for (var an in data.anchorLists!) {
        if (an.videos != null &&
            an.videos!.isNotEmpty &&
            !dataList.contains(an)) {
          // 做下资源去除拉黑的
          for (var video in an.videos!) {
            if (StorageService.to
                .checkMediaReportList((video.mid ?? 0).toString())) {
              an.videos!.remove(video);
            }
          }
          if (an.videos != null && an.videos!.isNotEmpty) {
            result.add(an);
          }
        }
      }
      page = result.isEmpty ? (page - 1) : page;
      dataList.addAll(result);
      update(["discover"]);
    });
  }
}
