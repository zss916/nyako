import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/login_agree_dialog.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/services/user_info.dart';

class BuildGoogleLogin extends StatelessWidget {
  final LoginLogic logic;

  const BuildGoogleLogin(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        height: 56,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
        margin: const EdgeInsetsDirectional.only(
            start: 40, end: 40, top: 15, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x669341FF),
              blurRadius: 15.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          borderRadius: BorderRadiusDirectional.circular(24),
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
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
              child: Text(
                Tr.app_login_google.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
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
