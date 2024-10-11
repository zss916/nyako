part of 'index.dart';

class ChangePasswordLogic extends GetxController {
  changePassword(
      String oldPassword, String newPassword, String newAgainPassword) async {
    if (oldPassword.isEmpty) {
      AppLoading.toast(Tr.app_promapp_password.tr);
      return;
    }
    if (newPassword.isEmpty || newAgainPassword.isEmpty) {
      AppLoading.toast(Tr.app_input_new_pwd.tr);
      return;
    }
    if (newPassword != newAgainPassword) {
      AppLoading.toast(Tr.app_prompt_password_different.tr);
      return;
    }

    await AccountAPI.updateAccountPsd(
        oldPassword: oldPassword, newPassword: newPassword);
    String account = UserInfo.to.getVisitorAccount();
    UserInfo.to.setVisitorPassword(newPassword);
    LoginCache.updatePsd(account, newPassword);
    ChangePasswordDialog2.show(account, newPassword, () {
      UserInfo.to.reAccountLogin();
    });
  }
}
