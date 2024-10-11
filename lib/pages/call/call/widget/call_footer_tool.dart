import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/index.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/widget/app_net_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'call_header_tool.dart';

class CallFooterTool extends StatefulWidget {
  final Widget smallWindowItem;

  // final bool audioMode;
  // final bool screenClearMode;
  final CallLogic? controller;

  final AivLogic? logic;

  final Function(CallToolEvent event) callBack;
  final String? giftIconUrl;
  final bool isShow;

  const CallFooterTool(
      {Key? key,
      required this.smallWindowItem,
      //required this.audioMode,
      // required this.screenClearMode,
      required this.controller,
      required this.logic,
      required this.callBack,
      required this.giftIconUrl,
      required this.isShow})
      : super(key: key);

  @override
  State<CallFooterTool> createState() => _CallFooterToolState();
}

class _CallFooterToolState extends State<CallFooterTool> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 35),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.controller != null)
                Obx(() => widget.controller!.audioMode.value
                    ? const SizedBox.shrink()
                    : widget.smallWindowItem),
              if (widget.controller != null)
                GetBuilder<CallLogic>(
                    init: CallLogic(),
                    builder: (logic) {
                      return logic.screenClearMode
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                widget.callBack(CallToolEvent.toolEventOneGift);
                              },
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle),
                                alignment: AlignmentDirectional.center,
                                child: Center(
                                  child: AppNetImage(
                                    widget.giftIconUrl ?? "",
                                    width: 40,
                                    height: 40,
                                    placeholderAsset: Assets.imgAppLogo,
                                  ),
                                ),
                              ),
                            );
                    }),
              if (widget.logic != null)
                GetBuilder<AivLogic>(
                    init: AivLogic(),
                    builder: (logic) {
                      return logic.screenClearMode
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                widget.callBack(CallToolEvent.toolEventOneGift);
                              },
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle),
                                alignment: AlignmentDirectional.center,
                                child: Center(
                                  child: AppNetImage(
                                    widget.giftIconUrl ?? "",
                                    width: 40,
                                    height: 40,
                                    placeholderAsset: Assets.imgAppLogo,
                                  ),
                                ),
                              ),
                            );
                    }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        widget.callBack(CallToolEvent.toolEventDiamond);
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.black45, shape: BoxShape.circle),
                        child: Image.asset(
                          Assets.imgBigDiamond,
                          matchTextDirection: true,
                          width: 35,
                          height: 35,
                        ),
                      )),
                  if (widget.isShow)
                    Obx(() => GestureDetector(
                          onTap: () {
                            widget.callBack(CallToolEvent.toolEventDiamond);
                          },
                          child: SizedBox(
                            width: 57,
                            height: 57,
                            child: CircularPercentIndicator(
                              radius: 28,
                              reverse: true,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              animationDuration: 0,
                              percent:
                                  (widget.controller?.count2MinLeft.value ??
                                          0) /
                                      60,
                              lineWidth: 2,
                              widgetIndicator: point(),
                              backgroundColor: Colors.white10,
                              progressColor: const Color(0xFFFE2C55),
                            ),
                          ),
                        ))
                ],
              ),
              (widget.isShow)
                  ? Expanded(
                      child: Obx(() => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text.rich(TextSpan(
                                text: Tr.app_video_time_to_charge_1.tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                                children: [
                                  TextSpan(
                                      text:
                                          "${widget.controller?.count2MinLeft.value}",
                                      style: const TextStyle(
                                          color: Color(0xFFFE2C55),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: Tr.app_video_time_to_charge_2.tr),
                                ])),
                          )),
                    )
                  : const Spacer(),
              GestureDetector(
                  onTap: () {
                    widget.callBack(CallToolEvent.toolEventGift);
                  },
                  child: RepaintBoundary(
                    child: Image.asset(
                      Assets.animaGift,
                      matchTextDirection: true,
                      width: 55,
                      height: 55,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  //进度条的点
  Widget point() {
    return UnconstrainedBox(
      child: Container(
        width: 6,
        height: 6,
        margin: const EdgeInsetsDirectional.only(start: 5),
        decoration: BoxDecoration(
            color: const Color(0xFFFE2C55),
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Colors.transparent, width: 0)),
      ),
    );
  }
}
