import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_type.dart';
import 'package:nyako/dialogs/dialog_confirm.dart';
import 'package:nyako/routes/app_pages.dart';

void showUpdateAppDialog(
    {String? title, String? content, AppCallback<int>? callback}) {
  Get.dialog(
      AppDialogConfirm(
        callback: (i) {
          callback?.call(i);
        },
        title: title ?? "",
        content: content ?? '',
      ),
      routeSettings: const RouteSettings(name: AppPages.appUpdateDialog));
}
