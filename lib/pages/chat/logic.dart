part of 'index.dart';

class ChatLogic extends GetxController {
  /// event bus 监听
  late final StreamSubscription<MsgEntity> sub;

  /// 加载历史列表时的最上面一条的时间戳，根据这个分页加载
  int time = DateTime.now().millisecondsSinceEpoch;
  ScrollController scroller = ScrollController();
  AppVapController myVapController = AppVapController();

  // 它等于0说明列表在底部
  double extentAfter = 0;

  // 它等于0说明列表在顶部
  double extentBefore = 0;

  /// 两个列表，分别添加下拉出来的旧数据和新发的数据
  /// 为啥这么做？实现不会跳动的双向列表
  List<ChatMsgWrapper> showOldData = [];
  List<ChatMsgWrapper> showNewData = [];

  late String myId;
  late String herId;
  HerEntity? her;
  HostDetail? herDetail;
  late AppGiftFollowTipController tipController;

  ///是否系统id
  bool get isSystemId => (herId == AppConstants.systemId);

  ///聊天title
  String get chatTitle => herId == AppConstants.systemId
      ? Tr.app_message_official.tr
      : herId == AppConstants.serviceId
          ? AppConstants.appName
          : herDetail?.nickname ?? '--';

  /// 是否显示recharge tip
  bool get isShowRechargeTip =>
      showFreeMsgView &&
      herId != AppConstants.systemId &&
      herId != AppConstants.serviceId &&
      UserInfo.to.myDetail?.isVip != 1;

  ///聊天头像
  String get portrait =>
      herId == AppConstants.systemId ? "system" : herDetail?.portrait ?? '--';

  int leftFreeMsgNum = 5;
  bool showFreeMsgView = true;
  var freeMsgTip = ''.obs;

  late final StreamSubscription<EventMsgClear> subClear;
  late StreamSubscription<FollowEvent> followEvent;
  late final StreamSubscription<OpenSendGiftEvent> openGiftEvent;
  late final StreamSubscription<String> vipSub;
  late final StreamSubscription<ReportEvent> reportEvent;
  bool hasTranslateFunction = false;

