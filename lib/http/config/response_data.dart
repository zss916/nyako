import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/http/util/aes_utils.dart';
import 'package:nyako/services/app_info_service.dart';

class ResponseData {
  ///请求数据处理configV2
  static String handConfigV2(String path, String data) {
    String decodeData =
        AESUtils.decode(appChannel: AppInfoService.to.channelName, data: data);
    if (AppConstants.showLogger) {
      debugPrint("path:$path \n data:$decodeData");
    }
    return decodeData;
  }
}
