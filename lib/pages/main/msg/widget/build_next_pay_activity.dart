import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_colors.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/msg/index.dart';

class BuildNextPayActivity extends StatelessWidget {
  final MsgListLogic logic;

  const BuildNextPayActivity({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog();
      },
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10, start: 5),
              child: Image.asset(
                Assets.iconDiamond,
                width: 85,
                height: 85,
                matchTextDirection: true,
              ),
            ),
            Expanded(
                child: Text(
              logic.activityTitle,
              style: const TextStyle(
                  color: Color(0xFF8A0000),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }

  void showDialog() {
    Get.dialog(
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 600.h,
              margin: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, bottom: 10),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.dialogBg,
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        start: 10, end: 10, bottom: 10, top: 0),
                    child: Text(
                      Tr.appNextPayDialogTitle.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Text(
                      logic.activityContent,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50,
                      alignment: AlignmentDirectional.center,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0xFFAC53FB),
                          borderRadius: BorderRadiusDirectional.circular(25)),
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 30, end: 30),
                      child: Text(
                        Tr.app_base_confirm.tr,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        routeSettings: const RouteSettings(name: "activity dialog"));
  }
}
