part of 'index.dart';

class MeLogic extends GetxController {
  MineSate state = MineSate();

  /// event bus 监听
  late final StreamSubscription<String> sub;
  late final AppCallback<SocketBalance> _balanceListener;

  @override
  void onInit() {
    super.onInit();
    state.dnd.value = state.myDetail?.isDoNotDisturb == 1;

    /// event bus 监听
    sub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == eventBusRefreshMe) {
        refreshMe();
      } else if (event == eventBusRefreshMeFromCache) {
        state.myDetail = UserInfo.to.myDetail;
        update();
      } else if (event == vipRefresh) {
        refreshMe();
      }
    });

    isDoNotDisturb = UserInfo.to.myDetail?.isDoNotDisturb == 1 ? true : false;
  }

  @override
  void onReady() {
    super.onReady();
    _balanceListener = (balance) {
      state.myDetail?.userBalance?.remainDiamonds = balance.diamonds;
      refreshMe();
    };

    Get.putAsync<AppSocketManager>(() => AppSocketManager().init()).then(
        (value) => AppSocketManager.to.addBalanceListener(_balanceListener));
  }

  @override
  void onClose() {
    sub.cancel();
    AppSocketManager.to.removeBalanceListener(_balanceListener);
    super.onClose();
  }

  Future<void> refreshMe() async {
    final info = await ProfileAPI.info(showLoading: false);
    UserInfo.to.setMyDetail = info;
    state.myDetail = info;
    state.num.value = info.rechargeDrawCount ?? 0;
    await UserInfo.to.getSignFrame();
    await UserInfo.to.getMsgCard();
    update();
    StorageService.to.eventBus.fire("userRefresh");
  }

  toEdit() => ARoutes.toUserEdit();

  toService() => showServiceSheet();

  toVip() => ARoutes.toRechargeVip();

  toRecharge() => ARoutes.toRecharge();

  toLottery() => ARoutes.toLottery();

  toPackages() => ARoutes.toPropList();

  toBindGoogle() => BindGoogle.show();

  toIndex(int index) {
    switch (index) {
      case 0:
        ARoutes.toPropList();
        break;
      case 1:
        ARoutes.toUserDynamic();
        break;
      case 2:
        ARoutes.toChatRecord();
        break;
      case 3:
        showServiceSheet();
        break;
      case 4:
        ARoutes.toInviteCode(state.inviterCode, state.isTimeOut);
        break;
      case 5:
        ARoutes.toShare();
        break;
      case 6:
        ARoutes.toSetting();
        break;
      case 7:
        BindGoogle.show();
        break;
      case 8:
        showSearchConfirm();
        break;
      case 9:
        toSignDialog();
        // showSignReward(SignBean()..type = 10);
        break;
    }
  }

  void getFreeDiamond() {
    if (state.isVip) {
      Http.instance.post<dynamic>(NetPath.getVipFreeDiamond,
          showLoading: true,
          showToast: false, doneCallback: (bool success, String message) {
        if (success) {
          showFreeDiamond(diamond: UserInfo.to.config?.vipDailyDiamonds ?? 0);
        } else {
          AppCommonDialog.dialog(
              AppDialogConfirm(
                callback: (int callback) {},
                title: Tr.app_free_diamond_tip.tr,
                h: 220,
                onlyConfirm: true,
                showIcon: false,
              ),
              routeSettings: const RouteSettings(name: AppPages.vipGetDialog));
        }
      });
    } else {
      //showFreeDiamondSign();
      sheetToVip(path: ChargePath.recharge_vip_dialog_user_center);
    }
  }

  late bool isDoNotDisturb;
  switchDND(bool isDo) async {
    isDoNotDisturb = isDo;
    await ProfileAPI.setDnd(isDoNotDisturb: isDo, showLoading: true);
    UserInfo.to.myDetail?.isDoNotDisturb = isDo ? 1 : 0;
    update(["disturbId"]);
    AppLoading.toast(Tr.appSetSuccess.tr);
  }
}
