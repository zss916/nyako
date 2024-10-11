part of 'index.dart';

abstract class ActivityAPI {
  static Future<AppRechargeActiveConfigEntity> getActiveConfig() async {
    final data = await Http.instance
        .post<AppRechargeActiveConfigEntity>(NetPath.getActiveConfig);
    return data;
  }
}
