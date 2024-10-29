part of 'index.dart';

class CallLogic extends GetxController with Rtc, CancelableMixin {
  static const String idAgora = 'idAgora';
  late String herId;
  String? channelId;
  late String content;
  late String token;
  late RTMMsgBeginCall rtmMsgCall;
  // late RTMMsgGift askGift;

  // 0拨打，1被叫，2aib拨打(aib是被叫页面，实际是要去拨打)
  late int callType;
  HostDetail? detail;
  var connecting = true;

  // 通话计时器
  Timer? _timer;
  Timer? _timerLink;

  // aib的呼叫时间
  final aibLinkTime = 30;

  // 一般的连接中时间
  final otherLinkTime = 20;

  // 对方进入频道后的等begincall超时时间
  final joinLinkTime = 10;

  int linkTime = 20;

  // 通话时长
  var callTime = 0.obs;

  // 显示在语音模式
  var audioMode = false.obs;
  var deviceVolume = true.obs;

  // 显示两分钟倒计时 1.60s倒计时 2.120s倒计时
  var showCount2Min = 0.obs;
  var count2MinLeft = 0.obs;

  bool screenClearMode = false;

  // 默认主播是大屏，我小屏
  var switchView = false;
  late String myId;

  // 已经关注
  RxInt followed = RxInt(0);
  var myMoney = RxnInt(null);

  double toBottom = 120;
  double toLeft = 15;
  double minToTop = 200;
  double maxToLeft = Get.width - 145;
  double maxToBottom = Get.height - 280;

  // 已经收到begincall
  bool hadBeginCall = false;

  // 本次电话用了体验卡
  bool thisCallUseCard = false;

  // 体验卡可以用的时长 s
  int callCardDurationSecond = 0;

  // 充值中，这个时候不要因为电话的挂断而关闭
  bool charge_ing = false;

  // 本次电话结束
  bool thisCallFinish = false;

  // 已经进入结算页
  bool alreadyGotoEnd = false;

  bool callHadShowCount20 = false;

  // 显示鉴黄警告，这个socket消息可能多次触发，所以只显示一次
  bool hadShowSexy = false;
  GiftEntity? askGiftDetail;
  bool hasSendGift = false;

  List<GiftEntity> askGiftsList = [];

  RxList<ContributeEntity> contributeList = <ContributeEntity>[].obs;

  /// event bus 监听
  late final StreamSubscription<EventRtmCall> sub;
  late final StreamSubscription<EventCommon> subCommon;
  late final StreamSubscription<RTMMsgBeginCall> subBeginCall;
  late final StreamSubscription<RTMMsgGift> subGift; // 索要礼物
  // RTMMsgGift
  var myVapController = AppVapController();
  late final AppCallback<SocketBalance> _balanceListener;

  Rx<GiftEntity> giftToQuickSend = GiftEntity().obs;

  late InfoDetail myInfo;
  bool showWarn = false;

  StreamSubscription<void>? _screenshotsSubscription;

  Rx<CallDialogToolType> callDialogToolType = CallDialogToolType.none.obs;

  int endType = 0;

