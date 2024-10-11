import 'package:mypackage/app_login_util.dart';
import 'package:mypackage/app_third_util.dart';
import 'package:oliapro/common/app_constants.dart';

typedef GoogleCallBack = void Function(
    {required bool success,
    String? token,
    String? id,
    String? nickname,
    String? cover});

typedef FbCallBack = void Function({required bool success, String? token});

class AppOtherPluginManage {
  static askReview() {
    if (AppConstants.isOpenOnlinePlugin) {
      AppThirdUtil.askReview();
    }
  }

  static Future<String> installReference() async {
    if (AppConstants.isOpenOnlinePlugin) {
      return await AppThirdUtil.installReference();
    } else {
      return Future.value("");
    }
    //return Future.value("");
  }

  static googleLogin(GoogleCallBack callBack) {
    if (AppConstants.isOpenOnlinePlugin) {
      AppLoginUtil.instance.googleSignIn(callBack);
    }
  }
}
