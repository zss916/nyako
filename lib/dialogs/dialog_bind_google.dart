import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/login/interface/other_login_utils.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';

class BindGoogle extends StatefulWidget {
  const BindGoogle({super.key});

  static show() {
    /// 未绑定google账号，弹窗提醒绑定
    if (UserInfo.to.myDetail?.boundGoogle != 1) {
      AppCommonDialog.dialog(const BindGoogle(),
          routeSettings: const RouteSettings(name: AppPages.bindGoogleDialog));
    }
  }

  @override
  State<BindGoogle> createState() => _BindGoogleState();
}

class _BindGoogleState extends State<BindGoogle> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: AppColors.splashBg,
              borderRadius: BorderRadiusDirectional.circular(30)),
          padding: const EdgeInsetsDirectional.only(
              start: 15, end: 15, top: 15, bottom: 10),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.imgBindTopGoogleIcon,
                width: 104,
                height: 104,
                matchTextDirection: true,
              ),
              Container(
                width: double.maxFinite,
                //color: Colors.black,
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsetsDirectional.only(top: 20),
                child: AutoSizeText(
                  Tr.app_bind_google.tr,
                  maxFontSize: 20,
                  minFontSize: 15,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
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
                  style:
                      const TextStyle(color: Color(0xFFC3A0FF), fontSize: 14),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 50,
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsetsDirectional.only(
                    start: 10, end: 10, bottom: 13, top: 10),
                margin: const EdgeInsetsDirectional.only(
                    top: 0, start: 15, end: 15),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        matchTextDirection: true,
                        fit: BoxFit.fill,
                        image: ExactAssetImage(Assets.imgBindGoogleCardBg))),
                child: Text(
                  Tr.app_dialog_call_experience_card.trArgs(["1"]),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  OtherLoginUtils().bindGoogle();
                },
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                      gradient: AppColors.btnGradient,
                      borderRadius: BorderRadiusDirectional.circular(25)),
                  height: 50,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    Tr.app_binding.tr,
                    softWrap: true,
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 8,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, bottom: 0),
                  height: 50,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    Tr.app_base_cancel.tr,
                    softWrap: true,
                    maxLines: 2,
                    maxFontSize: 16,
                    minFontSize: 8,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
