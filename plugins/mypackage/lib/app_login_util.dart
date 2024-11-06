// import 'package:nyako/common/app_common_type.dart';
//
// class AppLoginData {
//   bool success = false;
//   String? token;
//   String id = '';
//   String? nickname;
//   String? cover;
// }
//
// class AppLoginUtil {
//   void googleSignIn(AppCallback<AppLoginData> callback) async {
//     callback.call(AppLoginData());
//   }
//
//   void facebookSignIn(AppCallback<AppLoginData> callback) async {
//     callback.call(AppLoginData());
//   }
//
//   void appleSignIn(AppCallback<AppLoginData> callback) async {
//     callback.call(AppLoginData());
//   }
// }

/// 这个注释上下是打包时要切换注释的，下面的是线上的
///
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

/*class AppLoginData {
  bool success = false;
  String? token;
  String id = '';
  String? nickname;
  String? cover;
}*/

typedef GoogleCallBack = void Function(
    {required bool success,
    String? token,
    String? id,
    String? nickname,
    String? cover});

typedef FbCallBack = void Function({required bool success, String? token});

class AppLoginUtil {
  AppLoginUtil._internal();

  static final AppLoginUtil _instance = AppLoginUtil._internal();

  static AppLoginUtil get instance => _instance;

  GoogleSignIn? _googleSign;

  void googleSignIn(GoogleCallBack callback) async {
    _googleSign ??= GoogleSignIn();
    try {
      final isSigned = await _googleSign!.isSignedIn();
      if (isSigned) {
        await _googleSign!.signOut();
      }
      final result = await _googleSign!.signIn();
      final googleAuth = await result?.authentication;

      if (result?.id == null) {
        // AppLoading.toast(Tr.app_invoke_err.tr);
        callback.call(success: false);
      } else {
        // AppLog.debug(googleAuth ?? 'googleSignIn err');
        callback.call(
            success: true,
            token: googleAuth!.accessToken,
            id: result!.id,
            nickname: result.displayName,
            cover: result.photoUrl);
      }
    } catch (error) {
      if (Platform.isAndroid) {
        // AppLoading.toast(Tr.app_invoke_err.tr);
      } else {
        // AppLoading.toast(Tr.app_invoke_err.tr);
      }
      callback.call(success: false);
    }
  }

  void facebookSignIn(FbCallBack callback) async {}

  // void appleSignIn(AppCallback<AppLoginData> callback) async {}
}
