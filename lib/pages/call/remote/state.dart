part of 'index.dart';

class RemoteState {
  HostDetail detail = HostDetail();

  String get showNick => detail.showNickName;

  String get herId => (Get.arguments as Map<String, dynamic>)["'herId'"] ?? "";

  late String channelId =
      (Get.arguments as Map<String, dynamic>)["'channelId'"] ?? "";

  late String content =
      (Get.arguments as Map<String, dynamic>)["'content'"] ?? "";

  /// 0拨打，1被叫，
  /// 2aib拨打(aib是被叫页面，实际是要去拨打),
  /// 3aic
  /// 4aiv 直接显示网络视频
  int get callType =>
      (Get.arguments as Map<String, dynamic>)["'callType'"] ?? 1;
}
