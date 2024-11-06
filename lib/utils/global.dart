import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_loading.dart';

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
  }

  static Future<void> setSystemUi() async {
    ///禁止横屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,

        /// 状态栏图标和文字=>(亮色light,暗色dark)
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,

        /// 状态栏图标亮色
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
