part of 'index.dart';

class AccountLoginLogic extends GetxController {
  void onSubmit(String account, String password) async {
    if (account.isEmpty) {
      AppLoading.toast(Tr.app_details_edit_name.tr);
      return;
    }
    if (password.isEmpty) {
      AppLoading.toast(Tr.app_promapp_password.tr);
      return;
    }
    final data = await AccountAPI.login(account: account, password: password);

    UserInfo.to.setVisitorAccount(account);
    UserInfo.to.setVisitorPassword(password);
    UserInfo.to.setLoginData(data);
    final info = await UserInfo.to.profile();
    LoginCache.save(
        uid: data.user?.userId ?? "",
        userName: data.user?.username ?? "",
        nickName: data.user?.nickname ?? "",
        portrait: data.user?.portrait ?? "",
        password: password,
        isGoogle: false,
        isGust: false,
        diamondCount: (info?.userBalance?.remainDiamonds ?? 0).toString());
    AppConstants.isFakeMode = !UserInfo.to.isAppRelease;
    if (UserInfo.to.isAppRelease) Rtm.instance.initIM();
    ARoutes.offAndToMain();
  }
}
