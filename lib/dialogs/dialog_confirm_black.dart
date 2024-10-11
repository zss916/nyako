import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/pages/widget/base_button.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_extends.dart';

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
          height: 450,
          margin:
              const EdgeInsetsDirectional.only(start: 25, end: 25, bottom: 20),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(top: 50),
                padding: const EdgeInsetsDirectional.only(
                    bottom: 20, start: 20, end: 20, top: 20),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFF201436),
                          Color(0xFF0C0C32),
                        ]),
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 95,
                      height: 95,
                      padding: const EdgeInsetsDirectional.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(100),
                        child: cachedImage(detail?.portrait ?? '',
                            width: 90, height: 90),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                        style: const TextStyle(
                            color: Color(0xFFC3A0FF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                        callback.call(1);
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(10),
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
                ),
              ),
              /*PositionedDirectional(
                  top: 60,
                  end: 10,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      Assets.imageCancel,
                      width: 30,
                      height: 30,
                    ),
                  )),*/
            ],
          ),
        )
      ],
    );
  }
}
