import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/routes/app_pages.dart';

///礼物列表弹窗
void showGiftListSheet({required Widget child}) {
  Get.bottomSheet(child,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      settings: const RouteSettings(name: AppPages.giftBottomSheet));
}
