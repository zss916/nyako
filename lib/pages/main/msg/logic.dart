part of 'index.dart';

class MsgListLogic extends GetxController implements IFollowLoadService {
  List<ConversationEntity> dataList = [];
  late final StreamSubscription<MsgEntity> sub;
  late final StreamSubscription<HerEntity> subHer;
  late final StreamSubscription<EventMsgClear> subClear;
  late final StreamSubscription<String> vipSub;
  late final StreamSubscription<ReportEvent> reportEvent;
  late final StreamSubscription<BlackEvent> blackEvent;
  late bool isVip = UserInfo.to.isUserVip;

  late List<HostDetail> followList = [];

  late int followPage = 1;

  late RefreshController refreshCtrlF = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);

  late StreamSubscription<FollowEvent> followEvent;

  late int state = Status.INIT.index; // 0 empty, 1 loading ,2 list

  bool isShowCompliance = true;

  closeCompliance() {
    isShowCompliance = false;
    update(["compliance"]);
  }

  @override
  void onInit() {
    super.onInit();
    state = Status.INIT.index;
    update();

    sub = StorageService.to.eventBus.on<MsgEntity>().listen((event) {
      reloadAllData();
    });
    subHer = StorageService.to.eventBus.on<HerEntity>().listen((event) {
      reloadAllData();
    });
    subClear = StorageService.to.eventBus.on<EventMsgClear>().listen((event) {
      reloadAllData();
    });
    vipSub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == "vipRefresh") {
        refreshMe();
      }
    });
    reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      reloadAllData();
    });
    blackEvent = AppEventBus.eventBus.on<BlackEvent>().listen((event) {
      //debugPrint("blackEvent====>>>");
      reloadAllData();
    });

    followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {
      refreshFollowData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    reloadAllData();
    refreshFollowData();
    getActiveConfig();
  }

  Future refreshMe() async {
    final info = await ProfileAPI.info(showLoading: false);
    UserInfo.to.setMyDetail = info;
    isVip = UserInfo.to.isUserVip;
    update();
  }

  @override
  void dispose() {
    sub.cancel();
    subHer.cancel();
    subClear.cancel();
    reportEvent.cancel();
    blackEvent.cancel();
    followEvent.cancel();
    vipSub.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    sub.cancel();
    subHer.cancel();
    subClear.cancel();
    reportEvent.cancel();
    blackEvent.cancel();
    followEvent.cancel();
    vipSub.cancel();
    super.onClose();
  }

  toChat(String anchorId) {
    ARoutes.toChat(anchorId);
    clearUnreadMsg(anchorId);
  }

  ///主播详情
  toAnchorDetail(String anchorId) => ARoutes.toAnchorDetail(anchorId);

  openAiHelp() =>
      AiHelp.instance.enterMinAIHelp(AiHelpType.conversationList.index);

  reloadAllData() async {
    dataList.clear();
    int time = DateTime.now().millisecondsSinceEpoch;
    List<ConversationEntity> list =
        StorageService.to.objectBoxMsg.queryHostCon(time);
    if (list.isNotEmpty) {
      list.removeWhere(
          (element) => StorageService.to.checkBlackList(element.herId));
      dataList.addAll(list);
    }
    StorageService.to.objectBoxMsg.refreshUnreadNum();
    update();
  }

  ///删除一条消息
  removeMessage(int index, String herId) async {
    StorageService.to.objectBoxMsg.removeHer(herId);
    StorageService.to.objectBoxMsg.refreshUnreadNum();
    dataList.removeAt(index);
    update();
  }

  showMore() {
    showMsgMoreSheet(() {
      StorageService.to.objectBoxMsg.setAllRead();
    }, () {
      StorageService.to.objectBoxMsg.clearAllMsg();
    });
  }

  clearUnreadMsg(String anchorId) async {
    StorageService.to.objectBoxMsg.setRead(anchorId);
    StorageService.to.objectBoxMsg.refreshUnreadNum();
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
          followList.addAll(value);
          refreshAndLoadFollowCtl(page == 1);
          state = followList.isEmpty ? Status.EMPTY.index : Status.DATA.index;
          update();
        });
  }

  @override
  void refreshAndLoadFollowCtl(bool isRefresh) {
    isRefresh ? refreshCtrlF.refreshCompleted() : refreshCtrlF.loadComplete();
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

  ///活动
  bool isOpenActivity = false;
  String activityTitle = "";
  String activityContent = "";

  getActiveConfig() {
    ActivityAPI.getActiveConfig().then((data) {
      isOpenActivity = data.status == 1;
      activityTitle = data.title;
      activityContent = data.content;
      update();
    });
  }
}
