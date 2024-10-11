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
            height: Get.width * 2 / 3,
            padding: const EdgeInsetsDirectional.only(top: 0),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Color(0xFF201436),
                      Color(0xFF0C0C32),
                    ]),
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
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
                          color: Colors.white,
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
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 8,
                  color: const Color(0xDF6F8FC),
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
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
