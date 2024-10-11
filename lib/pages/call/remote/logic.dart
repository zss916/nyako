part of 'index.dart';

class RemoteLogic extends GetxController {
  static startMeAic(AicEntity aic) async {
    var myDiamonds = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    if (myDiamonds > 60) {
      if (AppConstants.isTestMode &&
          NetPath.getConfigBaseUrl().startsWith('https://test')) {
      } else {
        //  AppLog.debug('RemoteController 有钱屏蔽aic');
        return;
      }
    }
    Map<String, dynamic> map = {};
    map['herId'] = aic.userId;
    map['url'] = aic.filename;
    map['localPath'] = aic.localPath;
    map['callType'] = 3;
    map['aic'] = aic;
    if (AppCheckCallingUtil.checkCanAic()) {
      await _toThisPage(map);
    } else {
      Http.instance.post('${NetPath.hanAIAApi}/${aic.userId}/0');
    }
  }

  static startMeAib(String herId, String content) {
    if (AppAiLogicUtils().isLogin()) {
      Map<String, dynamic> map = {};
      map['herId'] = herId;
      map['content'] = content;
      map['callType'] = 2;
      _toThisPage(map);
    }
  }

  static bool startMeAiv(AivBean bean) {
    if (AppAiLogicUtils().isLogin()) {
      Map<String, dynamic> map = {};
      map['herId'] = bean.userId;
      // map['content'] = json.encode(bean);
      map['callType'] = 4;
      map['aiv'] = bean;
      _toThisPage(map);
      return true;
    } else {
      return false;
    }
  }

  static startMe(String herId, String channelId, String content) {
    Map<String, dynamic> map = {};
    map['herId'] = herId;
    map['channelId'] = channelId;
    map['content'] = content;
    map['callType'] = 1;

    _toThisPage(map);
  }

  static _toThisPage(Map<String, dynamic> map) async {
    ///自动退出连接失败页面
    ARoutes.removeConnectFailed();
    if (ARoutes.isSettlement && (!AppConstants.isMatch)) {
      await Get.offNamed(AppPages.callCome, arguments: map);
    } else {
      await Get.toNamed(AppPages.callCome, arguments: map);
    }
  }

  void _toCallPage() {
    //_closePageDialog();
    Get.back(closeOverlays: true);
    _timer?.cancel();
    _timer = null;
    Map<String, dynamic> map = {};
    map['herId'] = herId;
    map['content'] = content;
    map['callType'] = callType;
    map['channelId'] = channelId;
    Get.toNamed(AppPages.call, arguments: map);
  }

  // RemoteState state = RemoteState();

  HostDetail detail = HostDetail();

  String get showNick => detail.showNickName ?? "--";

  late String herId;
  late String channelId;
  late String content;
  late int callType;

  String portrait = '';
  AicEntity? aic;
  AivBean? aiv;

  // aic 是否消耗体验卡
  int isCard = 0;

  // 通话计时器
  Timer? _timer;

  // 时长
  var callTime = 0;

  // 1,表示是免费电话，2表示是你有一个体验卡
  var freeTip = 0;
  var iHaveCard = 0;
  var stoping = false;

  /// event bus 监听
  late final StreamSubscription<EventRtmCall> sub;
  // AivVideoController? _aivVideoController;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    channelId = arguments['channelId'] ?? '';
    content = arguments['content'] ?? '';
    callType = arguments['callType'] ?? 1;

    if (callType == 3) {
      // aic = arguments['aic'];
      // isCard = aic?.isCard ?? 0;
    } else if (callType == 4) {
      aiv = (Get.arguments as Map<String, dynamic>)['aiv'];
      isCard = aiv?.isCard ?? 0;
      //_aivVideoController = AivVideoController.make(aiv!.filename!);
    }
    aic = (Get.arguments as Map<String, dynamic>)['aic'];
    isCard = aic?.isCard ?? 0;
    if (content.isNotEmpty) {
      detail = HostDetail.fromJson(json.decode(content));
      portrait = detail.portrait ?? '';
    }
    iHaveCard = UserInfo.to.myDetail?.callCardCount ?? 0;
    if (callType == 4) {
      iHaveCard = aiv?.callCardCount ?? 0;
    }

