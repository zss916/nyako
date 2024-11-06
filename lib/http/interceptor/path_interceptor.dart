import 'package:dio/dio.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/http/util/special_path_utils.dart';

/// 请求拦截path相关的处理
class PathInterceptor extends Interceptor {
  PathInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String path = options.path;
    bool isSpecial = PathUtils.isSpecial(path);
    String root = isSpecial ? NetPath.getConfigBaseUrl() : NetPath.getBaseUrl();
    options.baseUrl = root;
    handler.next(options);
  }
}
