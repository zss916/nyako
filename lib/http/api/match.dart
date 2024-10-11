part of 'index.dart';

abstract class MatchAPI {
  ///匹配一个
  static Future<HostMatchLimitEntity> matchOneLimit() async {
    return await Http.instance.post<HostMatchLimitEntity>(
        NetPath.matchOneAnchorLimit, errCallback: (e) {
      AppConstants.isMatch = false;
    });
  }

  ///匹配次数
  static Future<int> matchCount() async {
    final data = await Http.instance.post<HostMatchLimitEntity>(
      "${NetPath.matchOneAnchorLimit}/1",
    );
    return (data.matchCount ?? 0);
  }
}