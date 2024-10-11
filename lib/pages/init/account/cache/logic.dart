part of 'index.dart';

class AccountCacheLogic extends GetxController with OtherLoginUtils {
  AppLoginEntity? get loginCache => LoginCache.getLastLogin();

  @override
  void onReady() {
    super.onReady();
  }

  void onSubmit() {
    if (loginCache?.isGoogle == true) {
      toGoogleSignIn();
    } else {
      toAccountLogin();
    }
  }

  Future<void> toAccountLogin() async {
    String account = loginCache?.userName ?? "";
    String password = loginCache?.password ?? "";

    if (account.isEmpty) {
      AppLoading.toast(Tr.app_details_edit_name.tr);
      return;
    }
    if (password.isEmpty) {
      AppLoading.toast(Tr.app_promapp_password.tr);
      return;
    }

    final data = await AccountAPI.login(
        account: account.trim(), password: password.trim());

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

  /// google登录
  void toGoogleSignIn() {
    /*debugPrint("===>>>>>_loginGoogle ${loginCache!.token},"
        "${loginCache!.googleId},"
        "${loginCache!.nickName},"
        "${loginCache!.profileUrl}");*/
    _loginGoogle(loginCache!.token, loginCache!.googleId!, loginCache!.nickName,
        loginCache!.profileUrl);
  }

  void _loginGoogle(String? token, String id, String? nickname, String? cover) {
    var config = Http.instance.post<Login>(NetPath.googleLoginApi, data: {
      "id": id,
      "cover": cover ?? heads[rnd.nextInt(5)],
      "token": token ?? "",
      "nickname": nickname ?? getRandomString(5),
    }, errCallback: (err) {
      AppLoading.toast(err.toString());
    }, doneCallback: (success, re) {
      loginIng = false;
    }, showLoading: true);
    config.then((value) {
      UserInfo.to.setLoginData(value);
      AppLoading.dismiss();
      _toMain(
        data: value,
        googleId: id,
        googleToken: token,
        isGoogle: true,
      );
    });
  }

  Future<void> _toMain(
      {required Login data,
      String? password,
      String? googleId,
      String? googleToken,
      bool? isGoogle,
      bool? isGust}) async {
    final info = await ProfileAPI.info(showLoading: true);
    AppConstants.isFakeMode = !(info.isAppRelease);
    if (info.isAppRelease) {
      Rtm.instance.initIM();
    }

    UserInfo.to.setMyDetail = info;
    LoginCache.save(
        uid: isGoogle == true ? googleId ?? "" : data.user?.userId ?? "",
        userName: data.user?.username ?? "",
        nickName: data.user?.nickname ?? "",
        portrait: data.user?.portrait ?? "",
        password: password,
        isGoogle: isGoogle,
        googleId: googleId,
        googleToken: googleToken,
        isGust: isGust,
        diamondCount: (info.userBalance?.remainDiamonds ?? 0).toString());
    ARoutes.offAndToMain();
  }
}
