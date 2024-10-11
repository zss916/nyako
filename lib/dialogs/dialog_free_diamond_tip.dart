import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';

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
              /* RotationTransition(
                turns: _rotationController,
                child: Image.asset(
                  Assets.imgBigDiamond,
                  matchTextDirection: true,
                  height: 255,
                  width: 255,
                  fit: BoxFit.fill,
                ),
              ),*/
              Image.asset(
                Assets.imgFreeDiamondIcon,
                matchTextDirection: true,
                height: 355,
                width: 298,
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
                        height: 54,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFFFBB653),
                              Color(0xFFF0345C),
                            ]),
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(30))),
                        child: Text(Tr.app_receive_gift.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(
              Assets.imgCloseDialog,
              height: 36,
              width: 36,
            ),
          )
        ],
      ),
    );
  }
}
