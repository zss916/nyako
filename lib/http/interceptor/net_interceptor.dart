import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:nyako/http/util/time_diff.dart';
import 'package:nyako/http/util/zip_utils.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/services/user_info.dart';

/// 请求拦截相关的处理
class NetInterceptor extends Interceptor {
  NetInterceptor();

  static int timeDiff = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppInfoService appInfo = AppInfoService.to;
    String userAgent =
        "${appInfo.channel},${appInfo.version},${appInfo.deviceModel},${appInfo.appSystemVersionKey},${appInfo.channelName},${appInfo.buildNumber}";
    options.headers["User-Agent"] = ZipUtil.zipStr(userAgent);
    options.headers["Authorization"] = UserInfo.to.authorization ?? "";
    options.headers["user-language"] = Get.deviceLocale?.languageCode ?? "en";
    options.headers["device-id"] = appInfo.deviceIdentifier;
    options.headers["time-difference"] = timeDiff.toString();
    options.headers["request-time"] =
        DateTime.now().millisecondsSinceEpoch.toString();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.ok) {
      timeDiff =
          TimeDiff.getDiffTime(response.headers.value("timestamp") ?? "0");
      response.data = ZipUtil.unZipStr(response.data);
    }
    handler.next(response);
  }
}
