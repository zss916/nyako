import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';

void showPublicTipDialog() {
  Get.dialog(const PublicTipDialog());
}

class PublicTipDialog extends StatelessWidget {
  const PublicTipDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          padding: const EdgeInsetsDirectional.only(top: 40, bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: AppColors.dialogsGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  Tr.appStoryCreateForbid.tr,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                      gradient: AppColors.btnGradient,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
        const Spacer(),
      ],
    );
  }
}
