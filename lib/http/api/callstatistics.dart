part of 'index.dart';

abstract class CallStatisticsAPI {
  // raiseType 0.正常唤起 1.AI唤起
  // statisticsType 1 呼叫失败 2 客户端忙线 3 用户被叫拒绝 4 用户被叫超时
  // 5 用户余额不足 6 用户被叫对方取消 7 用户连接异常
  static Future update(
      {required int isAib, required int statisticsType}) async {
    await Http.instance.post<void>(
      '${NetPath.appCallStatistics}/$isAib/$statisticsType',
    );
  }
}
