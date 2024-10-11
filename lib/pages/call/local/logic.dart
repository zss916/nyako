part of local_page;

class LocalLogic extends GetxController {
  late String herId;
  late String portrait;
  String channelId = '';
  HostDetail detail = HostDetail();
  String get showNick => detail.showNickName;
  String get showPortrait => detail.portrait ?? "";
  late String content;

  /// event bus 监听
  late final StreamSubscription<EventRtmCall> sub;

  // 通话计时器
  Timer? _timer;

  // 时长
  var callTime = 0;
  var waitingStr = ''.obs;
  bool hadCancelCall = false;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    portrait = arguments['portrait'] ?? '';
    askPermission();
    _getHostDetail();

    /// event bus 监听
    sub = StorageService.to.eventBus.on<EventRtmCall>().listen((event) {
      // 1 我的呼叫被接受 2 我的呼叫被拒绝 3对方呼叫取消
      if (event.type == 1) {
        if (event.invite?.channelId != channelId) return;
        _timer?.cancel();
        _timer = null;
        pickUp();
      } else if (event.type == 2) {
        //debugPrint("callingRefused");
        _timer?.cancel();
        _timer = null;
        AppRingManager.instance.stopPlayRing();
        showRtmConfirmDialog(fun: () {
          hangUp(EndType2.callingRefused);
        });
      }
    });
    BgmControl.callInBgmClose();
  }

  @override
  void onClose() {
    sub.cancel();
    _timer?.cancel();
    AppRingManager.instance.stopPlayRing();
    BgmControl.callInBgmStart();
    super.onClose();
  }

  void askPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
      ].request();
    }
  }

  void _getHostDetail() {
    Http.instance.post<HostDetail>(
      NetPath.upDetailApi + herId,
      errCallback: (err) {
        //AppLog.debug(err);
        AppLoading.toast(err.message);
        _closeMe();
      },
      showLoading: true,
    ).then((value) {
      detail = value;
      portrait = value.portrait ?? '';
      update();
      content = json.encode(value);
      // 审核模式搞假的拨打电话
      if (AppConstants.isFakeMode == true) {
        _startTimer();
        return;
      }
      if (!value.isShowOnline) {
        StorageService.to.objectBoxCall.savaCallHistory(
            herId: herId,
            herVirtualId: detail.username ?? '',
            channelId: '',
            callType: 0,
            callStatus: CallStatus.USER_OFF,
            dateInsert: DateTime.now().millisecondsSinceEpoch,
            duration: '00:00');

        int myDiamond = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
        int callDiamond = UserInfo.to.config?.chargePrice ?? 60;
        int myCard = UserInfo.to.myDetail?.callCardCount ?? 0;
        // 没有钱也没有体验卡
        if (myDiamond < callDiamond && myCard < 1) {
          AppLoading.toast(Tr.app_not_enough_money.tr);
          Future.delayed(const Duration(seconds: 1), () {
            _showChargeAndStopMusic();
          });
          return;
        }
        String str;
        if (value.isOnline == 2) {
          str = Tr.app_message_video_chat_state_user_busy.tr;
        } else {
          str = Tr.app_video_hang_up_tip_3.tr;
        }
        AppRingManager.instance.stopPlayRing();
        callStatistics(0, 2);
        showRtmConfirmDialog(
            title: str,
            fun: () {
              _closeMe();
            });
        return;
      }
      if (hadCancelCall) {
        return;
      }
      _createCall();
    });
  }

  void _createCall() {
    _startTimer();
    Http.instance.post<int>(NetPath.createCallApi + herId, errCallback: (err) {
      int callStatus = CallStatus.USER_NOT_DIAMONDS;
      if (err.code == 8) {
        AppLoading.toast(Tr.app_not_enough_money.tr);
        Future.delayed(const Duration(microseconds: 1), () {
          _showChargeAndStopMusic();
        });
        callStatistics(0, 5);
      } else {
        AppLoading.toast(err.message);
        RtmMsgSender.sendCallState(herId, CallStatus.MY_HANG_UP, '00:00');
        _closeMe();
        callStatistics(0, 7);
        callStatus = CallStatus.NET_ERR;
      }
      StorageService.to.objectBoxCall.savaCallHistory(
          herId: herId,
          herVirtualId: detail.username ?? '',
          channelId: '',
          callType: 0,
          callStatus: callStatus,
          dateInsert: DateTime.now().millisecondsSinceEpoch,
          duration: '00:00');
    }).then((value) {
      if (hadCancelCall) {
        return;
      }
      channelId = value.toString();
      Rtm.instance.sendInvitation(herId, channelId,
          content: UserInfo.to.getAppUserInfo());
    });
  }

  void callStatistics(int isAib, int entType) {
    CallStatisticsAPI.update(isAib: isAib, statisticsType: entType);
  }

  void _showChargeAndStopMusic() {
    _timer?.cancel();
    _timer = null;
    AppRingManager.instance.stopPlayRing();
    ChargeDialogManager.showChargeDialog(ChargePath.create_call_no_money,
            upid: herId,
            closeCallBack: () {},
            showFreeDiamondPage: false,
            showBalanceText: true)
        .then((value) {
      _closeMe();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callTime++;
      var temp = callTime % 3;
      var waiting = Tr.app_video_call_wait.tr;
      if (temp == 0) {
        waitingStr.value = waiting;
      } else if (temp == 1) {
        waitingStr.value = '$waiting.';
      } else if (temp == 2) {
        waitingStr.value = '$waiting..';
      }

      if (callTime > 18) {
        _timer?.cancel();
        _timer = null;
        hangUp(EndType2.callingTimeOut);
      }
    });

    AppRingManager.instance.playRing();
  }

  toHangUp() {
    showHangDialog(
      pathName: AppPages.closeRemoteDialog,
      avatar: portrait,
      callback: (i) {
        if (i == 1) {
          hangUp(EndType2.callingCancel);
        }
      },
    );
  }

  void hangUp(int endType) {
    hadCancelCall = true;
    if (channelId.isNotEmpty) {
      Rtm.instance.cancelInvitation();
      RtmMsgSender.sendCallState(herId, CallStatus.MY_HANG_UP, '00:00');
      StorageService.to.objectBoxCall.savaCallHistory(
          herId: herId,
          herVirtualId: detail.username ?? '',
          channelId: channelId,
          callType: 0,
          callStatus: CallStatus.MY_HANG_UP,
          dateInsert: DateTime.now().millisecondsSinceEpoch,
          duration: '00:00');
      Http.instance.post<void>(NetPath.cancelCallApi,
          data: {'channelId': channelId, 'endType': endType});
    }
    _closeMe();
  }

  void pickUp() {
    /// 关闭弹窗
    /*if (Get.isOverlaysOpen) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!Get.isDialogOpen! && !Get.isBottomSheetOpen!);
      });
    }*/
    Get.back(closeOverlays: true);
    Map<String, dynamic> map = {};
    map['herId'] = herId;
    map['content'] = content;
    map['channelId'] = channelId;
    Get.toNamed(AppPages.call, arguments: map);
  }

  void _closeMe() {
    /// 关闭弹窗
    /*if (Get.isOverlaysOpen) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!Get.isDialogOpen! && !Get.isBottomSheetOpen!);
      });
    }*/
    Get.back(closeOverlays: true);
  }
}
