import 'dart:async';

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_attribution.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:adjust_sdk/adjust_event_failure.dart';
import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/mylib/app_other_plugin_manage.dart';

class AppAdjustManager {
  static AdjustAttribution? attributionChangedData; // adjust的归因数据
  static bool canUploadAdjust = false;
  static bool hadUploadAdjust = false;
  static Timer? _timer;
  static String id = AppConstants.adjustId;
  static String event = AppConstants.adjustEventKey;

  ///初始化
  static init() {
    if (GetPlatform.isAndroid) {
      AppAdjustManager.initAdjust();
    } else {
      AppAdjustManager.requestTracking();
    }
  }

  static initAdjust() {
    // 沙盒模式
    AdjustConfig config = AdjustConfig(
      id,
      kReleaseMode ? AdjustEnvironment.production : AdjustEnvironment.sandbox,
    );
    config.attributionCallback = (AdjustAttribution attributionChangedData) {
      // 每次安装有这个回调
      /* AppLog.debug('[Adjust]: Attribution changed!');
      if (attributionChangedData.adid != null) {
        AppLog.debug('[Adjust]: Adid: ' + attributionChangedData.adid!);
      }*/
      setAdjustInfo(attributionChangedData);
    };

    config.eventSuccessCallback = (AdjustEventSuccess eventSuccessData) {
      // AppLog.debug('[Adjust]: Event tracking success!');

      if (eventSuccessData.eventToken != null) {
        // AppLog.debug('[Adjust]: Event token: ' + eventSuccessData.eventToken!);
      }
      if (eventSuccessData.message != null) {
        // AppLog.debug('[Adjust]: Message: ' + eventSuccessData.message!);
      }
      if (eventSuccessData.timestamp != null) {
        // AppLog.debug('[Adjust]: Timestamp: ' + eventSuccessData.timestamp!);
      }
      if (eventSuccessData.adid != null) {
        //AppLog.debug('[Adjust]: Adid: ' + eventSuccessData.adid!);
      }
      if (eventSuccessData.callbackId != null) {
        // AppLog.debug('[Adjust]: Callback ID: ' + eventSuccessData.callbackId!);
      }
      if (eventSuccessData.jsonResponse != null) {
        /*    AppLog.debug(
            '[Adjust]: JSON response: ' + eventSuccessData.jsonResponse!);*/
      }
    };

    config.eventFailureCallback = (AdjustEventFailure eventFailureData) {
      // AppLog.debug('[Adjust]: Event tracking failure!');

      if (eventFailureData.eventToken != null) {
        //  AppLog.debug('[Adjust]: Event token: ' + eventFailureData.eventToken!);
      }
      if (eventFailureData.message != null) {
        //  AppLog.debug('[Adjust]: Message: ' + eventFailureData.message!);
      }
      if (eventFailureData.timestamp != null) {
        // AppLog.debug('[Adjust]: Timestamp: ' + eventFailureData.timestamp!);
      }
      if (eventFailureData.adid != null) {
        // AppLog.debug('[Adjust]: Adid: ' + eventFailureData.adid!);
      }
      if (eventFailureData.callbackId != null) {
        // AppLog.debug('[Adjust]: Callback ID: ' + eventFailureData.callbackId!);
      }
      if (eventFailureData.willRetry != null) {
/*        AppLog.debug(
            '[Adjust]: Will retry: ' + eventFailureData.willRetry.toString());*/
      }
      if (eventFailureData.jsonResponse != null) {
/*        AppLog.debug(
            '[Adjust]: JSON response: ' + eventFailureData.jsonResponse!);*/
      }
    };

    Adjust.start(config);
  }

