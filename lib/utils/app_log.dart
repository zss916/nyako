import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLog {
  ///是否是release
  static bool isOpen = kDebugMode;

  static Logger? _instance;

  static Logger get _logger => _instance ??= Logger(
        printer: PrettyPrinter(
          stackTraceBeginIndex: 2,
          methodCount: 3,
          errorMethodCount: 8,
        ),
        output: ConsoleOutput(),
      );

  static void d(Object message, {String? name, bool isLog = true}) {
    if (isOpen) {
      _logger.d(message);
    }
  }

  static void e(Object message) {
    if (isOpen) {
      _logger.e(message);
    }
  }
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(printWrapped);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }
}
