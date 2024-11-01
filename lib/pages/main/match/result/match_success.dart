import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sheet_report.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/pages/main/match/result/widget/app_net_video.dart';
import 'package:oliapro/pages/main/match/result/widget/follow.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/music/match_music_manager.dart';
import 'package:oliapro/utils/screen_protector.dart';

class MatchSuccess extends StatefulWidget {
  final HostMatchLimitEntityAnchor anchor;
  final Function? onRestart;

  final MatchLogic? logic;

  const MatchSuccess(this.anchor, {super.key, this.onRestart, this.logic});

  @override
  State<MatchSuccess> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<MatchSuccess> {
  late final StreamSubscription<ReportEvent> reportEvent;

  @override
  void initState() {
    super.initState();
    ScreenProtectorUtil.on();
    MatchMusicManager.instance.start();
    //AppConstants.isMatch = false;
    BgmControl.setMatchVolume(false);
    reportEvent = AppEventBus.eventBus.on<ReportEvent>().listen((event) {
      if (ReportEnum.match.index == event.type) {
        Get.back();
      }
    });
  }

  @override
  void dispose() {
    ScreenProtectorUtil.off();
    AppConstants.isMatching = false;
    MatchMusicManager.instance.stop();
    reportEvent.cancel();
    BgmControl.setMatchVolume(true);
    BgmControl.callInBgmStart();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
              Color(0xFF8C28F5),
              Color(0xFFD147D1),
              Color(0xFFFFCDEA),
            ])),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(top: 50),
              child: Image.asset(
                Assets.iconMatchLoveBg,
                width: double.maxFinite,
                fit: BoxFit.fill,
                height: 112,
                matchTextDirection: true,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    width: 311,
                    height: 465,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 0, vertical: 0),
                          padding: const EdgeInsetsDirectional.all(0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(20)),
                              color: Colors.grey),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadiusDirectional.all(
                                    Radius.circular(0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.anchor.showPortrait),
                                    fit: BoxFit.cover)),
                            child: ClipRRect(
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(20)),
                              child: AppNetVideo(
                                widget.anchor.showVideo,
                                double.maxFinite,
                                double.maxFinite,
                                showLoading: true,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 85,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadiusDirectional.circular(15)),
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, top: 10, start: 12, end: 12),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 180),
                                      child: AutoSizeText(
                                        widget.anchor.showNickName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        maxFontSize: 30,
                                        minFontSize: 15,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  end: 8),
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              horizontal: 4, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: const Color(0x1AFF3881),
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                Assets.iconSmallWoman,
                                                width: 14,
                                                height: 14,
                                                matchTextDirection: true,
                                              ),
                                              Text(
                                                widget.anchor.showBirthday,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xFFFF3881)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              horizontal: 4, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: const Color(0x1A3BC2FF),
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                Assets.iconIdSmallIcon,
                                                width: 14,
                                                height: 14,
                                                matchTextDirection: true,
                                              ),
                                              Text(
                                                widget.anchor.getUid,
                                                style: const TextStyle(
                                                    color: Color(0xFF3BC2FF),
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ])),
                              Follow(widget.anchor),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                            top: 12,
                            start: 12,
                            child: GestureDetector(
                              onTap: () => showReportSheet(widget.anchor.getUid,
                                  close: () {
                                AppEventBus.eventBus
                                    .fire(ReportEvent(ReportEnum.match.index));
                              }),
                              /*onTap: () => ARoutes.toReport(
                                  uid: widget.anchor.getUid,
                                  type: ReportEnum.match.index.toString()),*/
                              child: Image.asset(
                                Assets.iconMatchReport,
                                width: 36,
                                height: 36,
                                matchTextDirection: true,
                              ),
                            )),
                        PositionedDirectional(
                            top: 12,
                            end: 12,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Image.asset(
                                Assets.iconCloseMatchDialog,
                                width: 36,
                                height: 36,
                                matchTextDirection: true,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 20),
                    width: 311,
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 52,
                          margin: const EdgeInsetsDirectional.only(
                              end: 12, top: 10),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xFF81E0FF),
                                Color(0xFF4AC6FF),
                              ])),
                          child: Image.asset(
                            Assets.iconToMsgIcon,
                            matchTextDirection: true,
                            width: 32,
                            height: 32,
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      height: 52,
                                      width: double.maxFinite,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: AlignmentDirectional
                                                  .centerStart,
                                              end: AlignmentDirectional
                                                  .centerEnd,
                                              colors: [
                                                Color(0xFF8A29F8),
                                                Color(0xFFFC0193),
                                              ]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(Assets.jsonAnimaCall,
                                              width: 32, height: 32),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          AutoSizeText(
                                            Tr.app_grade_video_chat.tr,
                                            maxFontSize: 18,
                                            minFontSize: 16,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Lottie.asset(Assets.jsonAnimaFlash),
                                  ],
                                ),
                              ),
                              PositionedDirectional(
                                  top: 0,
                                  end: 0,
                                  child: Container(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 4, vertical: 2),
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF822CFE),
                                          Color(0xFFD500FE)
                                        ]),
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                                topStart: Radius.circular(7),
                                                topEnd: Radius.circular(7),
                                                bottomStart: Radius.circular(7),
                                                bottomEnd: Radius.circular(7))),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: "",
                                        children: [
                                          WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Container(
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 2),
                                              child: Image.asset(
                                                Assets.iconDiamond,
                                                width: 12,
                                                height: 12,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                "${widget.anchor.charge ?? 0}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    AppConstants.fontsBold,
                                                fontSize: 14),
                                          ),
                                          TextSpan(
                                            text: Tr.app_video_time_unit.tr,
                                            style: const TextStyle(
                                                color: Colors.white60,
                                                fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
