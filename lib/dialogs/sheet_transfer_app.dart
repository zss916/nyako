import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/transfer_info.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/widget/base_button.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/pages/widget/net_logo_image.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';

void showTransferAppSheet() {
  TransferInfo info = transferInfoFromJson(UserInfo.to.transferInfo ?? "");
  Get.bottomSheet(
      TransferApp(
        transferAppIcon: info.transferAppIcon,
        transferAppName: info.transferAppName,
        transferAppPackageName: info.transferAppPackageName,
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
            gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [Color(0xFF201436), Color(0xFF0C0C32)]),
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(30), topStart: Radius.circular(30))),
        padding: const EdgeInsetsDirectional.only(
            start: 15, end: 15, top: 12, bottom: 30),
        child: Column(
          children: [
            if (transferAppIcon != null)
              Container(
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 10),
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xFF232258),
                    borderRadius: BorderRadiusDirectional.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          child: Image.asset(
                            Assets.imgAppLogo,
                            height: 64,
                            width: 64,
                            matchTextDirection: true,
                          ),
                        ),
                        const Text(
                          AppConstants.appName,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 14, end: 14, bottom: 15),
                      child: Image.asset(
                        Assets.imgTransferIcon,
                        width: 45,
                        height: 45,
                        matchTextDirection: true,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          child: NetLogoImage(path: transferAppIcon ?? ""),
                        ),
                        Text(
                          transferAppName ?? "",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsetsDirectional.only(
                  top: 30, start: 15, end: 15, bottom: 20),
              child: Text(
                Tr.appTransferTip
                    .trArgs([(AppConstants.appName), transferAppName ?? ""]),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            GestureDetector(
              onTap: () {
                ARoutes.closeTransferAppDialog();
                if (transferAppPackageName != null) {
                  LaunchReview.launch(androidAppId: transferAppPackageName);
                }
                /*PointAPI.toPointC(
                    appA: AppConstants.appName, appB: transferAppName ?? "");*/
              },
              child: BaseButton(Tr.appQuickDownload.tr),
            )
          ],
        ),
      ),
    );
  }
}
