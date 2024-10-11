import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class MatchFail extends StatelessWidget {
  const MatchFail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              // alignment: AlignmentDirectional.center,
              height: 300,
              width: double.maxFinite,
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 35),
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                        Color(0xFF201436),
                        Color(0xFF0C0C32),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.imgMatchFail,
                    width: 84,
                    height: 84,
                    matchTextDirection: true,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: Text(
                      Tr.app_match_failed.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 54,
                      width: double.maxFinite,
                      alignment: AlignmentDirectional.center,
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(50),
                          gradient: const LinearGradient(colors: [
                            Color(0xFFAC53FB),
                            Color(0xFF7934F0),
                          ])),
                      child: Text(
                        Tr.app_restart_match.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
