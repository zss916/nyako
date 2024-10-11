import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_draw_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/lottery/index.dart';
import 'package:oliapro/pages/main/me/lottery/widget/draw_dialog.dart';
import 'package:oliapro/routes/a_routes.dart';

import 'lucky_draw_paint.dart';

class LotteryBody extends StatefulWidget {
  final LotteryLogic logic;

  const LotteryBody(this.logic, {super.key});

  @override
  State<LotteryBody> createState() => _LotteryBodyState();
}

class _LotteryBodyState extends State<LotteryBody>
    with SingleTickerProviderStateMixin {
  static const double radius = 120;
  final int _circleTime = 12;
  double _angle = 0;
  double _prizeResult = 0;
  late AnimationController _angleController;
  late Animation<double> _angleAnimation;
  int userLotteryCount = 0;
  double get _prizeResultPi {
    return _prizeResult * pi * 2;
  }

  @override
  void initState() {
    super.initState();
    _angleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    _angleAnimation =
        CurvedAnimation(parent: _angleController, curve: Curves.easeOutCirc)
          ..addListener(() {
            if (mounted) {
              setState(() {
                _angle = _angleAnimation.value * _circleTime;
              });
            }
          })
          ..addStatusListener((status) async {
            if (status == AnimationStatus.completed) {}
          });
  }

  @override
  void dispose() {
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 60,
        ),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Obx(
              () => Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      Assets.lotteryLotteryInfoBg,
                      matchTextDirection: true,
                    ),
                    Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        margin: const EdgeInsetsDirectional.only(
                            top: 0, bottom: 45),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          Tr.app_lottery_title
                              .trArgs(["${widget.logic.drawNum.value}"]),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          maxFontSize: 14,
                          minFontSize: 7,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 123),
              child: Image.asset(
                Assets.lotteryLotteryDrawB,
                width: 375,
                height: 375,
                matchTextDirection: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 410,
                    // color: Colors.white,
                    /*decoration: BoxDecoration(
              image: DecorationImage(image: ExactAssetImage(Assets.lotteryBg))),*/
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          top: 15,
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Image.asset(
                                Assets.lotteryLotteryDrawBg,
                                width: 287,
                                height: 287,
                                matchTextDirection: true,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: GestureDetector(
                              child: Container(
                                width: 180,
                                height: 64,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 5),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        matchTextDirection: true,
                                        image: ExactAssetImage(
                                            Assets.lotteryLotteryBtn))),
                                child: isClick
                                    ? Obx(() => AutoSizeText(
                                          "${Tr.app_to_lottery.tr}(${widget.logic.num.value})",
                                          maxLines: 1,
                                          maxFontSize: 18,
                                          minFontSize: 8,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))
                                    : const AutoSizeText(
                                        "...",
                                        maxLines: 1,
                                        maxFontSize: 18,
                                        minFontSize: 8,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                              onTap: () => goDraw(),
                            )),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.maxFinite,
                            height: radius * 2,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.none,
                                  children: [
                                    const SizedBox(
                                      width: 130,
                                      height: 130,
                                    ),
                                    GetBuilder<LotteryLogic>(
                                      assignId: true,
                                      init: LotteryLogic(),
                                      builder: (logic) {
                                        return logic.draw.isEmpty
                                            ? const SizedBox.shrink()
                                            : RepaintBoundary(
                                                child: Transform.rotate(
                                                  angle: _angle * (pi * 2) -
                                                      _prizeResultPi,
                                                  child: CustomPaint(
                                                    size: const Size.fromRadius(
                                                        radius),
                                                    painter: LuckyDrawPaint(
                                                        selectSize:
                                                            logic.draw.length,
                                                        colors: logic.draw
                                                            .map((e) =>
                                                                e.color ??
                                                                Colors
                                                                    .transparent)
                                                            .toList(),
                                                        contents: logic.draw
                                                            .map((e) =>
                                                                e.content ?? "")
                                                            .toList(),
                                                        images: logic.draw
                                                            .map((e) => e.image)
                                                            .toList()),
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
                                    Positioned(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          Assets.lotteryLotteryPointer,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 130),
              child: Image.asset(
                Assets.lotteryLotteryDrawF,
                width: 355,
                height: 355,
                matchTextDirection: true,
              ),
            ),
          ],
        ),
        /* Obx(
          () => Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              Tr.app_lottery_num.trArgs(['${widget.logic.num.value}']),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),*/
        GestureDetector(
          onTap: () => ARoutes.toRecharge(),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0x1AC3A0FF)),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 15, vertical: 12),
            margin: const EdgeInsetsDirectional.only(
                bottom: 40, start: 20, end: 20, top: 30),
            child: Text(
              Tr.app_lottery_hint.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFC3A0FF),
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFC3A0FF),
                //decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 开始抽奖
  bool isClick = true;
  void goDraw() {
    if (isClick) {
      widget.logic.toDraw((index, data) {
        if (mounted) {
          setState(() {
            isClick = false;
          });
        }
        _prizeResult = (index / widget.logic.draw.length) +
            _midTweenDouble(widget.logic.draw);
        _angleController.forward(from: 0);
        Future.delayed(const Duration(seconds: 3), () {
          //showDrawResult(0);
          toDrawDialog(data);
          if (mounted) {
            setState(() {
              isClick = true;
            });
          }
        });
      });
    }
  }

  double _midTweenDouble(List<DrawData> draw) {
    if (draw.isEmpty) {
      return 0;
    }
    double piTween = 1 / draw.length;
    double midTween = piTween / 2;
    return midTween;
  }
}
