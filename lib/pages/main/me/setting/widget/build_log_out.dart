import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/main/me/setting/index.dart';
import 'package:nyako/widget/animated_button.dart';

class BuildLogout extends StatelessWidget {
  final SetLogic logic;

  const BuildLogout(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      child: Container(
        margin: const EdgeInsetsDirectional.only(
            start: 30, end: 30, top: 10, bottom: 40),
        padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Center(
          child: Text(Tr.app_setting_logout.tr,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFF4864),
                  fontWeight: FontWeight.w500)),
        ),
      ),
      onCall: () => logic.logout(),
    );
  }
}
