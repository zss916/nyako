import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/login_agree_dialog.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/animated_button.dart';

class BuildTouristLogin extends StatelessWidget {
  final LoginLogic logic;

  const BuildTouristLogin(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      child: Container(
        width: double.maxFinite,
        height: 52,
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsetsDirectional.only(
            start: 50, end: 50, top: 15, bottom: 0),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFAC53FB),
              Color(0xFF7934F0),
            ]),
            borderRadius: BorderRadiusDirectional.all(Radius.circular(30))),
        child: Text(
          Tr.app_guest_login.tr,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      onCall: () {
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
