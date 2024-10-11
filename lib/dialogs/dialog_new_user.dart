import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_common_dialog.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_renew_vip.dart';
import 'package:oliapro/dialogs/sign/dialog_sign.dart';
import 'package:oliapro/entities/app_info_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_check_calling_util.dart';

//新用户福利(体验卡)
class AppNewUserCardsTip extends StatefulWidget {
  static checkToShow() {
    if (AppConstants.isFakeMode) {
      Future.delayed(const Duration(seconds: 1), () {
        if (StorageService.to.canShowSign()) {
          toSignDialog();
        }
      });
      return;
    }
    if (UserInfo.to.myDetail?.created == 1) {
      Future.delayed(const Duration(seconds: 3), () async {
        InfoDetail myDetail;
        try {
          myDetail = await ProfileAPI.info(showLoading: false);
        } catch (e) {
          return;
        }
        if ((myDetail.callCardUsedCount ?? 1) <= 0 &&
            (myDetail.callCardCount ?? 0) > 0 &&
            !AppCheckCallingUtil.checkCalling()) {
          AppCommonDialog.dialog(AppNewUserCardsTip(myDetail.callCardCount!),
              barrierColor: Colors.black.withOpacity(0.8),
              routeSettings: const RouteSettings(name: AppPages.newUserDialog));
        } else {
          if (StorageService.to.canShowSign()) {
            toSignDialog();
          }
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        RenewVipDialog.show();
        if (StorageService.to.canShowSign()) {
          toSignDialog();
        }
      });
    }
  }

  final int cardNum;

  const AppNewUserCardsTip(this.cardNum, {super.key});

  @override
  State<AppNewUserCardsTip> createState() => _AppNewUserCardsTipState();
}

class _AppNewUserCardsTipState extends State<AppNewUserCardsTip> {
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    //15s后 如果用户体验卡提示弹窗还在则自动关闭
    //  _timer = Timer(const Duration(seconds: 15), () {});
  }

  @override
  void dispose() {
    Future.delayed(const Duration(seconds: 1), () {
      RenewVipDialog.show();
      if (StorageService.to.canShowSign()) {
        toSignDialog();
      }
    });
    super.dispose();
    /*_timer?.cancel();
    _timer = null;*/
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 380,
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 30, vertical: 0),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: AlignmentDirectional.bottomStart,
                  end: AlignmentDirectional.topEnd,
                  colors: [
                    Color(0xFF8940FF),
                    Color(0xFFD34BFD),
                  ]),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                Assets.imgNewUserTop,
                matchTextDirection: true,
                width: 255,
                height: 146,
              ),
              Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsetsDirectional.only(
                    top: 20, bottom: 30, start: 50, end: 50),
                child: Text.rich(
                  TextSpan(text: Tr.app_dialog_new_user_tip.tr, children: [
                    TextSpan(
                        text: Tr.app_dialog_call_experience_card
                            .trArgs(["${widget.cardNum}"]),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    TextSpan(
                      text: Tr.app_dialog_new_user_tip_2.tr,
                    )
                  ]),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsetsDirectional.symmetric(
                      horizontal: 30, vertical: 30),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          colors: [Colors.white, Color(0xFFFFCAF8)]),
                      borderRadius: BorderRadiusDirectional.circular(50)),
                  height: 50,
                  width: 210,
                  child: Text(
                    Tr.app_base_confirm.tr,
                    style: const TextStyle(
                        color: Color(0xFF8239FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
