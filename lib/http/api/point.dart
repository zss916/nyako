part of 'index.dart';

///埋点
abstract class PointAPI {
  /* Map<String, dynamic> map = {
    "probeType": 0,
    "probeId": 0,
    "probeTime": 0,
    "remark": "",
  };*/
  /// <dynmic> 不触发返回，<void> 触发返回
  static Future<void> toPoint({required String data}) async {
    return await Http.instance.post<void>(NetPath.point, data: data);
  }
}
