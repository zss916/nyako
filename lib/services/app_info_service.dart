import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  static AppInfoService get to => Get.find();
  late String deviceIdentifier;
  late String deviceModel;
  late String appSystemVersionKey;
  late String version;
  late String buildNumber;
  late String packageName;
  late int sdkVersion;

  String get channelName {
    if (GetPlatform.isIOS == true) {
      return "${channel}200";
    }
    return "${channel}100";
  }

  String channel = AppConstants.channelName;
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  final _androidIdPlugin = const AndroidId();

  Future<AppInfoService> init() async {
    // 设备信息
    if (GetPlatform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      appSystemVersionKey = iosDeviceInfo.systemVersion ?? "unknow";
      deviceIdentifier =
          "${iosDeviceInfo.identifierForVendor ?? ""}-${iosDeviceInfo.utsname.machine ?? ""}";
      deviceModel = "ios ${iosDeviceInfo.model ?? "iphone"}";
    } else if (GetPlatform.isAndroid) {
      final String? androidId = await _androidIdPlugin.getId();
      AndroidDeviceInfo androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      appSystemVersionKey = androidDeviceInfo.version.release;
      sdkVersion = androidDeviceInfo.version.sdkInt;
      deviceIdentifier = "$androidId-${androidDeviceInfo.brand}";
      deviceModel = "android ${androidDeviceInfo.model}";
    }
    // 包信息
    final info = await PackageInfo.fromPlatform();
    version = info.version;
    buildNumber = info.buildNumber;
    packageName = info.packageName;
    return this;
  }
}
