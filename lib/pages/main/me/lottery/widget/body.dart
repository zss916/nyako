import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_draw_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/lottery/index.dart';
import 'package:nyako/pages/main/me/lottery/widget/draw_dialog.dart';
import 'package:nyako/pages/main/me/lottery/widget/gradient_title.dart';
import 'package:nyako/routes/a_routes.dart';

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
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Obx(
              () => Align(
                alignment: Alignment.topCenter,
                child: Container(
                    //constraints: const BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsetsDirectional.only(
                        top: 90, bottom: 45, start: 20, end: 20),
                    alignment: Alignment.center,
                    child: GradientTitle(
                        title: Tr.app_lottery_title
                            .trArgs(["${widget.logic.drawNum.value}"]))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 135),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 470,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                            bottom: 0,
                            child: GestureDetector(
                              child: Container(
                                width: 290,
                                height: 52,
                                alignment: Alignment.center,
                                margin: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10),
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 0),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: AlignmentDirectional.topStart,
                                        end: AlignmentDirectional.bottomEnd,
                                        colors: [
                                          Color(0xFF8E48FF),
                                          Color(0xFFFF35FF),
                                        ]),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30)),
                                child: isClick
                                    ? Obx(() => AutoSizeText(
                                          "${Tr.app_to_lottery.tr}(${widget.logic.num.value})",
                                          maxLines: 1,
                                          maxFontSize: 18,
                                          minFontSize: 8,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily:
                                                  AppConstants.fontsBold,
                                              fontWeight: FontWeight.bold),
                                        ))
                                    : AutoSizeText(
                                        "...",
                                        maxLines: 1,
                                        maxFontSize: 18,
                                        minFontSize: 8,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                              onTap: () => goDraw(),
                            )),
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: Container(
                            //color: Colors.blue,
                            width: Get.width,
                            height: Get.width,
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                PositionedDirectional(
                                    top: 35,
                                    child: GetBuilder<LotteryLogic>(
                                      assignId: true,
                                      init: LotteryLogic(),
                                      builder: (logic) {
                                        return logic.draw.isEmpty
                                            ? Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Transform.rotate(
                                                    angle: 18 * pi / 180.0,
                                                    child: Image.asset(
                                                      Assets.iconDrawBg,
                                                      width: 360,
                                                      height: 360,
                                                      matchTextDirection: true,
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    Assets.lotteryLotteryCenter,
                                                    width: 130,
                                                    height: 130,
                                                    matchTextDirection: true,
                                                  )
                                                ],
                                              )
                                            : RepaintBoundary(
                                                child: Transform.rotate(
                                                  angle: _angle * (pi * 2) -
                                                      _prizeResultPi,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    children: [
                                                      Transform.rotate(
                                                        angle: 18 * pi / 180.0,
                                                        child: Image.asset(
                                                          Assets.iconDrawBg,
                                                          width: 360,
                                                          height: 360,
                                                          matchTextDirection:
                                                              true,
                                                        ),
                                                      ),
                                                      CustomPaint(
                                                        size: const Size
                                                            .fromRadius(radius),
                                                        painter: LuckyDrawPaint(
                                                            selectSize: logic
                                                                .draw.length,
                                                            colors: logic.draw
                                                                .map((e) =>
                                                                    e.color ??
                                                                    Colors
                                                                        .transparent)
                                                                .toList(),
                                                            contents: logic.draw
                                                                .map((e) =>
                                                                    e.content ??
                                                                    "")
                                                                .toList(),
                                                            images: logic.draw
                                                                .map((e) =>
                                                                    e.image)
                                                                .toList()),
                                                      ),
                                                      Image.asset(
                                                        Assets
                                                            .lotteryLotteryCenter,
                                                        width: 130,
                                                        height: 130,
                                                        matchTextDirection:
                                                            true,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                      },
                                    )),
                                PositionedDirectional(
                                    top: 0,
                                    child: Image.asset(
                                      Assets.lotteryLotteryPointer,
                                      width: 90,
                                      height: 90,
                                      matchTextDirection: true,
                                    ))
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
          ],
        ),
        GestureDetector(
          onTap: () => ARoutes.toRecharge(),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 15, vertical: 12),
            margin: const EdgeInsetsDirectional.only(
                bottom: 40, start: 15, end: 15, top: 30),
            child: Text(
              Tr.app_lottery_hint.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0x80FFFFFF),
                fontSize: 14,
                fontFamily: AppConstants.fontsRegular,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0x80FFFFFF),
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
        setState(() {
          isClick = false;
        });
        _prizeResult = (index / widget.logic.draw.length) +
            _midTweenDouble(widget.logic.draw);
        _angleController.forward(from: 0);
        Future.delayed(const Duration(seconds: 3), () {
          //showDrawResult(0);
          toDrawDialog(data);
          setState(() {
            isClick = true;
          });
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
