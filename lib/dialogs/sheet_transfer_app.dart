import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/transfer_info.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/pages/widget/net_logo_image.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/user_info.dart';

void showTransferAppSheet() {
  TransferInfo info = transferInfoFromJson(UserInfo.to.transferInfo ?? "");
  Get.bottomSheet(
      BottomArrowWidget(
        child: TransferApp(
          transferAppIcon: info.transferAppIcon,
          transferAppName: info.transferAppName,
          transferAppPackageName: info.transferAppPackageName,
        ),
      ),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.transferAppSheet));
}

class TransferApp extends StatelessWidget {
  final String? transferAppIcon;

  final String? transferAppPackageName;

  final String? transferAppName;

  const TransferApp(
      {super.key,
      this.transferAppIcon,
      this.transferAppName,
      this.transferAppPackageName});

  @override
  Widget build(BuildContext context) {
    return BottomArrowWidget(
      onBack: () => Get.back(),
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        constraints: const BoxConstraints(minHeight: 350),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(30), topStart: Radius.circular(30))),
        padding: const EdgeInsetsDirectional.only(
            start: 15, end: 15, top: 10, bottom: 10),
        child: Column(
          children: [
            if (transferAppIcon != null)
              Container(
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 10),
                padding: const EdgeInsetsDirectional.only(
                    top: 15, start: 10, end: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadiusDirectional.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          child: Image.asset(
                            Assets.iconSmallLogo,
                            height: 90,
                            width: 90,
                            matchTextDirection: true,
                          ),
                        ),
                        /*const Text(
                          AppConstants.appName,
                          style: TextStyle(
                              color: Colors.transparent, fontSize: 15),
                        )*/
                      ],
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 14, end: 14, bottom: 15),
                      child: Image.asset(
                        Assets.iconTransferIcon,
                        width: 38,
                        height: 32,
                        matchTextDirection: true,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          child: NetLogoImage(path: transferAppIcon ?? ""),
                        ),
                        /*Text(
                          transferAppName ?? "",
                          style: const TextStyle(
                              color: Colors.transparent, fontSize: 15),
                        )*/
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                  top: 0, start: 15, end: 15, bottom: 20),
              child: Text(
                Tr.appTransferTip
                    .trArgs([(AppConstants.appName), transferAppName ?? ""]),
                style: const TextStyle(color: Color(0xFF9B989D), fontSize: 15),
              ),
            ),
            GestureDetector(
              onTap: () {
                ARoutes.closeTransferAppDialog();
                if (transferAppPackageName != null) {
                  LaunchReview.launch(androidAppId: transferAppPackageName);
                }
                //Tr.appQuickDownload.tr
                /*PointAPI.toPointC(
                    appA: AppConstants.appName, appB: transferAppName ?? "");*/
              },
              child: Container(
                width: double.maxFinite,
                height: 52,
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 4,
                          color: Color(0x4D9341FF))
                    ],
                    color: const Color(0xFF9341FF),
                    borderRadius: BorderRadiusDirectional.circular(50)),
                child: Text(
                  Tr.appQuickDownload.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  Tr.app_base_cancel.tr,
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF9341FF)),
                ))
          ],
        ),
      ),
    );
  }
}
