part of 'index.dart';

///账户api
abstract class AccountAPI {
  static Future<Login> login({
    required String account,
    required String password,
  }) async {
    final result = await Http.instance.post<Login>(NetPath.accountLogin,
        data: {
          "username": account,
          "password": password,
        },
        showLoading: true);
    return result;
  }

  static Future<void> register({
    required String account,
    required String password,
  }) async {
    await Http.instance.post<void>(NetPath.auditModeRegister,
        data: {
          "username": account,
          "password": password,
        },
        showLoading: true);
  }

  ///修改账户密码
  static Future<void> updateAccountPsd({
    required String oldPassword,
    required String newPassword,
  }) async {
    await Http.instance.post<void>(NetPath.changePasswordApi,
        data: {
          "oriPassword": oldPassword,
          "newPassword": newPassword,
        },
        showLoading: true);
  }

  ///退出登录
  static Future<void> logOut() async {
    await Http.instance.post(NetPath.loginOutApi);
  }

  ///销户
  static Future<void> deleteAccount() async {
    await Http.instance.post(NetPath.deleteCurrentAccount);
  }

  ///判断谷歌账户是否绑定app账户
  static Future<bool> checkBindGoogleAccount({required String googleId}) async {
    return await Http.instance.post(
      NetPath.checkBindGoogleAccount,
      data: {"id": googleId},
    );
  }

  ///判断客户端缓存的登录数据  loginType =3 无缓存登录（之前没登录过,第一个Google账号登录）/因为当前登录和缓存都是谷歌账号（多个Google 账号登录），所以绑定不了，按照无缓存处理， loginType =2 当前Google 账号和缓存登录账号是否可以绑定(之前有缓存账号，Google登录)
  static Future<void> checkCacheAccount(
      {required int loginType,
      required String googleId,
      required String uid}) async {
    await Http.instance.post<void>(NetPath.checkCacheAccount,
        data: {"loginType": loginType, "id": googleId, "userId": uid},
        errCallback: (err) {
      AppLoading.toast(err.message);
    });
  }
}
