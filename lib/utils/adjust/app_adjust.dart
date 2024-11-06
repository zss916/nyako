import 'package:get/get_utils/src/platform/platform.dart';
import 'package:nyako/utils/adjust/app_adjust_manager.dart';

class AppAdjust {
  AppAdjust._internal();

  static final AppAdjust _instance = AppAdjust._internal();

  static AppAdjust get instance => _instance;

  ///初始化
  void init() {
    AppAdjustManager.init();
  }

  ///上传归因数据到后端
  void upload() {
    AppAdjustManager.checkAdjustUploadAttr();
    if (GetPlatform.isAndroid) {
      AppAdjustManager.getGoogleReferrer();
    }
  }

  ///上传支付事件
  void trackEvent(
      {required num revenue, required String currency, String? orderNo}) {
    AppAdjustManager.trackEvent(
        revenue: revenue, currency: currency, orderNo: orderNo);
  }
}
