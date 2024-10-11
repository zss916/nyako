import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vap2/flutter_vap.dart';
//import 'package:flutter_vap2/vap_view.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/discover/widget/discover/age_and_sex.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/pages/main/match/result/widget/app_net_video.dart';
import 'package:oliapro/pages/main/match/result/widget/build_call_button.dart';
import 'package:oliapro/pages/main/match/result/widget/follow.dart';
import 'package:oliapro/pages/main/match/result/widget/state_widget.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/routes/a_routes.dart';
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

  bool isVisible = false;

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
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isPlay = false;
        isVisible = true;
      });
    });

    _playFile(Assets.matchMatchVap);
    // _playFile(Assets.matchMatch);
  }

  @override
  void dispose() {
    ScreenProtectorUtil.off();
    AppConstants.isMatching = false;
    MatchMusicManager.instance.stop();
    reportEvent.cancel();
    BgmControl.setMatchVolume(true);
    BgmControl.callInBgmStart();
    _stopFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                matchPlay(),
                // const MatchVap(),
              ],
            ),
            Visibility(visible: isVisible, child: body()),
          ],
        ),
      ),
    );
  }

  VapViewController? vapViewController;
  bool isPlay = false;

  Widget matchPlay() {
    return isPlay
        ? IgnorePointer(
            child: VapViewB(onVapViewCreated: (controller) {
              vapViewController = controller;
            }),
          )
        : const SizedBox.shrink();
  }

  Future<Map<dynamic, dynamic>?> _playFile(String path) async {
    if (mounted) {
      setState(() {
        isPlay = true;
      });
      try {
        Future.delayed(const Duration(seconds: 1)).then((value) async {
          var res = await vapViewController?.playAsset(path);
          res?.forEach((key, value) {
            print("giftError---------> $key $value");
          });
        });
        return null;
      } catch (e) {
        print("giftError---------> $e");
      }
    }
    return null;
  }

  _stopFile() {
    try {
      if (mounted) {
        setState(() {
          isPlay = false;
        });
        vapViewController?.stop();
      }
    } catch (e) {
      print("giftError---------> $e");
    }
  }

  Widget body() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: 305.w,
                height: 445.h,
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 0, vertical: 0),
                padding: const EdgeInsetsDirectional.all(0),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(20)),
                    color: Colors.black),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(widget.anchor.showPortrait),
                          fit: BoxFit.cover)),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(18)),
                    child: AppNetVideo(
                      widget.anchor.showVideo,
                      double.maxFinite,
                      double.maxFinite,
                      showLoading: true,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                  top: 12,
                  start: 12,
                  child: GestureDetector(
                    onTap: () => ARoutes.toReport(
                        uid: widget.anchor.getUid,
                        type: ReportEnum.match.index.toString()),
                    child: Image.asset(
                      Assets.imgCallReport,
                      width: 30,
                      height: 30,
                      matchTextDirection: true,
                    ),
                  )),
              PositionedDirectional(
                  top: 12,
                  end: 12,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      Assets.imgCallClose,
                      width: 30,
                      height: 30,
                      matchTextDirection: true,
                    ),
                  )),
              PositionedDirectional(
                  bottom: 1,
                  start: 1,
                  end: 1,
                  child: Container(
                    padding:
                        const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                              Colors.black26,
                              Colors.black38,
                              Colors.black45,
                              Colors.black54,
                              Colors.black54,
                              Colors.black54,
                            ]),
                        borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(20),
                            bottomEnd: Radius.circular(20))),
                    child: InkWell(
                      onTap: () => ARoutes.toAnchorDetail(widget.anchor.getUid),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 3),
                            child: Container(
                              width: 44,
                              height: 44,
                              margin: const EdgeInsetsDirectional.only(
                                  end: 5, start: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          widget.anchor.showPortrait))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 3),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                end: 4),
                                        constraints:
                                            const BoxConstraints(maxWidth: 180),
                                        child: AutoSizeText(
                                          widget.anchor.showNickName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          maxFontSize: 14,
                                          minFontSize: 14,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Follow(widget.anchor)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      AgeAndSex(
                                        age: widget.anchor.showBirthday,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  start: 3, top: 3),
                                          child: widget.anchor.isOnline == null
                                              ? const SizedBox.shrink()
                                              : StateWidget(
                                                  widget.anchor.lineState(),
                                                  widget.anchor.stateStr)),
                                    ],
                                  )
                                ]),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          BuildCallButton(widget.anchor),
          Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Get.back();
                  widget.onRestart?.call();
                },
                child: Container(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Text(
                    Tr.appOnceAgain.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                )),
          )
        ],
      );
}
