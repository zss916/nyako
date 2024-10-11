import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/login_agree_dialog.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/animated_button.dart';

class BuildGoogleLogin extends StatelessWidget {
  final LoginLogic logic;

  const BuildGoogleLogin(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      child: Container(
        width: double.maxFinite,
        height: 52,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
        margin: const EdgeInsetsDirectional.only(
            start: 50, end: 50, top: 15, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(37),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.finalGoogleLogo,
              matchTextDirection: true,
              width: 20,
              height: 20,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
              child: Text(
                Tr.app_login_google.tr,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            const SizedBox(width: 24, height: 24)
          ],
        ),
      ),
      onCall: () {
        if (AppConstants.isTestMode) return;
        if (UserInfo.to.getCheck()) {
          logic.toGoogleSignIn();
        } else {
          showAgreeDialog(() {
            logic.toGoogleSignIn();
          });
        }
      },
    );
  }
}