  @override
  void onInit() {
    super.onInit();

    userJoined = (RtcConnection connection, int remoteUid, int elapsed) {
      _userJoined(connection, remoteUid, elapsed);
    };

    userOffline =
        (RtcConnection connection, int uid, UserOfflineReasonType reason) {
      _userOffline(connection, uid, reason);
    };

    connectionLost = (RtcConnection connection) {
      _connectionLost(connection);
    };

    remoteVideoStats = (RtcConnection connection, RemoteVideoStats stats) {
      _remoteVideoStats(connection, stats);
    };

    connectionBanned = (RtcConnection connection) {
      _connectionBanned(connection);
    };

    showWarn = true;
    update();
    Future.delayed(const Duration(seconds: 5), () {
      showWarn = false;
      update();
    });

    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    // AIB时还没有channelId
    channelId = arguments['channelId'] ?? '';
    content = arguments['content']!;
    callType = arguments['callType'] ?? 0;
    myInfo = AppUserInfo.UserInfo.to.myDetail!;
    myId = myInfo.userId ?? "";
    myMoney.value = myInfo.userBalance?.remainDiamonds;
    if (content.isNotEmpty) {
      detail = HostDetail.fromJson(json.decode(content));
    }
    followed.value = detail?.followed ?? 0;
    if (callType == 2) {
      Rtm.instance.sendInvitation(herId, channelId!,
          content: AppUserInfo.UserInfo.to.getAppUserInfo());
    }
    _getToken();

    /// event bus 监听
    sub = StorageService.to.eventBus.on<EventRtmCall>().listen((event) {
      if (event.invite?.channelId != channelId) return;
      // 1 我的呼叫被接受 2 我的呼叫被拒绝 3对方呼叫取消
      if (event.type == 2) {
        // debugPrint("RouteObserver callingRefused");
        _endCall(EndType2.callingRefused);
      }
    });
    subCommon = StorageService.to.eventBus.on<EventCommon>().listen((event) {
      // 0电话涉黄
      if (event.eventType == 0) {
        if (hadShowSexy) return;
        hadShowSexy = true;
        AppCallSexyDialog.checkToShow((i) {
          clickHangUp();
        });
      }
    });

    // 收到begincall，开始计时
    subBeginCall =
        StorageService.to.eventBus.on<RTMMsgBeginCall>().listen((event) {
      if (event.channelId != channelId) return;
      if (hadBeginCall) return;
      hadBeginCall = true;
      _timerLink?.cancel();
      _timerLink = null;
      _beginTimer(event);
    });
    subGift = StorageService.to.eventBus.on<RTMMsgGift>().listen((event) {
      if (Get.currentRoute.contains(AppPages.call)) {
        //askGift = event;
        getGiftDetail(event.giftId ?? "");
      }
    });
    // 余额变动socket消息
    _balanceListener = (balance) {
      myMoney.value = balance.diamonds;
      var callDuration = balance.callDuration;
      if (callDuration == null) return;

      // 扣费导致还能打60s,说明现在还有120s.
      if (callDuration == 60 * 1000) {
      } else if (callDuration == 0) {
        // 扣费导致还能打0s,说明现在还有60s.
        showCount2Min.value = 1;
      } else {
        showCount2Min.value = 0;
      }
      update();
    };
    AppSocketManager.to.addBalanceListener(_balanceListener);
    WakelockPlus.enable();
  }

  @override
  void onReady() {
    super.onReady();
    ScreenProtector.preventScreenshotOn();
    GiftDataHelper.getGifts().then((value) {
      if (value != null && value.isNotEmpty) {
        giftToQuickSend.value = value.first;
      }
    });
  }

  @override
  void onClose() {
    thisCallFinish = true;
    releaseChannel();
    sub.cancel();
    subCommon.cancel();
    subBeginCall.cancel();
    subGift.cancel();
    _timer?.cancel();
    _timerLink?.cancel();
    AppSocketManager.to.removeBalanceListener(_balanceListener);
    ScreenProtector.preventScreenshotOff();
    _screenshotsSubscription?.cancel();
    WakelockPlus.disable();
    BgmControl.callInBgmStart();
    callDialogToolType.close();
    giftToQuickSend.close();
    contributeList.close();
    super.onClose();
  }

  void cleanMode() {
    screenClearMode = !screenClearMode;
    update();
    update([idAgora]);
  }

  /// 获取进入频道的token
  void _getToken() {
    _startLinkTimer();
    Http.instance.post<RTMMsgBeginCall>(NetPath.agoraTokenApi + channelId!,
        cancelToken: cancelToken, errCallback: (err) {
      _errBeforeCall(EndType2.linkErr);
    }).then((value) {
      rtmMsgCall = value;
      token = value.rtcToken ?? "";
      if (thisCallFinish) return;
      try {
        String appId = AppUserInfo.UserInfo.to.config?.agoraAppId ?? '';
        int uid =
            int.parse(AppUserInfo.UserInfo.to.userLogin?.userId ?? '-999');
        createRtc(
          appId: appId,
          token: token,
          channelId: channelId!,
          uid: uid,
        );
      } catch (e) {
        _errBeforeCall(EndType2.linkErr);
      }
    });
  }

