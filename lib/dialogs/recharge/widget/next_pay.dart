import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';

class NextPay extends StatefulWidget {
  const NextPay({super.key});

  @override
  State<NextPay> createState() => _NextPayState();
}

class _NextPayState extends State<NextPay> {
  ///活动
  bool isOpenActivity = false;
  String activityTitle = "";
  String activityContent = "";

  @override
  void initState() {
    super.initState();
    getActiveConfig();
  }

  getActiveConfig() {
    ActivityAPI.getActiveConfig().then((data) {
      setState(() {
        isOpenActivity = data.status == 1;
        activityTitle = data.title;
        activityContent = data.content;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOpenActivity
        ? InkWell(
            onTap: () {
              openActivity();
            },
            child: Container(
              height: 64,
              width: double.maxFinite,
              margin:
                  const EdgeInsetsDirectional.only(start: 12, end: 12, top: 10),
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
                    activityTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppConstants.fontsBold,
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
          )
        : const SizedBox.shrink();
  }

  void openActivity() {
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
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        start: 10, end: 10, bottom: 10, top: 0),
                    child: Text(
                      Tr.appNextPayDialogTitle.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Text(
                      activityContent,
                      style: TextStyle(
                          fontFamily: AppConstants.fontsRegular,
                          color: Colors.black),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppConstants.fontsBold,
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
  }
}
