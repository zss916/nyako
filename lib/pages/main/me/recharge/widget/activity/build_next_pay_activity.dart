import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';

class BuildNextPayActivity extends StatelessWidget {
  final RechargeLogic logic;

  const BuildNextPayActivity({Key? key, required this.logic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 600.h,
                  margin: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 20),
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
                              borderRadius:
                                  BorderRadiusDirectional.circular(25)),
                          margin: const EdgeInsetsDirectional.only(
                              top: 10, start: 30, end: 30),
                          child: Text(
                            Tr.app_base_confirm.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            routeSettings: const RouteSettings(name: "activity dialog"));
      },
      child: Container(
        height: 64,
        width: double.maxFinite,
        margin: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color(0xFFFF821A),
              Color(0xFFFFC417),
            ]),
            borderRadius: BorderRadiusDirectional.circular(14)),
        child: Row(
          children: [
            Expanded(
                child: Text(
              logic.activityTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            )),
            Container(
              margin: const EdgeInsetsDirectional.only(end: 5, start: 10),
              child: Image.asset(
                Assets.iconDiamondM,
                width: 66,
                height: 44,
                matchTextDirection: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
