import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///debug 模式 日志显示
PrettyDioLogger pLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true);

///dio 自带 logger
LogInterceptor logger = LogInterceptor(
  requestBody: true,
  responseBody: true,
);
