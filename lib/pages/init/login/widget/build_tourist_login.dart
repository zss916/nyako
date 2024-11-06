import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/login_agree_dialog.dart';
import 'package:nyako/pages/init/login/index.dart';
import 'package:nyako/services/user_info.dart';

class BuildTouristLogin extends StatelessWidget {
  final LoginLogic logic;

  const BuildTouristLogin(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        height: 56,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsetsDirectional.only(
            start: 40, end: 40, top: 15, bottom: 0),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
            color: Color(0xFF9341FF),
            borderRadius: BorderRadiusDirectional.all(Radius.circular(24))),
        child: Text(
          Tr.app_guest_login.tr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: AppConstants.fontsRegular,
              fontWeight: FontWeight.normal),
        ),
      ),
      onTap: () {
        if (UserInfo.to.getCheck()) {
          logic.visitorLogin();
        } else {
          showAgreeDialog(() {
            logic.visitorLogin();
          });
        }
      },
    );
  }
}
