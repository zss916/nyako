part of 'index.dart';

class MainLogic extends GetxController {
  Timer? _timer;
  late int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    AppAdjust.instance.upload();
    AppAiLogicUtils().init();
    UserInfo.to.addLoginCount();
  }

  @override
  void onReady() {
    super.onReady();
    showVipOnlineDialog(onNext: () {
      checkToWarmTipShow(onEnd: () {
        AppNewUserCardsTip.checkToShow();
      });
    });

    CommonAPI.gifts();
    CommonAPI.sensitiveWords();
    StorageService.to.objectBoxMsg.refreshUnreadNum();
    CheckAppUpdate.check();
    AppCheckDND.checkDND();
    UserInfo.to.getSignFrame();
    UserInfo.to.getMsgCard();
    DiamondAPI.loadDiamond();

    // 定时器检查
    if (!AppConstants.isFakeMode) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final tick = timer.tick;
        // 每15s 检查 rtm
        final remainder15 = tick % 15;
        if (remainder15 == 0) {
          Rtm.instance.connectRtm();
        }
        // 每30s 检查 支付
        final remainder30 = tick % 30;
        if (remainder30 == 0) {
          Billing.fixNoEndPurchase();
          AppPayCacheManager.checkOrderList();
        }
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    AppAiLogicUtils().cancel();
  }

  @Deprecated("close")
  void checkNotification() {
    NotificationPermissions.getNotificationPermissionStatus().then((value) {
      if (value == PermissionStatus.granted) {
        // 已授权
        debugPrint('notification permissions');
      } else {
        // 未授权
        AppPermissionHandler.checkNotificationPermission();
      }
    });
  }
}
