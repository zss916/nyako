import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:nyako/dialogs/dialog_update_app.dart';
import 'package:nyako/entities/app_config_entity.dart';
import 'package:nyako/services/user_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/app_info_service.dart';

class CheckAppUpdate {
  static void check() async {
    final str = UserInfo.to.config?.appUpdate ?? '';
    if (str.isEmpty) return;
    AppUpdate? update;
    try {
      update = AppUpdate.fromJson(json.decode(str));
    } catch (e) {
      debugPrint(e.toString());
    }
    if (update == null) return;
    //AppLog.debug(update.content ?? 'aa');
    if (update.isShow != true || update.url == null) return;
    showUpdateAppDialog(
        title: update.title ?? '',
        content: update.content ?? '',
        callback: (i) {
          _handle(update!.url!, update.type!);
        });
  }

  // 1 google, 2 url
  static void _handle(String url, int type) async {
    if (url.contains("/#") == true) {
      //不做操作
      return;
    }

    //跳转网页
    if (type == 2) {
      if (await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url));
      }
    } else if (type == 1) {
      if (url.contains("/feedback") == true) {
      } else if (url.contains("/whatsApp=") == true) {
        //  打开whatsapp
        String? whatsAppId = url.split("=").last;
        if (whatsAppId != null) {
          final info = await PackageInfo.fromPlatform();
          var appVersion = AppInfoService.to.version;
          var appSystemVersionKey = AppInfoService.to.appSystemVersionKey;
          var myId = UserInfo.to.userLogin?.username ?? "unkown";
          String url =
              "https://wa.me/$whatsAppId/?text=AppName:${info.appName},appVersion:${appVersion},"
              "System:${GetPlatform.isIOS ? 'iOS' : 'Android'}$appSystemVersionKey,uid:$myId}";
          if (await canLaunchUrl(Uri.parse(url))) {
            launchUrl(Uri.parse(url));
          }
        }
      } else if (url.contains("play.google.com") == true) {
        //打开google play
        String? packageName = url.split("=").last;
        LaunchReview.launch(androidAppId: packageName);
      }
    }
  }
}
