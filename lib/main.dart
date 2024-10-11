import 'package:flutter/material.dart';
import 'package:oliapro/app/app.dart';
import 'package:oliapro/utils/global.dart';

void main() async {
  /*FlutterError.onError = (FlutterErrorDetails details) {
    // 在此处处理错误，例如将错误日志发送到远程服务器或显示错误信息给用户
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace:\n${details.stack}');
  };*/

  await AppGlobal.init();
  runApp(const App());
}

/*Future<void> main() async {
  await AppGlobal.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7dd5f5e5299c07d195d38a6ea9ff389c@o4507456097878016.ingest.us.sentry.io/4507616320815104';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const App()),
  );
}*/
