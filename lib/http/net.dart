part of 'index.dart';

typedef AppHttpErrCallback = void Function(AppErrorEntity err);
typedef AppHttpDoneCallback = void Function(bool success, String msg);

class Http {
  static final Http _instance = Http._internal();
  static Http get instance => Http();
  factory Http() => _instance;

  late Dio _dio;
  CancelToken cancelToken = CancelToken();

  Http._internal() {
    _dio = Dio(baseOptions);
    _dio.httpClientAdapter = httpAdapter;
    _dio.interceptors.add(NetInterceptor());
    _dio.interceptors.add(PathInterceptor());
    _dio.interceptors.add(DataInterceptor());
    // _dio.interceptors.add(HandDataInterceptor());
    if (AppConstants.showLogger) {
      _dio.interceptors.add(pLogger);
    }
  }

  ///取消请求
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    AppHttpErrCallback? errCallback,
    AppHttpDoneCallback? doneCallback,
    bool showLoading = false,
    bool showToast = true,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    dio_response.Response<String> response;
    if (showLoading) AppLoading.show();

    try {
      // debugPrint("onRequest:$path");
      response = await _dio.post(
        PathUtils.isSpecial(path) ? path : "",
        data: PathUtils.isSpecial(path) ? null : QueryData.hand(path, data),
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          // SplashLog.log(" onReceiveProgress :${count / total}");
        },
        onSendProgress: (int count, int total) {
          //SplashLog.log(" onSendProgress :${count / total}");
        },
      );
    } catch (e) {
      AppErrorEntity err;
      if (e is AppErrorEntity) {
        err = e;
      } else if (e is DioException) {
        err = AppErrorEntity(code: -4, message: e.message ?? "unknown");
      } else {
        err = AppErrorEntity(code: -3, message: "try catch err");
      }
      if (errCallback == null) {
        AppLoading.toast(err.message);
      } else {
        errCallback.call(err);
      }
      doneCallback?.call(false, err.message);
      return Future.error(e);
    } finally {
      if (showLoading) AppLoading.dismiss();
    }

    var baseEntity = const JsonDecoder().convert(response.data ?? '{}');
    var result = baseEntity["data"];
    //debugPrint("baseEntity => ${baseEntity}");

    if (baseEntity == null) {
      if (errCallback == null) {
        AppLoading.toast("baseEntity is null");
      } else {
        errCallback
            .call(AppErrorEntity(code: -3, message: "baseEntity is null"));
      }
      doneCallback?.call(false, "baseEntity is null");
      return Future.error("baseEntity err :${path}，data:${response.data}");
    }

    /// 返回的data里面code不是0，需要处理
    var code = baseEntity["code"];
    if (code != 0) {
      if (errCallback == null) {
        if (code == 8) {
          AppLoading.toast("${baseEntity["message"]}");
        } else if (code == 2) {
          debugPrint("logout=>netLogOut$path");
          UserInfo.to.netLogOut();
        } else {
          if (showToast) AppLoading.toast("${code}] ${baseEntity["message"]}");
        }
      } else {
        errCallback
            .call(AppErrorEntity(code: code, message: baseEntity["message"]));
      }
      doneCallback?.call(false, "[$code] ${baseEntity["message"]}");
      return Future.error("baseEntity err");
    }

    doneCallback?.call(true, "");
    // 泛型用void,直接返回null
    if (T.toString() == 'void') {
      return null as T;
    }
    var serverData = baseEntity["data"];

    if (serverData == null) {
      return Future.error(0);
    }

    /// code=0而data不是map和list,不用fromJson
    if (serverData is! Map<String, dynamic> && serverData is! List<dynamic>) {
      return serverData as T;
    }

    return JsonConvert.fromJsonAsT<T>(result)!;
  }
}
