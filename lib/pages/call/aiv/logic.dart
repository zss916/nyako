part of aiv_page;

class AivLogic extends GetxController {
  static const String idAgora = 'idAgora';
  static const String idSwitch = 'idSwitch';

  late String herId;
  late String content;
  late String token;
  // late AivVideoController aivVideoController;
  late AivBean aiv;

  // 0拨打，1被叫，2aib拨打(aib是被叫页面，实际是要去拨打), 3aic,4aiv
  late int callType = 4;

  // 视频要消耗体验卡
  late int isCard;
  late bool haveVoice;
  HostDetail? detail;
  String get showPortrait => detail?.portrait ?? "--";

  var connecting = true;
  RxBool abandVolume = false.obs;

  // 通话计时器
  Timer? _timer;
  Timer? _timerLink;
  var linkTime = 0;

  // 通话时长
  var callTime = 0.obs;

  // 默认主播是大屏，我小屏
  var switchView = false;

  ///是否显示Vip icon
  bool get showVip => UserInfo.to.myDetail?.isVip == 1 && !switchView;

  var myMoney = RxnInt(null);

  double toBottom = 120;
  double toLeft = 15;
  double minToTop = 200;
  double maxToLeft = Get.width - 145;
  double maxToBottom = Get.height - 280;
  late InfoDetail myInfo;

  CameraController? cameraController;
  bool hadCameraInit = false;

  // 已经关注
  RxInt followed = RxInt(0);

  // 体验卡可以用的时长 s
  int callCardDurationSecond = 0;
  var myVapController = AppVapController();

  // 充值中，这个时候不要因为电话的挂断而关闭
  bool chargeing = false;

  ///视频是否播放结束
  bool playFinish = false;
  bool callHadShowCount20 = false;
  bool doingShowCount20 = false;
  var playerInited = false;
  late VideoPlayerController videoController;
  int giftValue = 0; //送礼消费
  bool showWarn = false;

  Rx<GiftEntity> giftToQuickSend = GiftEntity().obs;
  RxList<ContributeEntity> contributeList = <ContributeEntity>[].obs;

  ///是否清屏模式
  bool screenClearMode = false;
  var cameraFront = true;

  static bool openGiftDialog = false;
  static bool openBlackDialog = false;
  static bool openHangDialog = false;

  late Function() listener;

  @override
  void onInit() {
    super.onInit();
    showWarn = true;
    update();
    Future.delayed(const Duration(seconds: 8), () {
      showWarn = false;
      update();
    });

    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    // AIB时还没有channelId
    content = arguments['content'] ?? '';
    isCard = arguments['isCard'] ?? 0;
    aiv = arguments['aiv'];
    // aivVideoController = arguments['aivVideoController'];
    haveVoice = aiv.muteStatus == 1;
    myInfo = UserInfo.to.myDetail!;
    myMoney.value = myInfo.userBalance?.remainDiamonds;
    giftValue = 0;
    if (content.isNotEmpty) {
      detail = HostDetail.fromJson(json.decode(content));
      followed.value = detail?.followed ?? 0;
    } else {
      _getHostDetail();
    }
    // videoController = aivVideoController.playerController;
    videoController =
        AivVideoController.make(aiv.filename ?? "").playerController;

    listener = () {
      if (videoController.value.isPlaying) {
        if (!playerInited) {
          playerInited = true;
          connecting = false;
          update();
          _beginTimer();
          _timerLink?.cancel();
        }
      }

      if (playerInited && !videoController.value.isPlaying) {
        onPlayFinishOrTimeOut();
      }
    };
  }

