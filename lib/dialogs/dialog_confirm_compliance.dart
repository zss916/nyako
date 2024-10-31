import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/widget/base_button4.dart';
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
                      style: const TextStyle(
                          color: Colors.black,
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
                        maxFontSize: 14,
                        minFontSize: 11,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
                    InkWell(
                      //behavior: HitTestBehavior.opaque,
                      onTap: () => Get.back(),
                      child: BaseButton4(Tr.app_base_confirm.tr),
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
