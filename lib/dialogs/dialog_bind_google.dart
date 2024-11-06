import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_dialog.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/init/login/interface/other_login_utils.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_some_extension.dart';
import 'package:widget_marquee/widget_marquee.dart';

class BindGoogle extends StatefulWidget {
  const BindGoogle({super.key});

  static show() {
    /// 未绑定google账号，弹窗提醒绑定
    if (UserInfo.to.myDetail?.boundGoogle != 1) {
      AppCommonDialog.dialog(const BindGoogle(),
          barrierDismissible: false,
          routeSettings: const RouteSettings(name: AppPages.bindGoogleDialog));
    }
  }

  @override
  State<BindGoogle> createState() => _BindGoogleState();
}

class _BindGoogleState extends State<BindGoogle> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 295,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(30)),
                padding: const EdgeInsetsDirectional.only(
                    start: 15, end: 15, top: 20, bottom: 10),
                margin: const EdgeInsetsDirectional.only(
                    start: 30, end: 30, top: 100, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.maxFinite,
                      //color: Colors.black,
                      alignment: AlignmentDirectional.center,
                      margin:
                          const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                      child: AutoSizeText(
                        Tr.app_bind_google.tr,
                        maxFontSize: 20,
                        minFontSize: 15,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 15, end: 15, bottom: 15),
                      child: Text(
                        Tr.app_remember_tip.tr,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: const TextStyle(
                            color: Color(0xFF6A4B39), fontSize: 14),
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            OtherLoginUtils().bindGoogle();
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 56,
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsetsDirectional.all(5),
                            margin: const EdgeInsetsDirectional.only(
                                start: 20, end: 20, top: 20, bottom: 10),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    matchTextDirection: true,
                                    image: ExactAssetImage(
                                        Assets.iconBindGoogleBtn))),
                            child: Text(
                              Tr.app_bind_google.tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                            end: 20,
                          ),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  //centerSlice: Rect.fromLTRB(10, 2, 120, 30),
                                  matchTextDirection: true,
                                  image: ExactAssetImage(
                                      Assets.iconBindGoogleTitleIc))),
                          width: 166,
                          height: 36,
                          padding: const EdgeInsetsDirectional.only(
                              top: 2, bottom: 3, start: 8, end: 8),
                          child: Marquee(
                            delay: const Duration(seconds: 1),
                            pause: const Duration(seconds: 0),
                            child: (Get.isAr || Get.isHi || Get.isTr)
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        Assets.iconCallVideoCard,
                                        width: 16,
                                        height: 21,
                                        matchTextDirection: true,
                                      ),
                                      const Text(
                                        "x1",
                                        style: TextStyle(
                                            color: Color(0xFF6A4B39),
                                            fontSize: 13),
                                      ),
                                      Text(
                                        //es/hi/tr/ind
                                        // language_es[Tr.app_bind_google_to_get] ?? "",
                                        Tr.app_bind_google_to_get.trArgs([""]),
                                        style: const TextStyle(
                                            color: Color(0xFF6A4B39),
                                            fontSize: 13),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        //es/hi/tr/ind
                                        // language_es[Tr.app_bind_google_to_get] ?? "",
                                        Tr.app_bind_google_to_get.trArgs([""]),
                                        style: const TextStyle(
                                            color: Color(0xFF6A4B39),
                                            fontSize: 13),
                                      ),
                                      Image.asset(
                                        Assets.iconCallVideoCard,
                                        width: 16,
                                        height: 21,
                                        matchTextDirection: true,
                                      ),
                                      const Text(
                                        "x1",
                                        style: TextStyle(
                                            color: Color(0xFF6A4B39),
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: 0),
                  child: Image.asset(
                    Assets.iconCloseDialog,
                    width: 42,
                    height: 42,
                  ),
                ),
              )
            ],
          ),
          PositionedDirectional(
              top: 0,
              child: Image.asset(
                Assets.iconBindGoogleTop,
                matchTextDirection: true,
                width: 313,
                height: 128,
              )),
        ],
      ),
    );
  }
}