  @override
  void onReady() {
    super.onReady();
    initCamera();

    GiftDataHelper.getGifts().then((value) {
      if (value != null && value.isNotEmpty) {
        giftToQuickSend.value = value.first;
      }
    });

    ScreenProtector.preventScreenshotOn();

    Future.delayed(const Duration(seconds: 3), () {
      // 这里有个坑,被叫的dispose里面有关闭的调用，加延迟防止在他之前调用这个
      WakelockPlus.enable();
    });
    _timerLink = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick > 10) {
        if (connecting) {
          _endCall(EndType.linkTimeOut);
        } else {
          _timerLink?.cancel();
        }
      }
    });
    try {
      initPlayer();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    if (cameraController != null) {
      cameraController?.dispose();
    }
    videoController.removeListener(listener);
    videoController.dispose();
    _timer?.cancel();
    _timerLink?.cancel();
    myVapController.stop();
    ScreenProtector.preventScreenshotOff();
    WakelockPlus.disable();
    BgmControl.callInBgmStart();
    abandVolume.close();
    giftToQuickSend.close();
    contributeList.close();
    super.onClose();
  }

  closeWarn() {
    showWarn = false;
    update();
  }

  ///切换清屏模式
  switchClearMode() {
    screenClearMode = !screenClearMode;
    update();
  }

  void initPlayer() async {
    await videoController.initialize();
    await videoController.play();
    videoController.setVolume(haveVoice ? 1 : 0);
    videoController.addListener(listener);
  }

  void _beginTimer() {
    callTime.value = 0;
    // 使用体验卡，从倒计时开始
    if (isCard == 1) {
      callCardDurationSecond = (myInfo.callCardDuration ?? 0) ~/ 1000;
      // 体验卡用一个负数
      callTime.value = -callCardDurationSecond;
      consumeOneCard();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callTime.value += 1;
      // 使用体验卡倒计时结束
      if (isCard == 1 && callTime.value == 0) {
        // debugPrint("===>>>onPlayFinishOrTimeOut222");
        onPlayFinishOrTimeOut();
      }

      if (callTime.value > 0 && callTime.value >= 60) {
        // debugPrint("===>>>onPlayFinishOrTimeOut333");
        onPlayFinishOrTimeOut();
      }
    });
  }

  void initCamera({bool front = true}) async {
    if (cameraController != null) {
      await cameraController?.dispose();
    }
    final cameras = await availableCameras();
    CameraDescription camera = cameras.last;
    for (var element in cameras) {
      if (element.lensDirection == CameraLensDirection.front && front) {
        camera = element;
      }
      if (element.lensDirection == CameraLensDirection.back && !front) {
        camera = element;
      }
    }
    cameraController = CameraController(camera, ResolutionPreset.low);
    await cameraController?.initialize();
    hadCameraInit = true;
    update();
  }

  void switchCamera() {
    if (cameraFront == true) {
      cameraFront = false;
      initCamera(front: false);
    } else {
      cameraFront = true;
      initCamera(front: true);
    }
    update([idSwitch]);
  }

  void switchVoice() {
    clickCharge(showBalance: true);
  }

  /// 消耗掉一张体验卡
  void consumeOneCard() {
    Http.instance.post<void>(NetPath.useCardByAIBApi);
  }

  // 视频播放结束和有体验卡的倒计时结束
  void onPlayFinishOrTimeOut() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    playFinish = true;
    if (chargeing) return;
    //debugPrint("dispose ===>> onPlayFinishOrTimeOut");
    videoController.dispose();
    update();
    callHadShowCount20 = true;
    if (ARoutes.isReport) {
      Get.removeName(AppPages.report);
    }
    clickCharge(showBalance: true);
  }

  // 点击了挂断
  void clickHangUp({bool isLinking = false}) {
    _endCall(EndType.hangoff, isLinking: isLinking);
  }

  /// 结束通话
  void _endCall(int endType, {bool isLinking = false}) {
    if (cameraController != null) {
      cameraController?.dispose();
    }

    bool aicUseCard = isCard == 1;
    if (callTime.value == 0 && !aicUseCard && !isLinking) {
      Get.removeName(AppPages.aivPage);
      ARoutes.toConnectFailed(anchorPortrait: detail?.showPortrait ?? "");
      return;
    }

    Get.back(closeOverlays: true);
    // closeDialog();
    if (ARoutes.isAivPage) {
      Get.removeName(AppPages.aivPage);
    }

    if (!isLinking) {
      ARoutes.toSettlement(
        herId: herId,
        channelId: "",
        portrait: detail?.portrait ?? '',
        endType: endType,
        callTime: aicUseCard
            ? (callTime.value + callCardDurationSecond)
            : callTime.value,
        callType: callType,
        detail: detail,
        useCard: aicUseCard,
        callHadShowCount20: callHadShowCount20,
        giftValue: giftValue,
      );
    }
  }

/*  void closeDialog() {
    if (AppPages.history.contains(AppPages.aivPage) ||
        AppPages.history.contains(AppPages.main)) {
      Get.until(
        (route) {
          return route.settings.name == AppPages.aivPage ||
              route.settings.name == AppPages.main;
        },
      );
    }
  }*/

  void switchBig() {
    switchView = !switchView;
    update();
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
    update();
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

  // 点击了充值
  void clickCharge({bool showBalance = false}) {
    chargeing = true;
    if (!ChargeDialogManager.isShowingChargeDialog) {
      ChargeDialogManager.showChargeDialog(
          ChargePath.aib_chating_click_recharge,
          showBalanceText: showBalance,
          upid: herId, closeCallBack: () {
        chargeing = false;
        if (playFinish) {
          Future.delayed(const Duration(milliseconds: 60),
              () => _endCall(EndType.upHangoff));
        }
      }, showFreeDiamondPage: false);
    }
  }

  void quickSendGift() {
    if (giftToQuickSend.value.gid == null) {
      clickGift();
    } else {
      sendGift(giftToQuickSend.value);
    }
  }

  void sendGift(GiftEntity gift) {
    ///这里为不让主播有收益，所以anchorId = "999"
    GiftUtils.sendAivGift(gift, AppConstants.systemId, success: () {
      myVapController.playGift(gift);
      giftValue = giftValue + (gift.diamonds ?? 0);
    });
  }

  void _getHostDetail() {
    Http.instance.post<HostDetail>(NetPath.upDetailApi + herId,
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      detail = value;
      followed.value = value.followed ?? 0;
      update();
      content = json.encode(value);
      if (!value.isShowOnline) {
        return;
      }
    });
  }

  void handleFollow() {
    Http.instance.post<int>(NetPath.followUpApi + herId, errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      AppEventBus.eventBus
          .fire(FollowEvent(anchorId: herId, isFollowed: value == 1));
      detail?.followed = value;
      followed.value = value;
      update();
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
}
