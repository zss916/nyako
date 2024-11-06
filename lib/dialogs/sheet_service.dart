import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/aihelp/ai_help.dart';
import 'package:nyako/utils/aihelp/ai_help_type.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void showServiceSheet() {
  String? whatsAppPath = UserInfo.to.config?.whatsapp;
  if (whatsAppPath == null) {
    AiHelp.instance.enterMinAIHelp(AiHelpType.userCenter.index);
  } else {
    Get.bottomSheet(
        Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20))),
            padding: const EdgeInsetsDirectional.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                whatsAppPath != null
                    ? GestureDetector(
                        onTap: () async {
                          final info = await PackageInfo.fromPlatform();

                          if (whatsAppPath != null) {
                            if (GetPlatform.isIOS) {
                              String url =
                                  "https://wa.me/${whatsAppPath}/?text=AppName:${info.appName},appVersion:${AppInfoService.to.version},System:iOS${AppInfoService.to.appSystemVersionKey},uid:${UserInfo.to.uid}";
                              if (await canLaunchUrl(Uri.parse(url))) {
                                launchUrl(Uri.parse(url));
                              }
                            } else if (GetPlatform.isAndroid) {
                              String url =
                                  "https://wa.me/${whatsAppPath}/?text=AppName:${info.appName},appVersion:${AppInfoService.to.version},System:Android${AppInfoService.to.appSystemVersionKey},uid:${UserInfo.to.uid}";

                              if (await canLaunchUrl(Uri.parse(url))) {
                                launchUrl(Uri.parse(url));
                              }
                            }
                          }

                          Get.back();
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.only(
                              top: 20, bottom: 10),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20),
                                  topEnd: Radius.circular(20))),
                          child: Text(
                            "WhatsApp:+$whatsAppPath",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        height: 10,
                        color: Colors.transparent,
                      ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    AiHelp.instance.enterMinAIHelp(AiHelpType.userCenter.index);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 20),
                    decoration: const BoxDecoration(),
                    child: Text(
                      Tr.app_mine_customer_service.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsetsDirectional.only(top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Text(
                      Tr.app_base_cancel.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            )),
        barrierColor: Colors.black26,
        settings: const RouteSettings(name: AppPages.aiHelpSheet));
  }
}
