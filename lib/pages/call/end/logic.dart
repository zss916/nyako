part of settlement_page;

class EndLogic extends GetxController {
  late String herId;
  late String portrait;
  late String channelId;
  late int endType;
  late bool useCard;
  late bool callHadShowCount20;

  // 0拨打，1被叫，2aib拨打(aib是被叫页面，实际是要去拨打)
  late int callType;
  late int callTime;
  late int giftValue;
  HostDetail? detail;
  bool get isCall => detail?.isChat ?? false;
  bool get followed => detail?.isFollowed ?? false;
  Rx<EndCallEntity?> endCallEntity = Rx(null);

  late List<HostDetail> recommend = [];
  late String areaCode = (StorageService.to.getAreaCode()).toString();

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    channelId = arguments['channelId'] ?? '';
    portrait = arguments['portrait'] ?? '';
    endType = arguments['endType'] ?? 0;
    callType = arguments['callType'] ?? 0;
    callTime = arguments['callTime'] ?? 0;
    detail = arguments['detail'];
    useCard = arguments['useCard'] ?? false;
    callHadShowCount20 = arguments['callHadShowCount20'] ?? false;
    giftValue = arguments['giftValue'] ?? 0;
    // _createCall();
    if (useCard) {
      UserInfo.to.subtractCard();
    }
  }

  @override
  void onReady() {
    super.onReady();
    // AppLog.debug('EndController onReady ${herId}');
    _getHostDetail();
    _endCall();
    if (!ChargeDialogManager.isShowingChargeDialog) {
      final remain = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
      final callCost = UserInfo.to.config?.chargePrice ?? 60;
      if (remain < callCost && !callHadShowCount20) {
        ChargeDialogManager.showChargeDialog(
            ChargePath.chating_end_showrecharge,
            upid: herId,
            showBalanceText: (remain < callCost),
            showFreeDiamondPage: false);
      }
    }

    loadRecommend();
  }

  @override
  void onClose() {
    endCallEntity.close();
    BgmControl.callInBgmStart();
    super.onClose();
  }

  /// 结束通话
  void _endCall() {
    // AppLog.debug('EndController _endCall');
    // aic没有 channelId
    if (channelId.isEmpty) {
      var entity = EndCallEntity();
      // 这个1为了触发页面显示时间
      entity.callAmount = 0;
      entity.callTime = AppFormatUtil.getTimeStrFromSecond(callTime);
      entity.usedProp = useCard;
      entity.giftAmount = giftValue;
      endCallEntity.value = entity;
      // debugPrint("ddd=>>${entity.toJson()}");

      StorageService.to.objectBoxCall.savaCallHistory(
          herId: herId,
          herVirtualId: detail?.username ?? '',
          channelId: channelId,
          callType: callType,
          callStatus: CallStatus.PICK_UP,
          dateInsert: DateTime.now().millisecondsSinceEpoch,
          duration: AppFormatUtil.getTimeStrFromSecond(callTime));
      return;
    }
    Http.instance
        .post<EndCallEntity>(NetPath.endCallApi,
            data: {
              "channelId": channelId,
              "endType": endType,
              "clientEndAt": DateTime.now().millisecondsSinceEpoch,
              "clientDuration": callTime * 1000
            },
            showLoading: true)
        .then((value) {
      endCallEntity.value = value;
      // 拨打方发消息 aib在拨打时如果传了aiType,主播端会发消息
      if (callType == 0) {
        // AppLog.debug('EndController _endCall endCallApi');
        RtmMsgSender.sendCallState(
            herId, CallStatus.PICK_UP, value.totalCallTime);

        StorageService.to.objectBoxCall.savaCallHistory(
            herId: herId,
            herVirtualId: detail?.username ?? '',
            channelId: channelId,
            callType: callType,
            callStatus: CallStatus.PICK_UP,
            dateInsert: DateTime.now().millisecondsSinceEpoch,
            duration: value.totalCallTime ?? '00:00');
      }
      StorageService.to.eventBus.fire(eventBusRefreshMe);
    });
  }

  void handleBlack() {
    Http.instance.post<int>(
      NetPath.blacklistActionApi + herId,
      errCallback: (err) {
        AppLoading.toast(err.message);
      },
      showLoading: true,
    ).then((value) {
      AppLoading.toast(Tr.app_base_success.tr);
      StorageService.to.updateBlackList(herId, value == 1);
      closeMe();
    });
  }

  void closeMe({String? toPage}) {
    Get.back(closeOverlays: true);

    /// 关闭弹窗
    /*if (Get.isOverlaysOpen) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!Get.isDialogOpen! && !Get.isBottomSheetOpen!);
      });
    }
    // 偶现这里关不掉的问题，猜测是main被弹出了
    // 这里做从新打开app的处理
    var canPop = Get.global(null).currentState?.canPop() == true;
    // AppLog.debug('_closeMe canPop=$canPop');
    if (canPop) {
      Get.back();
    } else {
      UserInfo.to.reLogin();
    }*/
  }

  void handleFollow() {
    Http.instance.post<int>(NetPath.followUpApi + herId, showLoading: true,
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      AppEventBus.eventBus
          .fire(FollowEvent(anchorId: herId, isFollowed: value == 1));
      detail?.followed = value;
      update();
    });
  }

  void _getHostDetail() {
    Http.instance.post<HostDetail>(NetPath.upDetailApi + herId,
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      detail = value;
      update();
      StorageService.to.objectBoxMsg.putOrUpdateHer(HerEntity(
          value.nickname ?? '', value.userId!,
          portrait: value.portrait));
    });
  }

  void loadRecommend() {
    Http.instance
        .post<List<HostDetail>>("${NetPath.getMatchUpListApi}6",
            errCallback: (err) {
          AppLoading.toast(err.message);
        })
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
          // debugPrint("====>>> loadRecommend  ===>${value.length}");
          recommend.addAll((value));
          update();
        })
        .catchError((err) {
          AppLoading.toast(err.message);
        });
  }

  void loadRecommend2() {
    Http.instance
        .post<UpListData>(NetPath.upListApi + areaCode, data: {
          "page": 1,
          "pageSize": 30,
          "isShowResource": 1,
        }, errCallback: (err) {
          AppLoading.toast(err.message);
        })
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
          //debugPrint("====>>> loadRecommend  ===>${value.anchorLists?.length}");
          recommend.addAll((value.anchorLists ?? []));
          update();
        })
        .catchError((err) {
          AppLoading.toast(err.message);
        });
  }

  ///呼叫主播
  void callUp(HostDetail item) {
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      closeMe();
      ARoutes.toCalling(anchorId: item.getUid, portrait: item.showPortrait);
    });
  }

  ///与主播私聊
  void startMsg(String anchorId) {
    closeMe();
    ARoutes.toChat(anchorId);
  }

  void pushAnchorDetail(HostDetail mo) {
    closeMe();
    // debugPrint("pushAnchorDetail ===>>> ${mo.toJson()}");
    if (mo.userId != null) {
      ARoutes.toAnchorDetail(mo.userId);
    }
  }
}
