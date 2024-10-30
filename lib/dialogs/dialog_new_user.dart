import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 15, end: 15, start: 15),
                  padding: const EdgeInsetsDirectional.only(
                      start: 16, top: 16, bottom: 16, end: 16),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          colors: [
                            Color(0xFFFDF2E9),
                            Color(0xFFFFB47F),
                          ]),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(24),
                          topEnd: Radius.circular(24))),
                  width: 280,
                  height: 130,
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            Tr.app_you_are_lucky.tr,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            maxFontSize: 24,
                            minFontSize: 16,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF482C26)),
                          ),
                          AutoSizeText(
                            Tr.app_dialog_new_user_title.tr,
                            maxLines: 2,
                            maxFontSize: 15,
                            minFontSize: 13,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF821800)),
                          ),
                        ],
                      )),
                      Container(
                        color: Colors.transparent,
                        width: 80,
                        height: 80,
                      )
                    ],
                  ),
                ),
                Image.asset(
                  Assets.iconNewUserTitleIc,
                  matchTextDirection: true,
                  width: 113,
                  height: 110,
                )
              ],
            ),
            Container(
              width: 305,
              height: 214,
              margin: const EdgeInsetsDirectional.only(top: 110),
              padding: const EdgeInsetsDirectional.all(12),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                        Color(0xFFFFFAF4),
                        Color(0xFFFFC69C),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    decoration: const BoxDecoration(color: Color(0xFFFD5400)),
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, top: 12, bottom: 12, end: 12),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 30),
                          child: Image.asset(
                            Assets.iconCallCard,
                            matchTextDirection: true,
                            width: 72,
                            height: 72,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            AutoSizeText(
                              Tr.app_vido_tx.tr,
                              maxLines: 1,
                              maxFontSize: 18,
                              minFontSize: 16,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            AutoSizeText(
                              "x${widget.cardNum}",
                              maxFontSize: 35,
                              minFontSize: 32,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: double.maxFinite,
                      height: 52,
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsetsDirectional.only(
                          start: 13, end: 13, bottom: 15, top: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          gradient: const LinearGradient(
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [Color(0xFF733E2A), Color(0xFF452D26)]),
                          borderRadius: BorderRadiusDirectional.circular(26)),
                      child: Text(
                        Tr.app_base_confirm.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
