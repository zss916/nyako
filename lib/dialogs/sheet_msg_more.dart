import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/app_pages.dart';

void showMsgMoreSheet(Function allRead, Function allClear) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: Container(
            width: Get.width,
            height: 240,
            padding: const EdgeInsetsDirectional.only(top: 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(24),
                    topEnd: Radius.circular(24))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    allRead.call();
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 10),
                    padding:
                        const EdgeInsetsDirectional.only(top: 15, bottom: 15),
                    child: Text(
                      Tr.app_dialog_clear_message_unread.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    allClear.call();
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 10),
                    padding:
                        const EdgeInsetsDirectional.only(top: 15, bottom: 15),
                    child: Text(
                      Tr.app_dialog_clear_message_all_session.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 5,
                  color: const Color(0xFFEEEEEE),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 10),
                    padding:
                        const EdgeInsetsDirectional.only(top: 15, bottom: 15),
                    child: Text(
                      Tr.app_base_cancel.tr,
                      style: const TextStyle(
                          color: Color(0xFF9B989D),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )),
        onBack: () => Get.back(),
      ),
      barrierColor: Colors.black38,
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.msgMoreSheet));
}
