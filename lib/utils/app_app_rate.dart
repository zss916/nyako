import 'package:get/get.dart';
import 'package:nyako/dialogs/sheet_google_rate.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/utils/mylib/app_other_plugin_manage.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRate {
  static void rateApp(String msg) async {
    //用户打开了充值弹窗 屏蔽评分弹窗
    if (ChargeDialogManager.isShowingChargeDialog) {
      return;
    }

    if (msg == "0") {
      if (GetPlatform.isIOS == true) {
        //苹果仿真内部评分
        //showFakeRateApp();
      } else {
        //安卓弹老样式 自定义评分弹窗
        // showRateApp(ignore: false);
        //安卓仿真内部评分
        showGoogleRate();
      }
    } else {
      try {
        AppOtherPluginManage.askReview();
      } catch (e) {
        //无法弹出内部评分
        if (GetPlatform.isIOS) {
          if (await canLaunchUrl(Uri.parse(
              "itms-apps://itunes.apple.com/app/idxxxxx?action=write-review"))) {
            launchUrl(Uri.parse(
                "itms-apps://itunes.apple.com/app/idxxxxx?action=write-review"));
          }
        } else if (GetPlatform.isAndroid) {
          if (await canLaunchUrl(Uri.parse(
              "https://play.google.com/store/apps/details?id=${AppInfoService.to.packageName}"))) {
            launchUrl(Uri.parse(
                "https://play.google.com/store/apps/details?id=${AppInfoService.to.packageName}"));
          }
        }
      }
    }
  }
}
