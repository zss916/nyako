import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_type.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/base_button.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/storage_service.dart';

void showBlackDialog({HostDetail? host, AppCallback<int>? callback}) {
  Get.dialog(
      AppDialogConfirmBlack(host, (i) {
        callback?.call(i);
      }),
      routeSettings: const RouteSettings(name: AppPages.blackDialog));
}

class AppDialogConfirmBlack extends StatelessWidget {
  final HostDetail? detail;
  final AppCallback<int> callback;

  const AppDialogConfirmBlack(this.detail, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    bool black = StorageService.to.checkBlackList(detail?.userId);
    String title =
        black ? Tr.app_dialog_remove_black.tr : Tr.app_dialog_add_black.tr;
    String str =
        black ? Tr.app_dialog_remove_black.tr : Tr.app_black_content.tr;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 390,
          margin:
              const EdgeInsetsDirectional.only(start: 30, end: 30, bottom: 0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(top: 0),
                padding: const EdgeInsetsDirectional.only(
                    bottom: 20, start: 20, end: 20, top: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsetsDirectional.all(10),
                      child: Image.asset(
                        Assets.iconWarming,
                        width: 60,
                        height: 60,
                        matchTextDirection: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.only(start: 15, end: 15),
                      child: Text(
                        str,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFF9B989D),
                            fontSize: 15,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.back(),
                      child: BaseButton(Tr.app_double_confirm.tr),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Get.back();
                          callback.call(1);
                        },
                        child: Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            Tr.app_base_confirm.tr,
                            style: TextStyle(
                                color: const Color(0xFF9B989D),
                                fontSize: 16,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
