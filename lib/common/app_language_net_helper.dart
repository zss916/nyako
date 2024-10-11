import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/entities/app_translate_entity.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/services/app_info_service.dart';
import 'package:oliapro/services/storage_service.dart';

class AppLanguageNetHelper {
  // 获取已经下载的翻译的版本
  static const downloadLangVersionKey = 'downloadLangVersionKey';

  // 获取已经下载的翻译
  static const downloadLangKey = 'downloadLangKey';

  //请求接口 返回支持的 languagecode 以及 翻译json文件
  static handleLanguageJsonV2() {
    Http.instance
        .post<TranslateData>(NetPath.getTransationsV2Api)
        .then((value) {
      String languageurl = value.configUrl!;
      int configVersion = value.configVersion ?? 0;

      final downloadVersion =
          StorageService.to.prefs.getInt(downloadLangVersionKey) ?? -1;
      if (configVersion > downloadVersion) {
        // 有新版本就下载
        _downLoadLanguageStr(languageurl, value.appNumber!).then((downLoad) {
          if (downLoad != null) {
            StorageService.to.prefs
                .setInt(downloadLangVersionKey, configVersion);
            StorageService.to.prefs.setString(downloadLangKey, downLoad);
            _useLanguage(downLoad, value.appNumber!);
          }
        });
      } else {
        // 没有新版本用下载好的
        final data = StorageService.to.prefs.getString(downloadLangKey);
        if (data != null) {
          _useLanguage(data, value.appNumber!);
        }
      }
    });
  }

  //更新语言
  static _updateLanguage(Map<String, String> map) {
    // 判断下发的json文件是否完整对应本地翻译条数
    // map.length > 377
    if (map.keys.length > 0) {
      String languageCode = Get.deviceLocale?.languageCode ?? "en";
      var oldMap = Get.translations[languageCode];
      //CrLiveLog.debug("updateLanguage languageCode = $languageCode");
      //CrLiveLog.debug("updateLanguage map = ${map['crlive_login_terms_service']}");

      // Map<String, String> translation = Map<String, String>.from(map);
      var newMap = <String, String>{};
      if (oldMap != null && oldMap.isNotEmpty) {
        /* CrLiveLog.debug(
            "updateLanguage oldMap = ${oldMap['crlive_login_terms_service']}");*/
        newMap.addAll(oldMap);
        map.forEach((key, value) {
          newMap[key] = value;
        });
      } else {
        newMap.addAll(map);
      }
      /*CrLiveLog.debug(
          "updateLanguage map->${map.length} newMap->${newMap.length}");*/
      Get.addTranslations({languageCode: newMap});
      Get.updateLocale(Locale(languageCode));
    }
  }

  // 下载
  static Future<String?> _downLoadLanguageStr(String url, int appNumber) async {
    // CrLiveLog.debug("updateLanguage languageurl= $url");
    final dio = Dio();
    final response = await dio.get<String>(url);
    dio.close();
    return response.data;
  }

  // 把加密数据解密出来并转化成map
  static _useLanguage(String lang, int appNumber) async {
    final Map<String, String> map = {};
    String appChannel = AppInfoService.to.channelName;
    String appName = AppConstants.channelName;
    String hex = '0123456789ABCDEF';
    // 1 Android 0 ios
    int appSystem = GetPlatform.isAndroid ? 1 : 0;
    map['keyGroup'] = '$appChannel$appName$appNumber$appSystem$hex';
    map['ivGroup'] = '$appNumber$appSystem$appChannel$appName$hex';
    map['str'] = lang;
    // 解密有500ms,用子线程解密
    final jsonStr = await compute(aesDecode, map);
    var dataList = json.decode(jsonStr);
    if (dataList is List) {
      Map<String, String> map = {};
      for (var element in dataList) {
        if (element is Map) {
          if (element.containsKey("configKey")) {
            // map.addAll(
            //     {element["configKey"]: element["configValue"]});
            map[element["configKey"]] = element["configValue"] ?? "";
          }
        }
      }
      AppLanguageNetHelper._updateLanguage(map);
    }
  }
}

// aes解密，这是个全局方法，因为要放子线程计算
String aesDecode(Map<String, String> map) {
  // key
  String keyStr =
      base64.encode(utf8.encode(map['keyGroup'] ?? '')).substring(0, 32);
  // iv
  String ivStr =
      base64.encode(utf8.encode(map['ivGroup'] ?? '')).substring(0, 16);
  final key = encrypt.Key.fromUtf8(keyStr);
  final iv = encrypt.IV.fromUtf8(ivStr);

  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  // 解密
  final decrypted =
      encrypter.decrypt(encrypt.Encrypted.fromBase64(map['str'] ?? ''), iv: iv);
  return decrypted;
}
