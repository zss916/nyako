import 'dart:convert';

import 'package:oliapro/database/entity/app_order_entity.dart';
import 'package:oliapro/entities/app_config_entity.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/adjust/app_adjust.dart';

class AppPayEventTrack {
  factory AppPayEventTrack() => _getInstance();

  static AppPayEventTrack get instance => _getInstance();

  static AppPayEventTrack? _instance;

  AppPayEventTrack._internal();
  static AppPayEventTrack _getInstance() {
    _instance ??= AppPayEventTrack._internal();
    return _instance!;
  }

  void trackPay(OrderEntity order) {
    double fbScale = 0.5;
    double adScale = 0.5;
    if (UserInfo.to.config?.payScale?.isNotEmpty == true) {
      PayScale? payScale;
      try {
        payScale =
            PayScale.fromJson(json.decode(UserInfo.to.config!.payScale!));
      } catch (e) {
        print(e);
      }
      if (payScale != null) {
        fbScale = payScale.facebookScale ?? 0.5;
        adScale = payScale.adjustScale ?? 0.5;
      }
    }
    //AppLog.debug("trackPay order=${order.price} ${order.currency} ${order.orderNo}");
    double price = double.parse(order.price ?? "0") / 100; // yuan
    // double scale = double.parse(UserInfo.to.config?.scale ?? "1");
    // double money = price * scale;

    String currency = order.currency ?? "USD";
    if (currency == "USD" && price > 1000) {
      // 肯定是搞错了
      return;
    }
    var stopFbPurchase = UserInfo.to.config?.stopFbPurchase ?? false;
    if (!stopFbPurchase) {
      // facebook
      Map<String, dynamic> map = {};
      map["fb_currency"] = currency;
      // 这里有个坑，传null进去会导致上传失败
      map["fb_content_type"] = order.payType ?? 1;
      map["fb_content_id"] = order.productId ?? "1";
      // map["fb_search_string"] = order.orderNo ?? "1";
      map["fb_search_string"] =
          "${order.orderNo ?? "1"},${order.productId ?? "1"},${order.payType ?? 1}";
      //AppOtherPluginManage.facebookLog(price * fbScale, currency, map);
    }

    // adjust
    AppAdjust.instance.trackEvent(
        revenue: (price * adScale), currency: currency, orderNo: order.orderNo);
  }
}
