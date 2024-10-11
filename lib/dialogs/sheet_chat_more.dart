import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/app_pages.dart';

void showChatMore(
    {Function? report,
    Function? black,
    Function? follow,
    Function? clean,
    bool? isToFollow,
    double? h}) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: Container(
            width: Get.width,
            margin: const EdgeInsetsDirectional.only(top: 0),
            decoration: const BoxDecoration(
                color: AppColors.splashBg,
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                    report?.call();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 5),
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    /*decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFA056FF),
                    Color(0xFF8525FF),
                  ]),
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),*/
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: Image.asset(A.assets_img_report),),*/
                        Text(
                          Tr.app_report_title.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                    black?.call();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 5),
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    /* decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFFF7AC2),
                      Color(0xFFFF43A9),
                    ]),
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),*/
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: Image.asset(A.assets_img_black),),*/
                        Text(
                          Tr.app_setting_black_list.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                    clean?.call();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 5),
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    /*decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFA056FF),
                    Color(0xFF8525FF),
                  ]),
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),*/
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: Image.asset(A.assets_img_report),),*/
                        Text(
                          Tr.app_dialog_clear_message_record.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                    follow?.call();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 5),
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    /*decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFA056FF),
                    Color(0xFF8525FF),
                  ]),
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),*/
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(
                    margin: const EdgeInsetsDirectional.only(end: 5),
                    child: Image.asset(A.assets_img_report),),*/
                        Text(
                          isToFollow == true
                              ? Tr.app_create_follow.tr
                              : Tr.app_create_cancel_follow.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white10,
                  width: double.maxFinite,
                  height: 5,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
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
                    /* decoration: const BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),*/
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
      settings: const RouteSettings(name: AppPages.chatMoreSheet));
}