// class AppThirdUtil {
//   static void askReview() {}
//
//   static void facebookLog(
//       double amount, String currency, Map<String, dynamic> map) {}
//
//   static void facebookSetAdvertiserTracking(bool enabled) {}
//
//   static Future<String> installReference() async {
//     return '';
//   }
// }

/// 这个注释上下是打包时要切换注释的，下面的是线上的

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class AppThirdUtil {
  static void askReview() {
    InAppReview.instance.requestReview();
  }

  static void facebookSetAdvertiserTracking(bool enabled) {}

  static void facebookLog(
      double money, String currency, Map<String, dynamic> map) {}

  static Future<String> installReference() async {
    ReferrerDetails referrerDetails;
    // 这个api在ios是不行的
    try {
      referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
    var referrer = referrerDetails.installReferrer;
    return referrer ?? '';
  }
}
