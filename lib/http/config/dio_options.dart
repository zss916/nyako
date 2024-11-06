import 'package:dio/dio.dart';
import 'package:nyako/http/index.dart';

// BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
BaseOptions baseOptions = BaseOptions(
  // 请求基地址,可以包含子路径
  baseUrl: NetPath.baseUrl,

  // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
  //连接服务器超时时间，单位是毫秒.
  connectTimeout: const Duration(seconds: 30),

  // 响应流上前后两次接受到数据的间隔，单位为毫秒。
  receiveTimeout: const Duration(seconds: 30),

  // Http请求头.
  headers: {},
  contentType: 'application/json; charset=utf-8',

  //ResponseTyp,默认是json,返回值用String
  responseType: ResponseType.json,

  //用stream ,只有get请求可以使用 Response<T> = get<T>()
  //responseType: ResponseType.stream
);
