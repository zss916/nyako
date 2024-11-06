import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:nyako/http/adapter/httpClientAdapter.dart';
import 'package:nyako/utils/app_loading.dart';

const String nidValue =
    "511=dgzX6mucCfQlVGBI3uCc9PGAO2-WFw712QqFreXeJwguxX-LpmqXJ68KUx_bQp8BFzdKobobfhYAUIIcvSDMKmTTleXJxgwTbFchghGhGH5KGwDGxAtKEEf3r8VK_sKlmlce-DtC1RuH5lY2iv5Nc77oWeWxwCdeXktCnMM6hnlBqU6Vgrs3j_L-GLEIBUML-enls1PKIMiy3wEOehdVl8jzX-6pM0jA8pf6MVXFGoF59AM198jHQUpWbdrE1nR35y2WxKokEW5yy07EWUnxs4K7da3pUBIWBiZvGQhkdvcuLaPoSCdlz-y_Llht4Ps5xpnHL1S7QaY";

const String userAgentValue =
    "Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0";

typedef TranslateHttpDoneCallback = void Function(
    bool success, String translateMsg, String languageCode);

class TranslateHttpUtil {
  static final TranslateHttpUtil _instance = TranslateHttpUtil._internal();
  factory TranslateHttpUtil() => _instance;
  late Dio _dio;
  TranslateHttpUtil._internal() {
    BaseOptions options = BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: "https://www.google.com",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(microseconds: 20000),
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: const Duration(microseconds: 30000),
      // Http请求头.
      headers: {},
      contentType: 'application/x-www-form-urlencoded',
      responseType: ResponseType.plain,
    );
    _dio = Dio(options);
    _dio.httpClientAdapter = httpAdapter;
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers["Cookie"] = '1P_JAR=2023-12-26-12; NID=$nidValue';
        options.headers["User-Agent"] = userAgentValue;
        options.headers["content-Type"] = 'application/x-www-form-urlencoded';
        // AppLog.debug('Headers====${options.headers}');
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        if (response.statusCode == 200) {}
        // Do something with response data
        return handler.next(response); // continue
        // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      },
      onError: (DioException e, handler) {
        // Do something with response error
        AppLoading.dismiss();
        return handler.next(e); //continue
      },
    ));
  }

  /// restful post 操作
  Future<List<String>> post<T>({
    required String data,
    required String language,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Function? errCallback,
    TranslateHttpDoneCallback? doneCallback,
    bool showLoading = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    _dio.options.baseUrl = "https://www.google.com";
    dio_response.Response<String> response;
    if (showLoading) AppLoading.show();
    //AppLog.longLog('请求翻译的数据：${Uri.encodeComponent(data)}  包含逗号：${data.contains(',')}  翻译的语言 ：$language ');
    try {
      response = await _dio.post(
        "/async" + "/translate",
        // data: data,
        data:
            'async=translate,sl:,tl:$language,st:${Uri.encodeComponent(data)},id:1672056488960,qc:true,ac:true,_id:tw-async-translate,_pms:s,_fmt:pc',
        queryParameters: queryParameters,
        options: requestOptions,
        // cancelToken: cancelToken,
      );
      //AppLog.longLog(response.data);
      String content = findStringBetweenAAndB(
          response.data ?? '', 'id="tw-answ-target-text">', '</span');
      String languageCode = findStringBetweenAAndB(
          response.data ?? '', 'id="tw-answ-detected-sl">', '</span');
      //AppLog.longLog('翻译解析后的数据====$content  检测到的语言:$languageCode');
      doneCallback?.call(content.isNotEmpty, content, languageCode);
      return [content, languageCode];
    } catch (e) {
      // print("翻译请求异常--${e.toString()}");
      errCallback?.call();
      // return Future.error('');
    } finally {
      if (showLoading) AppLoading.dismiss();
    }
    return ['', ''];
  }

  String findStringBetweenAAndB(String str, String startStr, String endStr) {
    if (str.isEmpty || startStr.isEmpty || endStr.isEmpty) return '';
    int startIndex = str.indexOf(startStr) + startStr.length;
    int endIndex = str.indexOf(endStr, startIndex);
    String result = str.substring(startIndex, endIndex);
    return result;
  }
}
