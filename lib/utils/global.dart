import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/services/app_info_service.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_loading.dart';

/// 全局静态数据
class AppGlobal {
  /// 初始化
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    setSystemUi();
    AppLoading();

    await Get.putAsync<StorageService>(() => StorageService().init());
    await Get.putAsync<AppInfoService>(() => AppInfoService().init());
    await Get.putAsync<UserInfo>(() => UserInfo().init());
    //await Get.putAsync<AppTimeService>(() => AppTimeService().init());
    //await Get.putAsync<AppPointService>(() => AppPointService().init());
  }

  static Future<void> setSystemUi() async {
    ///禁止横屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        // 状态栏图标和文字=>(亮色light,暗色dark)
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        // 状态栏图标亮色
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
