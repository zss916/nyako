import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/http/interceptor/net_interceptor.dart';
import 'package:oliapro/http/util/encrypt_utils.dart';
import 'package:oliapro/http/util/zip_utils.dart';

class QueryData {
  ///请求数据处理
  static String hand(String path, dynamic data) {
    var paraFinal = {
      "method": path,
      "timestamp":
          DateTime.now().millisecondsSinceEpoch + NetInterceptor.timeDiff,
      "nonceStr": DateTime.now().microsecondsSinceEpoch,
    };
    if (data != null) {
      paraFinal["param"] = data;
    }

    if (AppConstants.showLogger) {
      debugPrint("path:$path \n param:$paraFinal");
    }
    var json = const JsonEncoder().convert(paraFinal);
    var sendPara = EncryptUtils.encodeData(ZipUtil.zipStr(json));
    return sendPara;
  }
}
