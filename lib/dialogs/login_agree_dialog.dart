import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/pages/init/account/login/index.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/widget/animated_button.dart';

import '../common/app_constants.dart';
import '../common/language_key.dart';

showAgreeDialog(Function fun) {
  bool _checked = true;
  Get.dialog(
      Center(
        child: Container(
            width: Get.width,
            margin: const EdgeInsetsDirectional.only(start: 40, end: 40),
            padding: const EdgeInsetsDirectional.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    Tr.app_login_check_policy.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFF7934F0), fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 20, top: 20),
                  child: Text.rich(
                    TextSpan(children: [
                      WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsetsDirectional.only(
                                start: 22,
                                end: 5,
                                top: 9,
                                bottom: 7,
                              ),
                              color: Colors.transparent,
                              child: _checked == true
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF7934F0),
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white30,
                                      size: 15,
                                    ),
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: Tr.app_login_agree_1.tr,
                        children: [
                          TextSpan(
                              style: const TextStyle(
                                  color: Color(0xFFF447FF),
                                  decoration: TextDecoration.underline),
                              text: Tr.app_login_privacy_policy.tr,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ARoutes.toWeb(
                                      AppConstants.privacyPolicy, true);
                                }),
                          const TextSpan(text: ' '),
                          TextSpan(text: Tr.app_login_agree_2.tr),
                          const TextSpan(text: ' '),
                          TextSpan(
                              style: const TextStyle(
                                  color: Color(0xFFF447FF),
                                  decoration: TextDecoration.underline),
                              text: Tr.app_login_terms_service.tr,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ARoutes.toWeb(AppConstants.agreement, true);
                                }),
                          const TextSpan(text: ' '),
                          TextSpan(text: Tr.app_login_agree_3.tr),
                        ],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      )
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                AnimatedButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsetsDirectional.only(
                        start: 20, end: 20, bottom: 10, top: 35),
                    height: 52,
                    decoration: BoxDecoration(
                        gradient: AppColors.btnGradient,
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(30))),
                    child: Text(
                      Tr.app_base_confirm.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  onCall: () {
                    UserInfo.to.setCheck(true);
                    safeFind<LoginLogic>()?.update();
                    safeFind<AccountLoginLogic>()?.update();
                    Get.back();
                    fun.call();
                  },
                ),
              ],
            )),
      ),
      routeSettings: const RouteSettings(name: AppPages.loginAgreeDialog),
      useSafeArea: false);
}
