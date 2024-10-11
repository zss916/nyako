import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/index.dart';
import 'package:oliapro/pages/call/aiv/widget/aiv_camera.dart';
import 'package:oliapro/pages/call/aiv/widget/build_call_sound.dart';
import 'package:oliapro/pages/call/aiv/widget/build_time_count.dart';
import 'package:oliapro/pages/call/aiv/widget/chat_backgrand.dart';
import 'package:oliapro/pages/call/call/widget/call_footer_tool.dart';
import 'package:oliapro/pages/call/call/widget/call_header_tool.dart';

import '../../../../../widget/app_video_player.dart';

class AivWidget extends StatelessWidget {
  final AivLogic logic;

  const AivWidget(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: ChatBackgrand(logic.showPortrait.trim())),
        if (!logic.playFinish)
          Stack(
            children: [
              Positioned.fill(
                  child: logic.switchView
                      ? AivCamera(logic)
                      : AppVideoPlayer(
                          controller: logic.videoController,
                        )),
              PositionedDirectional(
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: CallFooterTool(
                    isShow: false,
                    smallWindowItem: const SizedBox(),
                    // audioMode: false,
                    // screenClearMode: logic.screenClearMode,
                    callBack: (CallToolEvent event) {
                      switch (event) {
                        case CallToolEvent.toolEventDiamond:
                          // debugPrint("clickCharge ====>>> clickCharge3");
                          logic.clickCharge();
                          break;
                        case CallToolEvent.toolEventGift:
                          logic.clickGift();
                          break;
                        case CallToolEvent.toolEventOneGift:
                          logic.quickSendGift();
                          break;
                        default:
                          break;
                      }
                    },
                    controller: null,
                    logic: logic,
                    giftIconUrl: logic.giftToQuickSend.value.icon,
                  )),
              PositionedDirectional(
                  start: logic.toLeft,
                  bottom: logic.toBottom,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      GestureDetector(
                          onPanUpdate: logic.onPanUpdate,
                          onTap: logic.switchBig,
                          child: Container(
                            width: 118,
                            height: 178,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsetsDirectional.only(
                                top: 5, bottom: 5),
                            foregroundDecoration: logic.showVip
                                ? const BoxDecoration(
                                    image: DecorationImage(
                                        matchTextDirection: true,
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                            Assets.imgVipAvatarFornt)))
                                : const BoxDecoration(),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.4, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(8)),
                            child: !logic.switchView
                                ? AivCamera(logic)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: AppVideoPlayer(
                                      controller: logic.videoController,
                                    ),
                                  ),
                          )),
                    ],
                  )),
              if (!logic.screenClearMode) _callSound(logic),
              if (!logic.screenClearMode) _timeCount(logic)
            ],
          )
      ],
    );
  }

  ///AIV 充值解锁
  PositionedDirectional _callSound(AivLogic logic) =>
      PositionedDirectional(top: 130, start: 15, child: BuildCallSound(logic));

  ///时间计时
  PositionedDirectional _timeCount(AivLogic logic) => PositionedDirectional(
        start: 15,
        top: 90,
        child: Obx(() => BuildTimeCount(logic.callTime.value)),
      );
}
