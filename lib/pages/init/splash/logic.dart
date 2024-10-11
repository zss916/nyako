part of 'index.dart';

class SplashLogic extends GetxController {
  @override
  void onReady() {
    super.onReady();
    initApp();
  }

  initApp() {
    AppRingManager.instance.stopPlayRing();
    AppLanguageNetHelper.handleLanguageJsonV2();
    getConfig();
  }

  // 获取config
  void getConfig() async {
    await CommonAPI.config(showLoading: true);
    if (UserInfo.to.hasAuthorization) {
      _getProfile();
    } else {
      ARoutes.offAndToLogin();
    }
    // 初始化adjust
    AppAdjust.instance.init();
  }

  // 已经登陆过，加载个人信息后去主页
  Future<void> _getProfile() async {
    InfoDetail data =
        await ProfileAPI.info(call: () => ARoutes.offAndToLogin());
    AppConstants.isFakeMode = !(data.isAppRelease);
    if (data.isAppRelease) {
      Rtm.instance.initIM();
    }
    UserInfo.to.setMyDetail = data;
    ARoutes.offAndToMain();
  }
}