  bool get hasSignFrame => UserInfo.to.hasSignFrame;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is String) {
      herId = Get.arguments as String;
    } else if (Get.arguments is HostDetail) {
      var detail = Get.arguments as HostDetail;
      herId = detail.userId!;
    }
    her = StorageService.to.objectBoxMsg.queryHer(herId);
    myId = UserInfo.to.userLogin?.userId ?? "";
    var allFree = UserInfo.to.config?.freeMessageCount ?? 5;
    var usedFree = UserInfo.to.myDetail?.userBalance?.freeMsgCount ?? 0;
    leftFreeMsgNum = allFree - usedFree;

    UserInfo.to.chattingWithHer = herId;

    tipController = AppGiftFollowTipController()
      ..listen((callback) {
        if (callback == 1) {
          handleFollow();
        } else if (callback == 2) {}
      });
    subClear = StorageService.to.eventBus.on<EventMsgClear>().listen((event) {
      if (event.type == 3) {
        showOldData.clear();
        showNewData.clear();
        update();
      }
    });

    followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {
      _getHostDetail();
    });

    openGiftEvent =
        AppEventBus.eventBus.on<OpenSendGiftEvent>().listen((event) {
      showGiftListSheet(
          child: AppGiftListView(
        choose: (GiftEntity gift) {
          Get.find<ChatLogic>(tag: (Get.arguments).toString()).sendGift(gift);
          // sendGift(gift);
        },
        herId: herId,
      ));
    });

    vipSub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == vipRefresh) {
        getVip();
      }
    });

    reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      if (ReportEnum.chat.index == event.type) {
        if (ARoutes.isChat) {
          Get.back();
        }
      }
    });
  }

  getVip() async {
    InfoDetail data = await ProfileAPI.info(showLoading: false);
    UserInfo.to.setMyDetail = data;
    update();
    await loadSignFrameAndChatCard();
  }

  ///获取签到头像和获取聊天卡
  loadSignFrameAndChatCard() {
    Future.wait([UserInfo.to.getSignFrame(), UserInfo.to.getMsgCard()])
        .whenComplete(() => update());
  }

  @override
  void onReady() {
    super.onReady();

    /// event bus 监听
    sub = StorageService.to.eventBus.on<MsgEntity>().listen((event) {
      debugPrint(
          "ChatController eventbus listen:msgId=${event.msgId} msgEventType=${event.msgEventType},");
      if (event.herId != herId) return;
      if (event.msgEventType == MsgEventType.sending ||
          event.msgEventType == MsgEventType.none ||
          event.msgEventType == MsgEventType.uploading) {
        addMsg(event);
      } else if (event.msgEventType == MsgEventType.sendDone) {
        updateMsg(event, MsgEventType.sendDone);
      } else if (event.msgEventType == MsgEventType.sendErr) {
        updateMsg(event, MsgEventType.sendErr);
      }
    });
    // showFreeMsgTip();
    StorageService.to.objectBoxMsg.setRead(herId);
    getOldListFirst();
    _getHostDetail();
    loadSignFrameAndChatCard();
  }

  bool canSendMsg() {
    //return true;
    return (UserInfo.to.myDetail?.isVip == 1) ||
        AppConstants.systemId == herId ||
        UserInfo.to.isUseMsgCard;
  }

  void _getHostDetail() {
    if (herId.isEmpty || herId == AppConstants.systemId) {
      return;
    }
    AnchorAPI.loadAnchorDetail(anchorId: herId).then((value) {
      herDetail = value;
      update(['herInfo']);
      tipController.setUser(herDetail?.portrait, herDetail?.followed == 1);
    });
  }

  // 加入消息
  void addMsg(MsgEntity event) {
    var herSend = event.sendType == 1;
    // 有重复显示消息问题，这里做下去重
    if (herSend) {
      for (var data in showNewData) {
        if (data.msgEntity.msgId == event.msgId) return;
      }
    }
    var wrapper = ChatMsgWrapper(event, herSend, event.dateInsert,
        her: her, herId: herId);
    wrapper.showTime = showNewData.isEmpty
        ? true
        : wrapper.date - showNewData.last.date > 1 * 60 * 1000;
    showNewData.add(wrapper);
    update();
    scrollWhenMsgAdd(herSend);
  }

  // 更新消息
  void updateMsg(MsgEntity event, MsgEventType msgEventType) {
    //  debugPrint("updateMsg ===>>> ${event.msgId}");
    for (var data in showNewData) {
      if (data.msgEntity.msgId == event.msgId) {
        data.msgEntity.msgEventType = msgEventType;
        update();
        break;
      }
    }
  }

  /// 进来的第一屏的数据要放到newData里面
  Future getOldListFirst() async {
    var list = StorageService.to.objectBoxMsg.queryHostMsgs(herId, time);
    if (list.isEmpty) return;
    showNewData.addAll(_getWrapperList(list, time).reversed);
    update();
    time = showNewData.first.date;
    Future.delayed(const Duration(milliseconds: 200), () {
      scroller.jumpTo(scroller.position.maxScrollExtent);
    });
    if (AppTranslateUtil().translateConfig()) {
      for (var element in list) {
        // print("message====${element.content}  trans===${element.translateContent}");
        if (element.msgType == 10) {
          // 文字类型  检测下是哪种语言
          hasTranslateFunction =
              await AppTranslateUtil().hasTranslateFunction(element.content);
          update();
          break;
        }
      }
    }
  }

  /// 下拉加载历史数据，放loadMoreData
  Future getOldList() async {
    var list = StorageService.to.objectBoxMsg.queryHostMsgs(herId, time);
    if (list.isEmpty) return;
    showOldData.addAll(_getWrapperList(list, time));
    update();
    time = showOldData.last.date;
    if (extentBefore == 0) {
      Future.delayed(const Duration(milliseconds: 400), () {
        scroller.animateTo(
          scroller.offset - 50,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut,
        );
      });
    }
  }

  List<ChatMsgWrapper> _getWrapperList(List<MsgEntity> list, int time) {
    var newList = list
        .map((e) => ChatMsgWrapper(e, e.sendType == 1, e.dateInsert,
            her: her, herId: herId))
        .toList();
    // 遍历wrapper,判断是否显示时间，5分钟
    var ite = newList.iterator;
    ite.moveNext();
    var wrapperTemp = ite.current;
    wrapperTemp.showTime = time - wrapperTemp.date > 5 * 60 * 1000;
    while (ite.moveNext()) {
      var current = ite.current;
      current.showTime = wrapperTemp.date - current.date > 5 * 60 * 1000;
      wrapperTemp = current;
    }
    return newList;
  }

  void scrollWhenMsgAdd(bool herSend) {
    // 在底部就自动滚动， 我发的也自动滚动
    if (extentAfter < 30 || !herSend) {
      Future.delayed(const Duration(milliseconds: 200), () {
        scroller.jumpTo(scroller.position.maxScrollExtent);
      });
    }
  }

  void sendGift(GiftEntity gift) {
    GiftUtils.sendChatGift(gift, herId, success: () {
      // debugPrint("herId: $herId, gift:${gift.toJson()}");
      myVapController.playGift(gift);
      tipController.hadSendGift();
    });
  }

  void handleFollow() {
    ProfileAPI.follow(anchorId: herId).then((value) {
      AppEventBus.eventBus
          .fire(FollowEvent(anchorId: herId, isFollowed: value == 1));
      herDetail?.followed = value;
      update();
    });
  }

  void handleBlack() {
    ProfileAPI.handBlack(anchorId: herId).then((value) {
      update();
      AppLoading.toast(Tr.app_base_success.tr);
      var updateBlackList =
          StorageService.to.updateBlackList(herId, value == 1);
      if (updateBlackList && (value == 1)) {
        AppEventBus.eventBus.fire(BlackEvent(uid: herId));
      }
      if (value == 1) {
        Get.back(result: 1);
      }
      if (ARoutes.isChat) {
        Get.back();
      }
    });
  }

  @override
  void onClose() {
    scroller.dispose();
    sub.cancel();
    vipSub.cancel();
    subClear.cancel();
    followEvent.cancel();
    openGiftEvent.cancel();
    reportEvent.cancel();
    UserInfo.to.chattingWithHer = null;
    AppAudioPlayer().stop();
    AppAudioPlayer().release();
    super.onClose();
  }
}
