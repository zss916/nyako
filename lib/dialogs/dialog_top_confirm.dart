import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/generated/assets.dart';

import '../common/language_key.dart';

class AppDialogTopConfirm extends StatelessWidget {
  AppCallback<int> callback;
  String title;
  String? content;
  bool onlyConfirm;
  bool showIcon;
  double? h;

  AppDialogTopConfirm(
      {super.key,
      required this.callback,
      required this.title,
      this.content,
      this.onlyConfirm = false,
      this.showIcon = true,
      this.h});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: Get.width,
            height: h ?? Get.height / 2,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            padding: const EdgeInsetsDirectional.only(top: 40, bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAF8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showIcon)
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      Assets.iconSmallLogo,
                      matchTextDirection: true,
                      height: 60,
                      width: 60,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (content != null)
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      content ?? '',
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  const Spacer(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                        callback.call(1);
                      },
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                            gradient: AppColors.btnGradient,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
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
                    if (!onlyConfirm)
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 58,
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                              top: 10, start: 30, end: 30),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  width: 2, color: const Color(0xFFEF45A3)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Text(
                            Tr.app_base_cancel.tr,
                            style: const TextStyle(
                                color: Color(0xFFEF45A3),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
