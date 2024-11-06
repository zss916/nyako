import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nyako/http/config/code_status.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/services/user_info.dart';

/// data拦截相关的处理
class HandDataInterceptor extends Interceptor {
  HandDataInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.ok) {
      ///接口层
      ///AppConstants.showLogger
      var entity = const JsonDecoder().convert(response.data.toString());

      if (entity is Map<String, dynamic>) {
        /// 业务逻辑
        int code = entity["code"];
        dynamic data = entity["data"];

        if (code != 0) {
          ///解决完成请求
          switch (CodeStatus.getStatus(code)) {
            case CodeStatus.tokenLose:

              ///结束请求
              UserInfo.to.reLogin();
              handler.resolve(response);
              break;
            case CodeStatus.balanceLack:
              handler.next(response);
              break;
            default:
              handler.next(response);
              break;
          }
        } else {
          if (data == null) {
            if (response.realUri.path == NetPath.bannerApi) {
              response.data =
                  toJsonStr(code: 0, msg: "data list empty", data: []);
            } else {
              response.data = toJsonStr(code: 0, msg: "data empty", data: {});
            }
            handler.next(response);
          } else {
            //code = 0,data is not null
            handler.next(response);
          }
        }
      } else {
        ///向下传递，返回 String，int
        response.data = toJsonStr(code: 100, msg: "--", data: entity);
        handler.next(response);
      }
    } else {
      ///请求错误
      response.data = toJsonStr(
          code: -1001,
          msg: "${response.statusCode},${response.statusMessage}",
          data: {});
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //debugPrint("网关层失败: ${err.message ?? "-----"}");
    return handler.next(err);
  }

  ///统一数据格式
  String toJsonStr({int? code, String? msg, dynamic data}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code ?? -1;
    data["message"] = msg ?? "";
    data["data"] = data;
    return jsonEncode(data);
  }

  ///统一数据格式
  ///https://blog.csdn.net/mzxj7255/article/details/128019688
}
