import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:url_launcher/url_launcher.dart';

///邀请好友
void sheetToInvite(String url) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: Container(
          height: 180,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          padding:
              const EdgeInsets.only(top: 23, left: 25, right: 25, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  shareWhatsApp(url);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconWhatApp,
                      width: 60,
                      height: 60,
                      matchTextDirection: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "WhatsApp",
                      style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Clipboard.setData(ClipboardData(text: url));
                  AppLoading.toast(Tr.app_base_success.tr);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconCopyLink,
                      width: 60,
                      height: 60,
                      matchTextDirection: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      Tr.app_copy_link.tr,
                      style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 12,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onBack: () => Get.back(),
      ),
      settings: const RouteSettings(name: AppPages.toInviteSheet),
      isScrollControlled: true);
}

///分享到whatsApp
void shareWhatsApp(String shareWebLink) async {
  String url = "whatsapp://send?text=$shareWebLink";
  if (await canLaunchUrl(Uri.parse(url))) {
    launchUrl(Uri.parse(url));
    Get.back();
  } else {
    //没有安装 whatsApp 提示安装
    AppLoading.toast(Tr.app_install_whatsApp.tr);
  }
}
