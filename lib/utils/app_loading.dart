import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoading {
  AppLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..toastPosition = EasyLoadingToastPosition.center
      ..progressColor = Colors.white
      ..backgroundColor = Colors.white.withOpacity(0.3)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.transparent
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;
  }

  static void show({String? text, bool dismissOnTap = true,int milliseconds = 2000}) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.dismissOnTap = dismissOnTap;
    EasyLoading.instance.displayDuration = Duration(milliseconds: milliseconds);
    EasyLoading.show(status: text);
  }

  static void toast(
    String text, {
    Duration? duration,
  }) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }

  static bool isShow() => EasyLoading.isShow;
}
