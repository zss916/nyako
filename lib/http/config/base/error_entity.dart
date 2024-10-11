
// 异常处理
class AppErrorEntity implements Exception {
  int code = -1;
  String message = "";

  AppErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}