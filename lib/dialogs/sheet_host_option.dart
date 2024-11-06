import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/pages/call/aiv/index.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/utils/app_loading.dart';

import '../common/app_colors.dart';
import '../common/language_key.dart';

void showHostOptionSheet({required String herId, VoidCallback? close}) {
  Get.bottomSheet(
      BottomArrowWidget(
        child: AppSheetHostOption(
          herId: herId,
          close: () {
            close?.call();
          },
        ),
        onBack: () => Get.back(),
      ),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.hostOptionSheet));
}

class AppSheetHostOption extends StatefulWidget {
  final String herId;

  final VoidCallback? close;

  const AppSheetHostOption({Key? key, required this.herId, this.close})
      : super(key: key);

  @override
  State<AppSheetHostOption> createState() => _AppSheetHostOptionState();
}

class _AppSheetHostOptionState extends State<AppSheetHostOption> {
  @override
  void initState() {
    super.initState();
    AivLogic.openBlackDialog = true;
  }

  @override
  void dispose() {
    super.dispose();
    AivLogic.openBlackDialog = false;
  }

  void handleBlack(VoidCallback? close) {
    AppLoading.show();
    Http.instance.post<int>(NetPath.blacklistActionApi + widget.herId,
        errCallback: (err) {
      AppLoading.toast(err.message);
      Get.back();
    }).then((value) {
      AppLoading.toast(Tr.app_base_success.tr);
      StorageService.to.updateBlackList(widget.herId, value == 1);
      Get.back(result: value);
      close?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10), topEnd: Radius.circular(10)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                handleBlack(widget.close);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                        topEnd: Radius.circular(20))),
                child: Text(
                  StorageService.to.checkBlackList(widget.herId)
                      ? Tr.app_dialog_remove_black.tr
                      : Tr.app_dialog_add_black.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                //ARoutes.toReport(uid:widget.herId ?? '',type:"0");
                showReportSheet(widget.herId ?? '', close: widget.close);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.only(top: 15, bottom: 20),
                decoration: const BoxDecoration(),
                child: Text(
                  Tr.app_report_title.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 6,
              color: AppColors.colorF5F5F6,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                margin: const EdgeInsetsDirectional.only(
                    start: 60, end: 60, bottom: 10, top: 10),
                height: 52,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(52 * 0.5)),
                ),
                child: Text(
                  Tr.app_base_cancel.tr,
                  style: const TextStyle(
                      color: AppColors.color999999, fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
