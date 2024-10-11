class TimeDiff {
  static int getDiffTime(String source) {
    int timestamp = int.parse(source);
    // 手机系统的时间
    int now = DateTime.now().millisecondsSinceEpoch;
    // 计算差值，用于下次请求计算
    int timeDiff = timestamp == 0 ? 0 : timestamp - now;
    return timeDiff;
  }
}
