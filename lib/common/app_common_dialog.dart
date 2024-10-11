import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCommonDialog {
  static Future<T?> dialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    return Get.dialog(widget,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.8),
        useSafeArea: useSafeArea,
        routeSettings: routeSettings);
  }
}
