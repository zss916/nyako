import 'package:flutter/material.dart';

class AppLoginTest extends StatelessWidget {
  const AppLoginTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        /* if (AppConstants.haveTestLogin)
          BuildTestLogin(
              testGoogleId:
                  StorageService.to.prefs.getString("test_google_id") ?? "",
              mode: StorageService.to.getTestStyle,
              onTestLogin: (str) {
                safeFind<LoginLogic>()?.testLoginGoogle(str);
              },
              onSwitchEnvironment: (mode, configUrl, socketUrl, baseUrl) {
                StorageService.to.saveTestStyle(mode);
                NetPath.configBaseUrl = configUrl;
                NetPath.socketBaseUrl = socketUrl;
                NetPath.baseUrl = baseUrl;
                Get.delete<SplashLogic>();
                ARoutes.offSplash();
              })*/
      ],
    );
  }
}
