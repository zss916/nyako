import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/charge/charge_dialog_manager.dart';
import 'package:nyako/utils/app_extends.dart';

class BuildGift extends StatefulWidget {
  const BuildGift({super.key});

  @override
  State<BuildGift> createState() => _BuildGiftState();
}

class _BuildGiftState extends State<BuildGift> with DragInterface {
  @override
  Widget build(BuildContext context) {
    return buildDrag();
  }

  Widget buildDrag() {
    return Obx(() {
      return AnimatedPositioned(
        left: moveOffset.value.dx,
        bottom: moveOffset.value.dy,
        duration: const Duration(milliseconds: 10),
        child: GestureDetector(
          onTap: () {
            ChargeDialogManager.showChargeDialog(
              ChargePath.home_float_recharge, /*showBalanceText: true*/
            );
          },
          onHorizontalDragStart: (details) {
            onDragStart(details.localPosition);
          },
          onHorizontalDragUpdate: (details) {
            onDragMoveUpdate(details.localPosition);
          },
          onHorizontalDragEnd: (details) {
            onDragEnd(
                const Size(44, 4),
                Size(Get.width, Get.height),
                EdgeInsetsDirectional.only(
                    top: Get.statusBarHeight + 150,
                    start: 8,
                    end: 30,
                    bottom: Get.bottomBarHeight + 10));
          },
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 20, bottom: 80),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 15),
                  child: RepaintBoundary(
                    child: Lottie.asset(
                      Assets.jsonAnimaHomeRecharge,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 4),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFF741A), Color(0xFFFF17D6)]),
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 12, vertical: 4),
                  child: Text(
                    Tr.app_recharge.tr,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
