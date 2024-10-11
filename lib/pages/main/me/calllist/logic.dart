part of 'index.dart';

class ChatRecordLogic extends GetxController implements ILoadService {
  late List<CallRecordEntity> data = [];
  int pageIndex = 1;
  late RefreshController refreshCtr = RefreshController(
      initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  @override
  void dispose() {
    refreshCtr.dispose();
    super.dispose();
  }

  @override
  void refreshData() {
    data.clear();
    _loadData(pageIndex = 1);
  }

  @override
  void loadMoreData() {
    _loadData((++pageIndex));
  }

  @override
  void refreshAndLoadCtl(bool isRefresh) {
    isRefresh ? refreshCtr.refreshCompleted() : refreshCtr.loadComplete();
  }

  _loadData(int page) {
    Http.instance.post<List<CallRecordEntity>>(NetPath.callListApi, data: {
      "page": page,
      "pageSize": 10,
    }, errCallback: (error) {
      AppLoading.toast(error.message);
    }).whenComplete(() {
      refreshAndLoadCtl(page == 1);
    }).then((value) {
      data.addAll(value);
      update();
    });
  }

  ///呼叫主播
  void callUp(int uid) {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      ARoutes.toCalling(anchorId: uid.toString());
    });
  }

  goAnchorDetail(int uid) => ARoutes.toAnchorDetail(uid.toString());

  ///与主播私聊
  startMsg(String uid) => ARoutes.toChat(uid);

  bool isChat(CallRecordEntity item) {
    return (item.peerIsOnline ?? 1) == 1 &&
        (item.peerIsDoNotDisturb ?? 1) == 0 &&
        !AppConstants.isFakeMode;
  }

  int lineState(CallRecordEntity item) {
    int isOnline = item.peerIsOnline ?? 1;
    int isDoNotDisturb = item.peerIsDoNotDisturb ?? 1;
    return (isOnline == 0 || isDoNotDisturb == 1)
        ? LineType.offline.number
        : (isOnline == 1)
            ? LineType.online.number
            : LineType.busy.number;
  }

  String stateStr(CallRecordEntity item) {
    String duration = formatDuration(item.clientDuration ?? 0);
    return (item.channelStatus == 4) ? duration : Tr.app_call_disconnected.tr;
  }
}
