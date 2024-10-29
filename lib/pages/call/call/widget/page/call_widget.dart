import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtc/index.dart';
//import 'package:oliapro/agora/rtc5.2.0/index.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/pages/call/call/widget/build_time_count.dart';
import 'package:oliapro/pages/call/call/widget/call_follow_tip.dart';
import 'package:oliapro/pages/call/call/widget/call_footer_tool.dart';
import 'package:oliapro/pages/call/call/widget/call_header_tool.dart';
import 'package:oliapro/pages/call/call/widget/page/build_ask_gift.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../widget/app_net_image.dart';

class CallWidget extends GetView<CallLogic> {
  const CallWidget({super.key});

  bool get isShow =>
      (UserInfo.to.myDetail?.isVip == 1 && !controller.switchView);

  // bool get isShow => true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<CallLogic>(
            id: CallLogic.idAgora,
            init: CallLogic(),
            builder: (controller) {
              return Stack(
                children: [
                  if (controller.audioMode.value)
                    Positioned.fill(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          AppNetImage(
                            controller.detail?.portrait ?? "",
                            placeholder: (context, imageurl) =>
                                const SizedBox.shrink(),
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                            imageBuilder: (context, provider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: provider,
                                    //背景图片
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    //背景滤镜
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10), //背景模糊化
                                    child: Container(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.baseColorItem.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(() {
                                  return controller.callTime.value == 0
                                      ? const SizedBox.shrink()
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 7),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFFE2C55),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                              ),
                                              Text(
                                                sprintf(" %02i:%02i", [
                                                  controller.callTime.value
                                                          .abs() %
                                                      3600 ~/
                                                      60,
                                                  controller.callTime.value
                                                          .abs() %
                                                      60
                                                ]),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        );
                                }),
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(top: 10),
                                  child: Text(
                                    Tr.app_video_voice_switch.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  if (!controller.audioMode.value)
                    Positioned.fill(
                        child: controller.switchView
                            ? AgoraLocalVideoView(
                                engine: controller.rtcEngine,
                              )
                            : AgoraRemoteVideoView(
                                engine: controller.rtcEngine,
                                uid: int.parse(controller.herId),
                                channelId: controller.channelId)),
                  PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: CallFooterTool(
                        smallWindowItem: const SizedBox.shrink(),
                        giftIconUrl: controller.giftToQuickSend.value.icon,
                        //audioMode: controller.audioMode.value,
                        // screenClearMode: controller.screenClearMode,
                        callBack: (CallToolEvent event) {
                          switch (event) {
                            case CallToolEvent.toolEventDiamond:
                              controller.clickCharge();
                              break;
                            case CallToolEvent.toolEventGift:
                              controller.clickGift();
                              break;
                            case CallToolEvent.toolEventOneGift:
                              controller.quickSendGift();
                              break;
                            default:
                              break;
                          }
                        },
                        controller: controller,
                        logic: null,
                        isShow: ((controller.showCount2Min.value ?? 0) > 0),
                      )),
                  PositionedDirectional(
                    start: controller.toLeft,
                    bottom: controller.toBottom,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        GestureDetector(
                            onPanUpdate: controller.onPanUpdate,
                            onTap: controller.switchBig,
                            child: Container(
                              width: 105,
                              height: 155,
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsetsDirectional.only(
                                  top: 0, bottom: 0),
                              foregroundDecoration: isShow
                                  ? const BoxDecoration(
                                      image: DecorationImage(
                                          matchTextDirection: true,
                                          fit: BoxFit.fill,
                                          image: ExactAssetImage(
                                              Assets.iconCallVipFrame)))
                                  : const BoxDecoration(),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: isShow
                                          ? Colors.transparent
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(8)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  child: !controller.switchView
                                      ? AgoraLocalVideoView(
                                          engine: controller.rtcEngine,
                                        )
                                      : AgoraRemoteVideoView(
                                          engine: controller.rtcEngine,
                                          uid: int.parse(controller.herId),
                                          channelId: controller.channelId,
                                        ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  if (!controller.screenClearMode)
                    PositionedDirectional(
                        top: 95,
                        start: 15,
                        child: Obx(
                            () => BuildTimeCount(controller.callTime.value)))
                ],
              );
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => CallFollowTip(
                  logic: controller,
                  type: controller.callDialogToolType.value,
                  netImage: controller.callDialogToolType.value ==
                          CallDialogToolType.follow
                      ? controller.detail?.portrait
                      : controller.callDialogToolType.value ==
                              CallDialogToolType.askGift
                          ? controller.askGiftDetail?.icon
                          : null,
                  count2MinLeft: controller.count2MinLeft.value,
                  gift: controller.askGiftDetail,
                  callBack: (send) {
                    if (send) {
                      switch (controller.callDialogToolType.value) {
                        case CallDialogToolType.follow:
                          controller.handleFollow();
                          break;
                        case CallDialogToolType.gift:
                          controller.clickGift();
                          break;
                        case CallDialogToolType.askGift:
                          controller.sendGift(controller.askGiftDetail!);
                          break;
                        case CallDialogToolType.countDown:
                          controller.clickCharge();
                          break;
                        default:
                          break;
                      }
                    }
                    controller.callDialogToolType.value =
                        CallDialogToolType.none;
                  },
                )),
            Expanded(
                child: GetBuilder<CallLogic>(
                    id: "askGift",
                    init: CallLogic(),
                    builder: (logic) {
                      return Container(
                        margin: const EdgeInsetsDirectional.only(top: 40),
                        child: ListView.builder(
                            padding: EdgeInsetsDirectional.zero,
                            itemCount: logic.askGiftsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BuildAskGift(
                                  data: logic.askGiftsList[index],
                                  logic: logic,
                                  i: 10);
                            }),
                      );
                    }))
          ],
        )
      ],
    );
  }
}
