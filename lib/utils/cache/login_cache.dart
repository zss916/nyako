import 'package:oliapro/database/entity/app_login_entity.dart';
import 'package:oliapro/services/storage_service.dart';

class LoginCache {
  static save(
      {required String uid,
      String? userName,
      String? nickName,
      String? portrait,
      String? email,
      String? password,
      bool? isGoogle,
      String? googleId,
      String? googleToken,
      bool? isGust,
      String? diamondCount}) {
    var data = AppLoginEntity(
      userId: uid,
      loginTime: DateTime.now().millisecondsSinceEpoch,
    );
    if (userName != null) {
      data.userName = userName;
    }
    if (nickName != null) {
      data.nickName = nickName;
    }
    if (portrait != null) {
      data.profileUrl = portrait;
    }
    if (email != null) {
      data.email = email;
    }
    if (password != null && password.isNotEmpty) {
      data.password = password;
    }
    if (isGoogle != null) {
      data.isGoogle = isGoogle;
    }

    if (googleId != null && googleId.isNotEmpty) {
      data.googleId = googleId;
    }

    if (googleToken != null && googleToken.isNotEmpty) {
      data.token = googleToken;
    }

    if (isGust != null) {
      data.isGust = isGust;
    }
    if (diamondCount != null) {
      data.diamondCount = diamondCount;
    }

    StorageService.to.objectBoxLogin.putOrUpdate(data);
  }

  ///清除缓存登录数据
  static Future<void> cleanAll() async =>
      StorageService.to.objectBoxLogin.cleanAll();

  static AppLoginEntity? getLastLogin() =>
      StorageService.to.objectBoxLogin.getLastLogin();

  static update({String? nickName, String? profile, String? diamondCount}) {
    StorageService.to.objectBoxLogin.updateInfo(
        nickName: nickName, profile: profile, diamondCount: diamondCount);
  }

  static updatePsd(String userId, String password) =>
      StorageService.to.objectBoxLogin.updatePsd(userId, password);
}