    /// 展示你有体验卡或aic免费电话
    if ((callType == 3 || callType == 4) && isCard == 0) {
      // 1,表示是免费电话，2表示是你有一个体验卡
      freeTip = 1;
    } else {
      if (iHaveCard > 0) {
        freeTip = 2;
      } else {
        freeTip = 0;
      }
    }

    /// event bus 监听
    sub = StorageService.to.eventBus.on<EventRtmCall>().listen((event) {
      if (event.type == 3) {
        if (event.herInvite?.channelId != channelId) return;
        AppLoading.toast("");
        _closeMe();
        _submitRefuseCall(channelId, EndType2.calledCanceled);
      }
    });
    WakelockPlus.enable();
    BgmControl.callInBgmClose();
  }

  @override
  void onReady() {
    super.onReady();
    _startTimer();
    _getHostDetail();
    AppPermissionHandler.askCallPermission().whenComplete(() {
      AppConstants.isBeCallPermission = false;
    });
  }

  @override
  void onClose() {
    closeTime();
    sub.cancel();
    AppRingManager.instance.stopPlayRing();
    WakelockPlus.disable();
    BgmControl.callInBgmStart();
    super.onClose();
  }

  ///关闭计时器
  void closeTime() {
    _timer?.cancel();
    _timer = null;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callTime++;
      if (callTime > 15) {
        _timer?.cancel();
        _timer = null;
        hangUp(timeOut: true);
      }
    });

    // MatchBgm.callInBgmClose();
    AppRingManager.instance.playRing();

    ///暂停发现模块的视频
    StorageService.to.eventBus.fire('pauseDiscover');
  }

  void hangUp({bool timeOut = false}) {
    closeTime();
    _closeMe();
    // _aivVideoController?.playerController.dispose();
    stoping = true;
    if (callType == 2) {
      // aib拒接延时
      if (!timeOut) {
        AppAiLogicUtils().setNextTimer(isRejectDelay: true);
      }
    }
    // 非aic,refuse call
    if (callType != 3 && callType != 4) {
      _submitRefuseCall(
        channelId,
        timeOut ? EndType2.calledTimeOut : EndType2.calledRefuse,
      );
    } else {
      Http.instance.post('${NetPath.hanAIAApi}/$herId/0');
    }
    if (callType > 1) {
      // 插入一个通话记录
      saveCallHis();
    } else {
      // 拒接
      Rtm.instance.rejectInvitation();
    }
  }

  void saveCallHis() {
    StorageService.to.objectBoxCall.savaCallHistory(
        herId: herId,
        herVirtualId: detail.username ?? '',
        channelId: channelId,
        callType: callType,
        callStatus: CallStatus.MY_HANG_UP,
        dateInsert: DateTime.now().millisecondsSinceEpoch,
        duration: '00:00');
  }

  void pickUp() {
    AppAiLogicUtils().reduceRejectCount();
    int myDiamond = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    int callDiamond = UserInfo.to.config?.chargePrice ?? 60;
    int myCard = UserInfo.to.myDetail?.callCardCount ?? 0;
    if (callType == 4) {
      // aic要消耗体验卡但是没有体验卡
      if (isCard == 1 && myCard < 1) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _showChargeAndStopMusic();
        });
        saveCallHis();
        return;
      }
      String url = aiv?.filename ?? '';
      if (url.isEmpty) return;
      ARoutes.toAivPage(herId, isCard, aiv!);
      Http.instance.post('${NetPath.hanAIAApi}/$herId/1');
      return;
    }
    if (callType == 2) {
      _createCall();
      return;
    }
    // 没有钱也没有体验卡
    if (myDiamond < callDiamond && myCard < 1) {
      Rtm.instance.rejectInvitation();
      Future.delayed(const Duration(milliseconds: 100), () {
        _showChargeAndStopMusic();
      });

      _submitRefuseCall(channelId, EndType2.noMoney);
      return;
    }
    if (callType == 1) {
      Rtm.instance.acceptInvitation();
    }
    _toCallPage();
  }

  toPickUp() {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (value) {
        if (!ARoutes.isBeCall) {
          return;
        }
        pickUp();
      }
    });
  }

  void _getHostDetail() {
    Http.instance.post<HostDetail>(NetPath.upDetailApi + herId).then((value) {
      detail = value;
      portrait = value.portrait ?? '';
      content = json.encode(value);
      update();
      StorageService.to.objectBoxMsg.putOrUpdateHer(HerEntity(
          value.nickname ?? '', value.userId!,
          portrait: value.portrait));
    });
  }

  /// AIB主动拨打
  void _createCall() {
    if (!_aibCheckOnline()) return;
    Http.instance.post<int>(
      "${NetPath.createAIBCallApi}$herId",
      errCallback: (err) {
        saveCallHis();
        if (stoping) return;
        if (err.code == 8) {
          _showChargeAndStopMusic();
          callStatistics(1, 5);
        } else {
          AppLoading.toast(err.message);
          _closeMe();
          callStatistics(1, 7);
        }
      },
      showLoading: true,
    ).then((value) {
      if (stoping) return;
      channelId = value.toString();
      _toCallPage();
    });
  }

  // aib先检查下主播是否在线，一般aib时主播是在线的
  bool _aibCheckOnline() {
    if (detail.isShowOnline == true) return true;
    StorageService.to.objectBoxCall.savaCallHistory(
        herId: herId,
        herVirtualId: detail.username ?? '',
        channelId: '',
        callType: 1,
        callStatus: CallStatus.USER_OFF,
        dateInsert: DateTime.now().millisecondsSinceEpoch,
        duration: '00:00');

    int myDiamond = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    int callDiamond = UserInfo.to.config?.chargePrice ?? 60;
    int myCard = UserInfo.to.myDetail?.callCardCount ?? 0;
    // 没有钱也没有体验卡
    if (myDiamond < callDiamond && myCard < 1) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _showChargeAndStopMusic();
      });
      return false;
    }
    String str;
    if (detail.isOnline == 2) {
      str = Tr.app_message_video_chat_state_user_busy.tr;
    } else {
      str = Tr.app_video_hang_up_tip_3.tr;
    }
    AppRingManager.instance.stopPlayRing();
    callStatistics(1, 1);
    Get.dialog(
            AppDialogConfirm(
              title: str,
              onlyConfirm: true,
              callback: (int callback) {},
            ),
            routeSettings: RouteSettings(name: "dialog: $str"))
        .then((value) {
      _closeMe();
    });
    return false;
  }

  void _showChargeAndStopMusic() {
    AppRingManager.instance.stopPlayRing();
    _timer?.cancel();
    _timer = null;
    ChargeDialogManager.showChargeDialog(ChargePath.create_call_no_money,
            upid: herId,
            closeCallBack: () {},
            showFreeDiamondPage: false,
            showBalanceText: true)
        .then((value) {
      _closeMe();
    });
  }

  void callStatistics(int isAib, int statisticsType) {
    CallStatisticsAPI.update(isAib: isAib, statisticsType: statisticsType);
  }

  // channelId
  // endType 挂断原因，
  // isRobot 是否系统自动唤起 aib唤起的拒接接听( isRobot传1 —— channelId传入主播id)
  void _submitRefuseCall(
    String channelId,
    int endType,
  ) {
    if (callType == 2) {
      int statisticsType = 7;
      if (endType == EndType2.calledTimeOut) {
        statisticsType = 4;
      } else if (endType == EndType2.calledRefuse) {
        statisticsType = 3;
        // 手动挂掉aib，做一个延迟aib
        Http.instance.post<void>("${NetPath.refuseAIBCall}${herId}");
      } else if (endType == EndType2.noMoney) {
        statisticsType = 5;
      }
      callStatistics(1, statisticsType);
      return;
    }
    Http.instance.post<void>(NetPath.refuseCallApi, data: {
      "channelId": channelId,
      "endType": endType,
      "isRobot": 0,
      // "isRobot": isRobot,
    }, errCallback: (err) {
      //AppLog.debug(err);
    });
  }

  void _closeMe() {
    if (stoping) return;
    stoping = true;
    /* _closePageDialog();
    if (AppPages.history.last.contains(AppPages.callCome)) {
      Get.back();
    }*/
    Get.back(closeOverlays: true);
  }

  /// 关闭当前页面弹窗
  /*void _closePageDialog() {
    if (AppPages.history.contains(AppPages.callCome) ||
        AppPages.history.contains(AppPages.main)) {
      Get.until(
        (route) {
          return route.settings.name == AppPages.callCome ||
              route.settings.name == AppPages.main;
        },
      );
    }
  }*/
}
