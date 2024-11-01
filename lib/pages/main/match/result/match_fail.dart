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
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  // alignment: AlignmentDirectional.center,
                  //height: 350,
                  constraints: const BoxConstraints(minHeight: 300),
                  width: double.maxFinite,
                  margin: const EdgeInsetsDirectional.only(
                      start: 30, end: 30, top: 60),
                  padding: const EdgeInsetsDirectional.only(
                      top: 50, start: 30, end: 30, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 10, bottom: 15),
                        child: Text(
                          Tr.app_match_failed.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(bottom: 20),
                        child: Text(
                          Tr.appMatchFailedContent.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFF9B989D),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 54,
                          width: double.maxFinite,
                          alignment: AlignmentDirectional.center,
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(50),
                              color: const Color(0xFF9341FF)),
                          child: Text(
                            Tr.app_restart_match.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            Tr.app_base_cancel.tr,
                            style: const TextStyle(
                                color: Color(0xFF9B989D),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                ),
                Image.asset(
                  Assets.animaNyakoMatchFailTop,
                  width: 130,
                  height: 130,
                  matchTextDirection: true,
                )
              ],
            )
          ],
        ));
  }
}
