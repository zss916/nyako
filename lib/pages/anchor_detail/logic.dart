part of 'index.dart';

class AnchorDetailLogic extends GetxController implements ILoadService {
  AnchorState state = AnchorState();

  int pageIndex = 1;

  late RefreshController refreshController = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);

  late final StreamSubscription<ReportEvent> reportEvent;
  late final StreamSubscription<FollowEvent> followEvent;

  var myVapController = AppVapController();

  @override
  void onInit() {
    super.onInit();
    reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      if (ReportEnum.anchorDetail.index == event.type) {
        if (ARoutes.isAnchorDetails) {
          Get.back();
        }
      }
      if ((ReportEnum.anchorDetailMoment.index == event.type) ||
          (ReportEnum.momentDetail.index == event.type)) {
        state.moments.removeWhere(
            (e) => StorageService.to.checkMomentReportList(e.momentId));
        update();
      }

      if (ReportEnum.anchorDetailImage.index == event.type) {
        /*state.data.removeWhere(
            (e) => StorageService.to.checkMediaReportList(e.mid.toString()));
        update();*/
        if (ARoutes.isAnchorDetails) {
          Get.back();
        }
      }
    });
    followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {
      _getHostDetail();
      refreshData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments == null) {
      Get.back();
    }
    _getHostDetail();
    loadUserInfo();
    refreshData();
    loadRankList(state.anchorId.toString());
    PddUtil.instance.anchorDetailsInit(anchorId: state.anchorId.toString());
  }

  @override
  void onClose() {
    followEvent.cancel();
    reportEvent.cancel();
    PddUtil.instance.anchorDetailsClose();
    super.onClose();
  }

  ///主播详情
  _getHostDetail() {
    AppLoading.show();
    Http.instance.post<HostDetail>("${NetPath.upDetailApi}${state.anchorId}",
        data: {"vipVideo": AppConstants.isFakeMode ? "" : 1},
        errCallback: (err) {
      AppLoading.toast(err.message);
      AppLoading.dismiss();
    }).then((value) {
      // debugPrint("host ==》 ${value.toJson().toString()}");
      state.medias.clear();
      state.videos.clear();
      state.data.clear();
      Iterable<HostMedia> arr = (value.medias ?? <HostMedia>[]).where((e) =>
          !StorageService.to.checkMediaReportList((e.mid ?? 0).toString()));
      state.medias.addAll(arr.where((element) => element.type == 0));
      state.videos.addAll(arr.where((element) => element.type == 1));
      state.host = value;
      state.data.addAll(arr);
      update();
      StorageService.to.objectBoxMsg.putOrUpdateHer(HerEntity(
          value.nickname ?? '', value.userId!,
          portrait: value.portrait));
      AppLoading.dismiss();
    });
  }

  loadMoment(String userId, int page) {
    Http.instance.post<List<MomentDetail>>(NetPath.getMoments, data: {
      "page": page,
      "pageSize": 10,
      "userId": userId,
    }, errCallback: (err) {
      AppLoading.toast(err.message);
      refreshAndLoadCtl(page == 1);
    }).then((value) {
      // 筛掉黑名单的动态
      Iterable<MomentDetail> arr = value
          .where((e) => !StorageService.to.checkMomentReportList(e.momentId));
      state.moments.addAll(arr);
      refreshAndLoadCtl(page == 1);
      update();
    });
  }

  loadRankList(String anchorId) {
    Http.instance.post<List<ContributeEntity>>(
        NetPath.contributeList + anchorId,
        showLoading: true, errCallback: (error) {
      AppLoading.toast(error.message);
    }).then((value) {
      state.contributions.assignAll(value);
      update();
    });
  }

  follow() {
    if (state.host.followed == 1) {
      Get.dialog(AppDialogConfirm(
        title: Tr.app_details_tip.tr,
        showIcon: false,
        h: 260,
        callback: (i) {
          requestFollow();
        },
      ));
    } else {
      requestFollow();
    }
  }

  void requestFollow() {
    state.host.followed = (state.host.followed == 1 ? 0 : 1);
    Http.instance.post<int>("${NetPath.followUpApi}${state.anchorId}",
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      AppEventBus.eventBus.fire(FollowEvent(
          anchorId: state.anchorId.toString(), isFollowed: (value == 1)));
      Future.delayed(const Duration(microseconds: 500), () {
        AppLoading.toast(Tr.app_base_success.tr);
      });

      ///没有评论就去掉刷新数据
      //refreshData();
    });
    update();
  }

  toChat() {
    if (state.anchorId != null) {
      ARoutes.toChat('${state.anchorId}');
    }
  }

  ///呼叫主播
  callUp(String anchorId) {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      ARoutes.toCalling(
          anchorId: anchorId.toString(), portrait: state.portrait);
    });
  }

  copyId() {
    if (state.host.username != null) {
      Clipboard.setData(ClipboardData(text: state.host.username ?? ""));
      AppLoading.toast(Tr.app_base_success.tr);
    }
  }

  ///用户详情
  loadUserInfo() async {
    final info = await ProfileAPI.info(showLoading: false);
    UserInfo.to.setMyDetail = info;
    state.userVip = info.isVip == 1;
    update();
  }

  @override
  void refreshData() {
    state.moments.clear();
    loadMoment(state.anchorId.toString(), pageIndex = 1);
  }

  void handleBlack() {
    Http.instance.post<int>(
      NetPath.blacklistActionApi + state.anchorId.toString(),
      errCallback: (err) {
        AppLoading.toast(err.message);
      },
      showLoading: true,
    ).then((value) {
      AppLoading.toast(Tr.app_base_success.tr);
      StorageService.to.updateBlackList(state.anchorId.toString(), value == 1);
      AppEventBus.eventBus.fire(BlackEvent(uid: state.anchorId.toString()));
      AppEventBus.eventBus.fire(FollowEvent());
      if (ARoutes.isAnchorDetails) {
        Get.back();
      }
    });
  }

  @override
  void loadMoreData() {
    loadMoment(state.anchorId.toString(), (++pageIndex));
  }

  @override
  void refreshAndLoadCtl(bool isRefresh) {
    isRefresh
        ? refreshController.refreshCompleted()
        : refreshController.loadComplete();
  }
}
