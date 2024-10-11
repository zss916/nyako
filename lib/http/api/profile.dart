part of 'index.dart';

abstract class ProfileAPI {
  /// 用户信息
  static Future<InfoDetail> info(
      {bool showLoading = true, VoidCallback? call}) async {
    final result = await Http.instance
        .post<InfoDetail>(
          NetPath.userInfoApi,
          showLoading: showLoading,
          errCallback: (err) => call?.call(),
        )
        .whenComplete(() => AppLoading.dismiss());
    return result;
  }

  /// 更新勿扰设置
  static Future<void> setDnd(
      {required bool isDoNotDisturb, bool showLoading = true}) async {
    return await Http.instance
        .post<void>(NetPath.updateUserInfoApi,
            data: {"isDoNotDisturb": isDoNotDisturb ? 1 : 0}, showLoading: true)
        .whenComplete(() => AppLoading.dismiss());
  }

  ///更新用户信息
  static Future<void> updateUser({required Map<String, dynamic> map}) async {
    await Http.instance
        .post<void>(NetPath.updateUserInfoApi, data: map, showLoading: true)
        .whenComplete(() => AppLoading.dismiss());
  }

  ///关注
  static Future<int> follow({required String anchorId}) async {
    return await Http.instance.post<int>(NetPath.followUpApi + anchorId,
        errCallback: (err) {
      AppLoading.toast(err.message);
    });
  }

  /// 拉黑等
  static Future<int> handBlack(
      {required String anchorId, bool showLoading = true}) async {
    return await Http.instance.post<int>(NetPath.blacklistActionApi + anchorId,
        showLoading: showLoading);
  }

  /// 解除主播黑名单
  static Future<int> relieveBlackout(String anchorId,
      {bool showLoading = true}) async {
    return await handBlack(anchorId: anchorId, showLoading: showLoading);
  }

  ///举报
  static Future report({required dynamic data, bool showLoading = true}) async {
    return await Http.instance
        .post<void>(NetPath.reportUpApi, data: data, showLoading: showLoading);
  }

  ///发布
  static Future public({required dynamic data, bool showLoading = true}) async {
    return await Http.instance.post<void>(NetPath.saveReviewContent,
        data: data, showLoading: showLoading, errCallback: (err) {
      AppLoading.toast(err.message);
    }).whenComplete(() => AppLoading.dismiss());
  }
}
