import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/dialogs/dialog_confirm.dart';
import 'package:oliapro/routes/app_pages.dart';

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
