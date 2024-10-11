import 'package:oliapro/utils/app_log.dart';

class LogControl {
  ///路由路径监测
  static routeObserverLog(dynamic data) {
    AppLog.d("RouteObserver:  history: $data");
  }

  ///路由action
  static routeObserverAction(dynamic data) {
    AppLog.d("RouteObserver:  action: $data");
  }
}
