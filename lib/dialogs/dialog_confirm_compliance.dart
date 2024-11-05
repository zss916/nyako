import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/widget/base_button.dart';
import 'package:oliapro/routes/app_pages.dart';

void showComplianceDialog() {
  Get.dialog(const AppDialogCompliance(),
      routeSettings: const RouteSettings(name: AppPages.toComplianceDialog));
}

class AppDialogCompliance extends StatelessWidget {
  const AppDialogCompliance({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 420,
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
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Tr.app_alert_tips.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 15, end: 15, top: 10, bottom: 10),
                      child: AutoSizeText(
                        Tr.appCompliance.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxFontSize: 15,
                        minFontSize: 11,
                        style: TextStyle(
                            color: const Color(0xFF9B989D),
                            fontSize: 15,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
                    InkWell(
                      //behavior: HitTestBehavior.opaque,
                      onTap: () => Get.back(),
                      child: BaseButton(Tr.app_base_confirm.tr),
                    ),
                    const SizedBox(
                      height: 10,
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