  /// 获取Google的安装来源数据
  static getGoogleReferrer() async {
    if (AppConstants.isTestMode) {
      return;
    }
    var referrer = await AppOtherPluginManage.installReference();
    if (referrer == null || referrer.isEmpty) return;
    // 拿到Google的安装来源数据，如果是organic就不用管了
    if (referrer.contains('organic')) return;
    // 否则认为是广告的来源，调adjust的上传接口
    Http.instance.post<void>(NetPath.attributionData, errCallback: (e) {
      // AppLog.debug("upload adjust attribution  failed");
    }, data: {
      "trackerToken": "",
      "trackerName": "",
      "network": "googleplay",
      "campaign": "",
      "adgroup": "",
      "creative": "",
      "clickLabel": "",
      "adid": "",
      "costType": "",
      "costAmount": '',
      "costCurrency": "",
    });
  }

  // ios要的？
  static requestTracking() {
    // Ask for tracking consent.
    Adjust.requestTrackingAuthorizationWithCompletionHandler().then((status) {
      // AppLog.debug('[Adjust]: Authorization status update!');
      switch (status) {
        case 0:
          /*AppLog.debug(
              '[Adjust]: Authorization status update: ATTrackingManagerAuthorizationStatusNotDetermined');*/
          break;
        case 1:
          /*AppLog.debug(
              '[Adjust]: Authorization status update: ATTrackingManagerAuthorizationStatusRestricted');*/
          break;
        case 2:
          /*  AppLog.debug(
              '[Adjust]: Authorization status update: ATTrackingManagerAuthorizationStatusDenied');*/
          break;
        case 3:
          /* AppLog.debug(
              '[Adjust]: Authorization status update: ATTrackingManagerAuthorizationStatusAuthorized');*/
          break;
        default:
          break;
      }
    });
    initAdjust();
  }

  static checkAdjustUploadAttr() {
    if (attributionChangedData != null) {
      checkAdjustToUpload();
      return;
    }
    try {
      Adjust.getAttribution().then((value) => setAdjustInfo(value));
    } catch (e) {
      print(e);
    }
    // 开启个定时器检查
    _timer = Timer.periodic(const Duration(milliseconds: 20000), (timer) async {
      checkAdjustUploadAttr();
    });
  }

  // 归因数据
  static void setAdjustInfo(AdjustAttribution attr) {
    attributionChangedData = attr;
    checkAdjustToUpload();
  }

  // 在登录和有归因数据后，上传归因数据到后端
  // 尽量做到每次打开都上传一次
  static void checkAdjustToUpload() {
    if (UserInfo.to.myDetail == null) return;
    if (attributionChangedData == null) return;
    if (hadUploadAdjust) return;
    //AppLog.debug("upload adjust attribution");
    // 有上传了数据，但是network是空的情况, 不懂为啥，再次获取上传
    bool isNetworkNull = attributionChangedData?.network?.isNotEmpty != true;
    num cost = attributionChangedData!.costAmount ?? 0;
    if (cost.isNaN) {
      cost = 0;
    }
    Http.instance.post<void>(NetPath.attributionData, errCallback: (e) {
      // AppLog.debug("upload adjust attribution  failed");
    }, data: {
      "trackerToken": attributionChangedData!.trackerToken ?? "",
      "trackerName": attributionChangedData!.trackerName ?? "",
      "network": attributionChangedData!.network ?? "",
      "campaign": attributionChangedData!.campaign ?? "",
      "adgroup": attributionChangedData!.adgroup ?? "",
      "creative": attributionChangedData!.creative ?? "",
      "clickLabel": attributionChangedData!.clickLabel ?? "",
      "adid": attributionChangedData!.adid ?? "",
      "costType": attributionChangedData!.costType ?? "",
      "costAmount": cost,
      "costCurrency": attributionChangedData!.costCurrency ?? "",
    }).then((value) {
      if (!isNetworkNull) {
        hadUploadAdjust = true;
        _timer?.cancel();
        _timer == null;
      }
      // AppLog.debug("upload adjust attribution   success");
    });
  }

  //
  static trackEvent(
      {required num revenue, required String currency, String? orderNo}) {
    AdjustEvent adjustEvent = AdjustEvent(AppConstants.adjustEventKey);
    adjustEvent.setRevenue(revenue, currency);
    adjustEvent.transactionId = orderNo;
    Adjust.trackEvent(adjustEvent);
  }
}
