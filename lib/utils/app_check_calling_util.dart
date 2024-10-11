import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/user_info.dart';

import '../routes/app_pages.dart';

class AppCheckCallingUtil {
  // 刚给这个主播打完电话，就不弹出她的aib了
  static String? herIdRecently;
  static int herIdTime = 0;

  // 刚给这个主播打完电话，设置一下这个结束的时间
  static setCallRecently(String herId) {
    herIdRecently = '$herId';
    herIdTime = DateTime.now().millisecondsSinceEpoch;
  }

  // 给这个主播打过电话，15s内不要她的aib
  static bool checkCallHerRecently(String herId) {
    var passTime = DateTime.now().millisecondsSinceEpoch - herIdTime;
    return herId == herIdRecently && passTime < 15 * 1000;
  }

  // 打过电话，30s内不要aic
  static bool _checkCallRecently() {
    var passTime = DateTime.now().millisecondsSinceEpoch - herIdTime;
    return passTime < 30 * 1000;
  }

  // 能被叫？
  static bool checkCanBeCalled({Function(String)? fun}) {
    // debugPrint("checkCanBeCalled ");
    // 拨打接听，电话，虚拟视频
    if (checkCalling()) {
      fun?.call(" checkCalling ");
      return false;
    }

    if (AppPages.isAppBackground) {
      fun?.call(" isAppBackground ");
      return false;
    }

    // 登录页  充值中心页  私聊页
    if (ARoutes.isLoginPage) {
      fun?.call(" isLoginPage ");
      return false;
    }

    if (ARoutes.isRecharge) {
      fun?.call(" isRecharge ");
      return false;
    }

    if (UserInfo.to.myDetail?.isDoNotDisturb == 1) {
      fun?.call(" isDoNotDisturb ");
      return false;
    }

    if (ARoutes.isMatchResult) {
      fun?.call(" isMatchResult ");
      return false;
    }

    ///VIP dialog
    if (ARoutes.isVIPDialog) {
      fun?.call(" isVIPDialog ");
      return false;
    }

    ///渠道支付
    if (ARoutes.isChannelPay) {
      fun?.call(" isChannelPay ");
      return false;
    }

    ///被叫权限页面
    if (AppConstants.isBeCallPermission) {
      fun?.call(" isBeCallPermission ");
      return false;
    }

    ///匹配游戏页面
    if (AppConstants.isMatch) {
      fun?.call(" isMatch ");
      return false;
    }

    ///快捷充值
    if (AppConstants.isQuickPay) {
      fun?.call(" isQuickPay ");
      return false;
    }

    ///Lottery
    if (ARoutes.isLottery) {
      fun?.call(" isLottery ");
      return false;
    }

    ///logout
    if (ARoutes.isLogoutDialog) {
      fun?.call(" isLogout ");
      return false;
    }

    return true;
  }

  // 能被叫aic?
  static bool checkCanAic() {
    // debugPrint("checkCanAic   ${AppPages.history.contains(AppPages.callCome)}");
    // if (_checkCallRecently()) return false;
    if (!checkCanBeCalled()) return false;
    // 登录页
    if (ARoutes.isLoginPage) return false;
    final pages = AppPages.history;
    if (pages.contains(AppPages.matchingPage)) {
      return false;
    }
    // 充值中
    if (pages.contains(AppPages.recharge)) {
      return false;
    }
    /* if (pages.contains(AppPages.iosCharge)) {
      return false;
    }*/
    if (pages.contains(AppPages.webPage)) {
      return false;
    }

    ///匹配
    if (ARoutes.isMatchResult) {
      return false;
    }

    ///VIP dialog
    if (ARoutes.isVIPDialog) {
      return false;
    }

    ///logout
    if (ARoutes.isLogoutDialog) {
      return false;
    }

    ///渠道支付
    if (ARoutes.isChannelPay) {
      return false;
    }

    // 主播封面视频中
    // if (pages.contains(AppPages.herVideo)) {
    //   return false;
    // }

    /// 聊天中
    if (ARoutes.isChat) {
      return false;
    }
    //用户打开了充值弹窗
    if (ChargeDialogManager.isShowingChargeDialog) {
      return false;
    }
    return true;
  }

  // 能被叫aib?
  static bool checkCanAib() {
    if (!checkCanBeCalled()) return false;
    final pages = AppPages.history;
    // 聊天中
    if (ARoutes.isChat) {
      return false;
    }
    // 匹配中
    if (pages.contains(AppPages.matchingPage)) {
      return false;
    }
    // 充值中
    if (pages.contains(AppPages.recharge)) {
      return false;
    }
    /*if (pages.contains(AppPages.iosCharge)) {
      return false;
    }*/
    if (pages.contains(AppPages.webPage)) {
      return false;
    }
    //用户打开了充值弹窗
    if (ChargeDialogManager.isShowingChargeDialog) {
      return false;
    }

    ///匹配
    if (ARoutes.isMatchResult) {
      return false;
    }

    ///VIP dialog
    if (ARoutes.isVIPDialog) {
      return false;
    }

    ///渠道支付
    if (ARoutes.isChannelPay) {
      return false;
    }

    ///logout
    if (ARoutes.isLogoutDialog) {
      return false;
    }

    return true;
  }

  /// 检查当前是否正在通话，来屏蔽某些操作
  static bool checkCalling() {
    //debugPrint("checkCalling ");
    if (AppPages.history.contains(AppPages.call) ||
        AppPages.history.contains(AppPages.callOut) ||
        AppPages.history.contains(AppPages.aicPage) ||
        AppPages.history.contains(AppPages.callCome) ||
        AppPages.history.contains(AppPages.aivPage)) {
      return true;
    }
    return false;
  }
}