  closeWarn() {
    showWarn = false;
    update();
  }

  void switchVoice() {
    deviceVolume.value = !deviceVolume.value;
    setVolume(volume: deviceVolume.value ? 100 : 0);
  }

  // 打电话的计时器
  void _beginTimer(RTMMsgBeginCall beginCall) {
    thisCallUseCard = beginCall.usedProp == true;
    // 如果用了体验卡，计时从负数开始
    if (thisCallUseCard) {
      callCardDurationSecond = (beginCall.propDuration ?? 0) ~/ 1000;
      callTime.value = -callCardDurationSecond;
    } else {
      callTime.value = 0;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callTime.value += 1;
      // 通话20s 如果没关注 弹窗关注弹窗
      if (callTime.value == 20 &&
          followed.value != 1 &&
          Get.isBottomSheetOpen == false &&
          Get.isDialogOpen == false &&
          Get.isOverlaysOpen == false) {
        callDialogToolType.value = CallDialogToolType.follow;
      } else if (callTime.value == 35 &&
          Get.isBottomSheetOpen == false &&
          Get.isDialogOpen == false &&
          Get.isOverlaysOpen == false &&
          hasSendGift == false) {
        callDialogToolType.value = CallDialogToolType.gift;
      }
      if (callTime.value == 33 &&
          (callDialogToolType.value == CallDialogToolType.follow)) {
        callDialogToolType.value = CallDialogToolType.none;
      }
      if (callTime.value == 50 &&
          (callDialogToolType.value == CallDialogToolType.gift)) {
        callDialogToolType.value = CallDialogToolType.none;
      }
      if (callTime.value > 0 && callTime.value % 60 == 0) {
        // 正常电话到了60s
        _refreshCall();
      } else if (callTime.value == 0 && thisCallUseCard) {
        // 体验卡结束
        _refreshCall();
      }
      // 2分钟倒计时
      if (showCount2Min.value == 2) {
        count2MinLeft.value = 120 - callTime.value % 60;
      } else if (showCount2Min.value == 1) {
        count2MinLeft.value = 60 - callTime.value % 60;
        if (count2MinLeft.value == 1) {
          showCount2Min.value = 0;
          if (callDialogToolType.value == CallDialogToolType.countDown) {
            callDialogToolType.value = CallDialogToolType.none;
          }
          update();
        }
      }
      // 20s倒计时
      if (showCount2Min.value > 0 && count2MinLeft.value == 20) {
        // chargeing = true;
        callHadShowCount20 = true;
        callDialogToolType.value = CallDialogToolType.countDown;
        update();
      }
    });
  }

  void handleFollow() {
    Http.instance.post<int>(NetPath.followUpApi + herId, showLoading: true,
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      AppEventBus.eventBus
          .fire(FollowEvent(anchorId: herId, isFollowed: value == 1));
      detail?.followed = value;
      followed.value = value;
      update();
    });
  }

  // 点击了挂断
  void clickHangUp() {
    //debugPrint("RouteObserver clickHangUp");
    _endCall(connecting ? EndType2.linkCancel : EndType2.userHang);
    if (callType == 2 && !hadBeginCall) {
      StorageService.to.objectBoxCall.savaCallHistory(
          herId: herId,
          herVirtualId: detail?.username ?? '',
          channelId: '',
          callType: 0,
          callStatus: CallStatus.MY_HANG_UP,
          dateInsert: DateTime.now().millisecondsSinceEpoch,
          duration: '00:00');
    }
  }

  // 点击了礼物
  void clickGift() {
    showGiftListSheet(
        child: AppGiftListView(
            choose: (GiftEntity gift) {
              sendGift(gift);
            },
            herId: herId,
            showFreeDiamondPage: false));
  }

  void quickSendGift() {
    if (giftToQuickSend.value.gid == null) {
      clickGift();
    } else {
      sendGift(giftToQuickSend.value);
    }
  }

  // 点击了充值
  void clickCharge() {
    charge_ing = true;
    ChargeDialogManager.showChargeDialog(ChargePath.chating_click_recharge,
        upid: herId, closeCallBack: () {
      charge_ing = false;
    }, showFreeDiamondPage: false);
  }

  void getGiftDetail(String gid) {
    if (gid.isEmpty) return;
    // TestRtmUtils.showRtmGift(msg: "索要礼物请求接口 start");
    Http.instance.post<GiftEntity>(NetPath.getGiftDetail + gid).then((value) {
      askGiftDetail = value;
      askGiftsList.clear();
      askGiftsList.add(value);
      update(["askGift"]);
      //callDialogToolType.value = CallDialogToolType.askGift;
      //update();
      // TestRtmUtils.showRtmGift(msg: "索要礼物请求接口 end");
    });
  }

  getContributeList(VoidCallback callBack) {
    return Http.instance.post<List<ContributeEntity>>(
        NetPath.contributeList + herId,
        showLoading: true, errCallback: (error) {
      AppLoading.toast(error.message);
    }).then((value) {
      contributeList.clear();
      contributeList.addAll(value);
      callBack();
    });
  }

  void sendGift(GiftEntity gift, {Function? onEnd}) {
    GiftUtils.sendCallGift(gift, herId, fail: () {
      hasSendGift = true;
    }, success: () {
      hasSendGift = true;
      myVapController.playGift(gift);
    }, onEnd: () {
      onEnd?.call();
    });
  }

  /// 用户端每计时一分钟时通知扣用户钻石
  void _refreshCall() {
    Http.instance.post<String>(
      NetPath.refreshCallApi + channelId!,
      showLoading: false,
      errCallback: (err) {
        if (err.code == 8) {
          //debugPrint("RouteObserver keyNoMoney");
          _endCall(EndType2.keyNoMoney);
        } else {
          //debugPrint("RouteObserver keyErr");
          _endCall(EndType2.keyErr);
        }
      },
    ).then((value) {
      // debugPrint("_refreshCall ===> $value");
      renewToken(value);
    });
  }

  /// 结束通话
  void _endCall(int endType, {bool pop = false}) {
    // debugPrint("RouteObserver _endCall ${endType}");
    this.endType = endType;
    thisCallFinish = true;
    leaveChannel();
    _timer?.cancel();
    if (charge_ing) {
      // 充值中，先不关页面
      return;
    }
    if (ARoutes.isReport) {
      Get.removeName(AppPages.report);
    }
    if (callTime.value == 0 && !thisCallUseCard) {
      _closeMe();
      return;
    }
    if (alreadyGotoEnd) {
      return;
    }
    alreadyGotoEnd = true;
    Get.back(closeOverlays: true);
    ARoutes.toSettlement(
      herId: herId,
      channelId: channelId ?? '',
      portrait: detail?.portrait ?? '',
      endType: endType,
      callTime: thisCallUseCard
          ? callTime.value + callCardDurationSecond
          : callTime.value,
      callType: callType,
      detail: detail,
      useCard: thisCallUseCard,
      callHadShowCount20: callHadShowCount20,
    );
  }

  // 充值弹窗导致的返回页面，要关闭页面
  void didPopNext() {
    charge_ing = false;
    if (thisCallFinish) {
      // 这里要加个延时，不然会崩溃。报的错是重复调用pop等方法
      Future.delayed(
        const Duration(milliseconds: 60),
        () {
          debugPrint("RouteObserver didPopNext");
          _endCall(endType, pop: true);
        },
      );
    }
  }

  void switchBig() {
    switchView = !switchView;
    update([idAgora]);
  }

  /// 拖动小窗口
  void onPanUpdate(DragUpdateDetails tapInfo) {
    toBottom -= tapInfo.delta.dy;
    if (Get.locale?.languageCode == 'ar') {
      toLeft -= tapInfo.delta.dx;
    } else {
      toLeft += tapInfo.delta.dx;
    }
    if (toBottom > maxToBottom) {
      toBottom = maxToBottom;
    } else if (toBottom < 100) {
      toBottom = 100;
    }
    if (toLeft < 15) {
      toLeft = 15;
    } else if (toLeft > maxToLeft) {
      toLeft = maxToLeft;
    }
    update([idAgora]);
  }

  void _errBeforeCall(int endType) {
    //AppLog.debug('RouteObserver  _errBeforeCall $endType');
    if (callType == 2) {
      _cancelCall(endType);
    }
    StorageService.to.objectBoxCall.savaCallHistory(
        herId: herId,
        herVirtualId: detail?.username ?? '',
        channelId: channelId ?? '',
        callType: callType == 0 ? 1 : 0,
        callStatus: CallStatus.MY_HANG_UP,
        dateInsert: DateTime.now().millisecondsSinceEpoch,
        duration: '00:00');
    Get.back(closeOverlays: true);
    if (AppPages.history.last.contains(AppPages.call)) {
      Get.removeName(AppPages.call);
    }
    ARoutes.toConnectFailed(anchorPortrait: detail?.showPortrait ?? "");
  }

  /// 开始一个连接计时器
  void _startLinkTimer() {
    // callTime = 0;
    linkTime = callType == 2 ? aibLinkTime : otherLinkTime;
    _timerLink = Timer.periodic(const Duration(seconds: 1), (timer) {
      linkTime--;
      if (linkTime == 15) {
        // 延时设置一次常亮
        // WakelockPlus.enable();
      }
      if (linkTime <= 0) {
        // AppLog.debug('linkTime > 15');
        _timerLink?.cancel();
        _timerLink = null;
        // debugPrint("RouteObserver time out");
        _errBeforeCall(
            connecting ? EndType2.otherJoinTimeOut : EndType2.beginTimeOut);
      }
    });
  }

  void _cancelCall(int endType) {
    if (channelId == null || channelId!.isEmpty) {
      return;
    }
    Http.instance.post<void>(NetPath.cancelCallApi,
        data: {'channelId': channelId, 'endType': endType});
  }

  void _closeMe() {
    /// 关闭弹窗
    Get.back(closeOverlays: true);
  }

  /**
   * *********************rtc 回调************************************/

  /// 对方进入
  void _userJoined(RtcConnection connection, int uid, int elapsed) {
    // debugPrint("rtc _userJoined ===>  $uid");
    // 这个判断是为了监控端可能进入
    if (uid.toString() != herId) return;
    if (hadBeginCall) return;
    hadBeginCall = true;
    _timerLink?.cancel();
    _timerLink = null;
    _refreshCall();
    _beginTimer(rtmMsgCall);
    connecting = false;
    update();
    AppPages.closeDialog();
  }

  /// 对方挂断
  void _userOffline(
      RtcConnection connection, int uid, UserOfflineReasonType reason) {
    // debugPrint("rtc _userOffline ==> $uid, ${reason.name}");
    // 这个判断是为了监控端可能进入
    if (uid.toString() != herId) return;
    Get.dialog(AppDialogConfirm(
      title: Tr.app_video_hang_up_tip.tr,
      onlyConfirm: true,
      callback: (int callback) {},
    )).then((value) {
      _endCall(reason == UserOfflineReasonType.userOfflineQuit
          ? EndType2.otherHang
          : EndType2.otherOff);
    });
  }

  /// 对方视频状态
  void _remoteVideoStats(RtcConnection connection, RemoteVideoStats stats) {
    // 这个判断是为了监控端可能进入
    if (stats.uid.toString() != herId) return;
    if ((stats.decoderOutputFrameRate ?? 0) <= 0) {
      audioMode.value = true;
      update();
    } else {
      audioMode.value = false;
      update();
    }
  }

  /// 连接中断
  void _connectionLost(RtcConnection connection) {
    _endCall(EndType2.netErr);
  }

  void _connectionBanned(RtcConnection connection) {
    _endCall(EndType2.hostBan);
  }
}
