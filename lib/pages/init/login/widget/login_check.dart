import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/services/user_info.dart';

class LoginCheck extends StatefulWidget {
  bool checked = false;
  final Color? color;
  LoginCheck(this.checked, {super.key, this.color});

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.only(
            top: 10, start: 0, end: 0, bottom: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() {
                    widget.checked = !widget.checked;
                    UserInfo.to.setCheck(widget.checked);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                  end: 10,
                  top: 9,
                  bottom: 7,
                ),
                color: Colors.transparent,
                child: Image.asset(
                  widget.checked ? Assets.iconChecked : Assets.iconUncheck,
                  fit: BoxFit.fill,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            Expanded(
                child: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: Tr.app_login_agree_1.tr,
                  children: [
                    const TextSpan(text: ' '),
                    TextSpan(
                        style: TextStyle(
                            fontFamily: AppConstants.fontsRegular,
                            decorationColor: const Color(0xFF9341FF),
                            color: widget.color ?? const Color(0xFF9341FF),
                            decoration: TextDecoration.underline),
                        text: Tr.app_login_privacy_policy.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ARoutes.toWeb(AppConstants.privacyPolicy, true);
                          }),
                    const TextSpan(text: ' '),
                    TextSpan(text: Tr.app_login_agree_2.tr),
                    const TextSpan(text: ' '),
                    TextSpan(
                        style: TextStyle(
                            fontFamily: AppConstants.fontsRegular,
                            decorationColor: const Color(0xFF9341FF),
                            color: widget.color ?? const Color(0xFF9341FF),
                            decoration: TextDecoration.underline),
                        text: Tr.app_login_terms_service.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ARoutes.toWeb(AppConstants.agreement, true);
                          }),
                  ],
                  style: TextStyle(
                      color: widget.color ?? const Color(0xFF5B5A5B),
                      fontSize: 12,
                      fontFamily: AppConstants.fontsRegular,
                      height: 1.4),
                )
              ]),
              textAlign: TextAlign.left,
              maxLines: 3,
            ))
          ],
        ));
  }
}
