import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/app_click_widget.dart';

import '../common/language_key.dart';

///退出登录
void showLogoutDialog() {
  Get.dialog(
      AppDialogConfirm(
        title: Tr.app_login_logout.tr,
        h: 300,
        showIcon: true,
        callback: (i) {
          UserInfo.to.toSetLogOut();
        },
      ),
      routeSettings: const RouteSettings(name: AppPages.logoutDialog));
}

class AppDialogConfirm extends StatelessWidget {
  AppCallback<int> callback;
  String title;
  String? content;
  bool onlyConfirm;
  bool showIcon;
  double? h;
  String? avatar;

  AppDialogConfirm(
      {super.key,
      required this.callback,
      required this.title,
      this.content,
      this.onlyConfirm = false,
      this.showIcon = true,
      this.h,
      this.avatar});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: h ?? Get.height / 2,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.dialogBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  Assets.imgAppLogo,
                  matchTextDirection: true,
                  height: 50,
                  width: 50,
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (avatar != null)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  child: CachedNetworkImage(
                      imageUrl: avatar ?? "",
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover,
                      placeholder: (
                        BuildContext context,
                        String url,
                      ) =>
                          Image.asset(
                            Assets.imgAppLogo,
                            matchTextDirection: true,
                            height: 65,
                            width: 65,
                          )),
                ),
              ),
            if (content != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: AutoSizeText(
                  content ?? '',
                  maxFontSize: 14,
                  minFontSize: 7,
                  maxLines: 4,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              const Spacer(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                AppClickWidget(
                  type: AppClickType.debounce,
                  onTap: () {
                    Get.back();
                    callback.call(1);
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 2, color: const Color(0xFFAC53FB)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      Tr.app_base_confirm.tr,
                      style: const TextStyle(
                          color: Color(0xFFAC53FB),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (!onlyConfirm)
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 54,
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 30, end: 30),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          gradient: AppColors.btnGradient,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        Tr.app_base_cancel.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
