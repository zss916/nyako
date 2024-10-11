import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/routes/app_pages.dart';

import '../common/language_key.dart';

void showDeleteAccount() {
  Get.dialog(
      AppDialogDeleteAccount(
        title: Tr.app_account_delete_title.tr,
        content: Tr.app_account_delete_content.tr,
        h: 550,
        callback: (i) {
          AccountAPI.deleteAccount()
              .whenComplete(() => AppPages.toDeleteAccount());
        },
      ),
      barrierColor: Colors.black54,
      routeSettings: const RouteSettings(name: AppPages.deleteAccountDialog));
}

class AppDialogDeleteAccount extends StatelessWidget {
  final AppCallback<int> callback;
  final String title;
  final String content;
  final double? h;

  const AppDialogDeleteAccount({
    Key? key,
    required this.callback,
    required this.title,
    required this.content,
    this.h,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsetsDirectional.only(top: 0, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
              child: Image.asset(
                Assets.iconWarming,
                width: 60,
                height: 60,
                matchTextDirection: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                title,
                softWrap: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: AutoSizeText(
                content,
                softWrap: true,
                maxLines: 4,
                maxFontSize: 15,
                minFontSize: 7,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xFFFF4864),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 52,
                alignment: Alignment.center,
                margin: const EdgeInsetsDirectional.only(
                    top: 20, start: 20, end: 20),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xFF9341FF),
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: Text(
                  Tr.app_base_cancel.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 10, start: 20, end: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.back();
                    callback.call(1);
                  },
                  child: UnconstrainedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadiusDirectional.circular(30),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Text(
                        Tr.app_base_confirm.tr,
                        style: const TextStyle(
                            color: Color(0xFF9B989D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
