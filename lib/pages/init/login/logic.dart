part of 'index.dart';

class LoginLogic extends GetxController with OtherLoginUtils {
  bool get isShowGust => LoginCache.getLastLogin() == null;

  bool get isShowGoogle => LoginCache.getLastLogin()?.isGoogle == true;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    CheckAppUpdate.check();
  }

  ///游客登录
  void visitorLogin() {
    String password = generatePassword(8);
    var config = Http.instance.post<Login>(NetPath.visitorLoginApi, data: {
      "password": password,
    }, errCallback: (err) {
      AppLoading.toast(err.toString());
    }, doneCallback: (success, re) {
      loginIng = false;
    }, showLoading: true);
    config.then((value) {
      UserInfo.to.setVisitorPassword(password);
      UserInfo.to.setVisitorAccount(value.user?.username ?? '');
      UserInfo.to.setLoginData(value);
      AppLoading.dismiss();
      // debugPrint("===>>>isBinding444:uid:${value.user?.userId}");
      _toMain(data: value, password: password, isGoogle: false, isGust: true);
    });
  }

  /// google登录
  void toGoogleSignIn() {
    googleLogin(({cover, id, nickname, required success, token}) {
      _loginGoogle(token, id!, nickname, cover);
    });
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

  /// 测试登录
  void testLoginGoogle(String id) {
    checkGoogleAccount(
        id: id,
        onCheck: () {
          Http.instance.post<Login>(NetPath.googleLoginApi, data: {
            "id": id,
            "cover": heads[rnd.nextInt(5)],
            "nickname": "${AppInfoService.to.channel}_${getRandomString(5)}",
          }, errCallback: (err) {
            AppLoading.toast(err.toString());
          }, showLoading: true).then((value) {
            UserInfo.to.setLoginData(value);
            StorageService.to.prefs.setString("test_google_id", id);
            AppLoading.dismiss();
            _toMain(data: value, isGoogle: true, googleId: id, googleToken: "");
          });
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
    UserInfo.to.setMyDetail = info;
    UserInfo.to.setLoginState();

    AppConstants.isFakeMode = !(info.isAppRelease);
    if (info.isAppRelease) {
      Rtm.instance.initIM();
    }

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
