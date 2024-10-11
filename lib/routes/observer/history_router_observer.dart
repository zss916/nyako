import 'package:flutter/material.dart';
import 'package:oliapro/utils/log/log_control.dart';

HistoryRouteObserver routeHistoryObserver = HistoryRouteObserver();

///记录路由历史
class HistoryRouteObserver extends RouteObserver<PageRoute> {
  List<Route<dynamic>> history = <Route<dynamic>>[];

  List<String> historyPage = [];

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    history.remove(route);
    historyPage.remove(route.settings.name ?? "");

    ///logger
    LogControl.routeObserverAction(
        "${previousRoute?.settings.name} <= ${route.settings.name}");
    LogControl.routeObserverLog(historyPage);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    history.add(route);
    historyPage.add(route.settings.name ?? "");

    ///logger
    LogControl.routeObserverAction(
        "${previousRoute?.settings.name} => ${route.settings.name}");
    LogControl.routeObserverLog(historyPage);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    history.remove(route);
    historyPage.remove(route.settings.name ?? "");

    ///logger
    LogControl.routeObserverAction(
        "${previousRoute?.settings.name} remove ${route.settings.name}");
    LogControl.routeObserverLog(historyPage);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      history.remove(oldRoute);
      historyPage.remove(oldRoute.settings.name ?? "");
    }
    if (newRoute != null) {
      history.add(newRoute);
      historyPage.add(newRoute.settings.name ?? "");
    }

    ///logger
    LogControl.routeObserverAction(
        "${oldRoute?.settings.name} replace ${newRoute?.settings.name}");
    LogControl.routeObserverLog(historyPage);
  }
}
