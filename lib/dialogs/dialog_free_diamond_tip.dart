import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_dialog.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';

void showFreeDiamondTip() {
  AppCommonDialog.dialog(const AppFreeDiamondTipDialog(),
      routeSettings: const RouteSettings(name: AppPages.freeDiamondTipDialog));
}

class AppFreeDiamondTipDialog extends StatefulWidget {
  const AppFreeDiamondTipDialog({
    super.key,
  });

  @override
  State<AppFreeDiamondTipDialog> createState() =>
      _AppFreeDiamondTipDialogState();
}

class _AppFreeDiamondTipDialogState extends State<AppFreeDiamondTipDialog>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              RepaintBoundary(
                child: Transform.rotate(
                  angle: 3 * pi / 180,
                  child: Image.asset(
                    Assets.animaNyakoFreeDiamond,
                    matchTextDirection: true,
                    height: 375,
                    width: 367,
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 10,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                    Future.delayed(Duration.zero, () {
                      ARoutes.toShare();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 315,
                        height: 80,
                        alignment: Alignment.center,
                        padding: const EdgeInsetsDirectional.only(
                            start: 10, end: 10, bottom: 10),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                matchTextDirection: true,
                                image: ExactAssetImage(
                                    Assets.iconFreeDiamondBtn))),
                        child: Text(Tr.app_receive_gift.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(
              Assets.iconCloseDialog,
              height: 42,
              width: 42,
            ),
          )
        ],
      ),
    );
  }
}
