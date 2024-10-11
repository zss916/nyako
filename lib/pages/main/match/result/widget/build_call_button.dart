import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildCallButton extends StatelessWidget {
  final HostMatchLimitEntityAnchor anchor;

  const BuildCallButton(this.anchor, {super.key});

  @override
  Widget build(BuildContext context) {
    return bottom(anchor);
  }

  Widget bottom(HostMatchLimitEntityAnchor anchor) {
    return anchor.isChat
        ? SizedBox(
            width: 305.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.back();
                      ARoutes.toChatPage(anchor.getUid);
                    },
                    child: Image.asset(
                      Assets.imgHotMsgIcon,
                      width: 54.w,
                      height: 54.w,
                      matchTextDirection: true,
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.back();
                    ARoutes.toLocalCall(anchor.getUid, anchor.showPortrait);
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                  top: 20, bottom: 20, start: 14),
                              child: Container(
                                height: 54.w,
                                width: 237.w,
                                decoration: BoxDecoration(
                                  gradient: AppColors.btnGradient3,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(45),
                                ),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    RepaintBoundary(
                                      child: Image.asset(
                                        Assets.animaCall,
                                        width: 30,
                                        height: 30,
                                        matchTextDirection: true,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 5),
                                      child: Text(
                                        Tr.app_grade_video_chat.tr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            PositionedDirectional(
                                end: 0,
                                bottom: 60,
                                child: Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 3, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1E1226),
                                      border: Border.all(
                                          width: 0, color: Colors.transparent),
                                      borderRadius:
                                          const BorderRadiusDirectional.only(
                                              topStart: Radius.circular(37),
                                              bottomStart: Radius.circular(37),
                                              topEnd: Radius.circular(37),
                                              bottomEnd: Radius.circular(0))),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Container(
                                            margin: const EdgeInsetsDirectional
                                                .only(bottom: 2, end: 3),
                                            child: Image.asset(
                                              Assets.imgDiamond,
                                              matchTextDirection: true,
                                              width: 14,
                                              height: 14,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${anchor.charge ?? 0}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        TextSpan(
                                          text: Tr.app_video_time_unit.tr,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.back();
              ARoutes.toChatPage(anchor.getUid);
            },
            child: Container(
              height: 54.w,
              width: 240.w,
              margin: const EdgeInsetsDirectional.only(
                  start: 10, end: 10, top: 30, bottom: 15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF7770FF),
                  Color(0xFF5138FF),
                ]),
                borderRadius: BorderRadiusDirectional.circular(45),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset(
                    Assets.imgToMsgIcon,
                    width: 30,
                    height: 30,
                    matchTextDirection: true,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    child: Text(
                      Tr.app_base_message.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
  }
}
