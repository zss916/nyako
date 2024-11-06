import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nyako/http/config/response_data.dart';
import 'package:nyako/http/util/special_path_utils.dart';

/// data拦截相关的处理
class DataInterceptor extends Interceptor {
  DataInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.ok) {
      var entity = const JsonDecoder().convert(response.data.toString());
      String path = response.realUri.path;
      if (PathUtils.isConfigV2(path)) {
        String jsonData = ResponseData.handConfigV2(path, entity["data"]);
        var jsonMap = const JsonDecoder().convert(jsonData);
        entity["data"] = jsonMap;
        response.data = jsonEncode(entity);
      }
      handler.next(response);
    } else {
      handler.next(response);
    }
  }
}
