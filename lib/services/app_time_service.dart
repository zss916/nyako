import 'dart:async';

import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';

class AppTimeService extends GetxService {
  static AppTimeService get to => Get.find();

  Future<AppTimeService> init() async {
    return this;
  }

  // 计时器
  Timer? _timer;

  late int duration = 60 * 60;
  var quickLeftTime = 0.obs;
  bool startCountDown = false;

  @override
  void onInit() {
    super.onInit();
    quickLeftTime.value = duration;
  }

  @override
  void onReady() {
    super.onReady();
    // 定时器检查
    if (!AppConstants.isFakeMode) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (startCountDown) {
          //快捷充值倒计时
          quickLeftTime.value--;
          if (quickLeftTime.value <= 0) {
            quickLeftTime.value = duration;
          }
        }
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }

  ///重置倒计时
  reset() {
    quickLeftTime.value = duration;
  }
}
