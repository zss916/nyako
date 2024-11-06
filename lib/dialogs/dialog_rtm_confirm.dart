import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_type.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/widget/app_click_widget.dart';

import '../common/language_key.dart';

void showRtmConfirmDialog({String? title, Function? fun}) {
  Get.dialog(
          AppDialogRtmConfirm(
            callback: (int callback) {},
            title: title ?? Tr.app_video_hang_up_tip.tr,
          ),
          routeSettings: const RouteSettings(name: AppPages.rtmConfirmDialog))
      .then((value) {
    fun?.call();
  });
}

class AppDialogRtmConfirm extends StatelessWidget {
  final AppCallback<int> callback;
  final String title;

  const AppDialogRtmConfirm(
      {super.key, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 15,
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
                    decoration: const BoxDecoration(
                        color: Color(0xFF9341FF),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      Tr.app_base_confirm.tr,
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
