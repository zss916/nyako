import 'package:nyako/http/config/base/page_entity.dart';

class BaseResponse<T> {
  int? code;

  T? data;

  String? message;

  PageEntity? page;

  num? timestamp;

  BaseResponse({this.code, this.data, this.message, this.page, this.timestamp});

  ///服务器请求成功
  bool get isSuccessful => code == 0;

  bool get isFail => code != 0;
}
