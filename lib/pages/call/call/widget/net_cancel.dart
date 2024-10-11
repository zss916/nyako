import 'package:dio/dio.dart';
import 'package:get/get.dart';

mixin CancelableMixin on GetxController {
  final CancelToken _cancelToken = CancelToken();

  final CancelToken _cancelTokenR = CancelToken();

  CancelToken get cancelToken => _cancelToken;

  CancelToken get cancelTokenR => _cancelTokenR;

  @override
  void onClose() {
    _cancelToken.cancel("cancel");
    _cancelTokenR.cancel("close cancel");
    super.onClose();
  }
}
