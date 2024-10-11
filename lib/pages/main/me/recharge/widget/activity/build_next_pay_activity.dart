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
        height: 100,
        width: double.maxFinite,
        margin: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                matchTextDirection: true,
                image: ExactAssetImage(Assets.imgNextPayBg))),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10, start: 5),
              child: Image.asset(
                Assets.imgDiamond8,
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
}
