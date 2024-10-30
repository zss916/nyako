part of 'index.dart';

class SetLogic extends GetxController {
  List<Map<String, String>> listData = [
    {
      "image": Assets.iconBlacklist,
      'title': Tr.app_setting_black_list.tr,
      'type': 'block'
    },
    {
      "image": Assets.iconBlacklist,
      'title': Tr.app_report_title.tr,
      'type': 'report'
    },
    {
      "image": Assets.iconAboutUs,
      'title': Tr.app_setting_about_us.tr,
      'type': 'about'
    },
    {
      "image": Assets.iconSearch,
      'title': Tr.app_setting_search.tr,
      'type': 'search'
    },
    {
      "image": Assets.iconDisturb,
      'title': Tr.app_setting_trouble.tr,
      'type': 'trouble'
    },
    {
      "image": Assets.iconSetPsd,
      'title': Tr.app_change_pwd.tr,
      'type': 'edit_psd'
    },
    {
      "image": Assets.iconDeleteAccount,
      'title': Tr.app_account_cancellation.tr,
      'type': 'delete_account'
    },
  ];

  late bool isDoNotDisturb;

  pushView(String type) async {
    switch (type) {
      case "block":
        ARoutes.toBlack();
        break;
      case "report":
        ARoutes.toReport(type: ReportEnum.setting.index.toString());
        break;
      case "about":
        ARoutes.toAbout();
        break;
      case "search":
        showSearchConfirm();
        break;
      case "edit_psd":
        ARoutes.toChangePsd();
        break;
      case "delete_account":
        ARoutes.toDeleteAccount();

        /* AppCommonDialog.dialog(AppNewUserCardsTip(2),
            barrierColor: Colors.black.withOpacity(0.8),
            routeSettings: const RouteSettings(name: AppPages.newUserDialog));*/
        break;
    }
  }

  void switchDND(bool isDo) async {
    isDoNotDisturb = isDo;
    await ProfileAPI.setDnd(isDoNotDisturb: isDo, showLoading: true);
    UserInfo.to.myDetail?.isDoNotDisturb = isDo ? 1 : 0;
    update(["disturbId"]);
    if (UserInfo.to.myDetail?.isDoNotDisturb == 1) {
      StorageService.to.setDND(DateTime.now().millisecond);
    }
  }

  void logout() {
    // showRewardDiamondDialog();
    //showRewardCouponDialog();
    //showRewardTimeDialog();
    //showTransferAppDialog();
    // ChangePasswordDialog2.show("dddd", "ddd", () {});
    showLogoutDialog();
  }
}
