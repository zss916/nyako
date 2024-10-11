import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pages.dart';

class AppRouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    var name = route.settings.name ?? '';
    if (name.isNotEmpty) AppPages.history.add(name);

    // AppLog.debug('RouteObserver didPush; history:${AppPages.history}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppPages.history.remove(route.settings.name);
    //AppLog.debug('RouteObserver didPop; history:${AppPages.history}');

    if (AppPages.history.isNotEmpty) {
      if (Get.rawRoute is! GetPageRoute) {
        Get.routing.update((value) {
          /// 这个弹窗有路由名字就设置成它的名字，
          /// 默认没有名字，就设为我们自己记录的路由栈顶页面名字
          value.current = Get.rawRoute?.settings.name ?? AppPages.history.last;
        });
      }
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      var index = AppPages.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      var name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > 0) {
          AppPages.history[index] = name;
        } else {
          AppPages.history.add(name);
        }
      }
    }
    // AppLog.debug('RouteObserver didReplace; history:${AppPages.history}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    AppPages.history.remove(route.settings.name);

    // AppLog.debug('RouteObserver didRemove; history:${AppPages.history}');
  }
}
