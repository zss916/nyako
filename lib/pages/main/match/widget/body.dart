import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/pages/main/match/widget/bubbles/bubbles.dart';
import 'package:oliapro/routes/a_routes.dart';

class GameBody extends StatelessWidget {
  final MatchLogic logic;

  GameBody(this.logic, {super.key});

  SwiperController swiperCtrl = SwiperController();

  bool get isSmall => ScreenUtil().screenHeight < 600;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin:
              const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 66),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(24),
              color: const Color(0xFF9341FF)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                  top: 90,
                  left: 60,
                  right: 60,
                  bottom: 90,
                  child: FloatingBubbles.alwaysRepeating(
                    noOfBubbles: 10,
                    colorsOfBubbles: [
                      Colors.green.withAlpha(30),
                      Colors.red,
                    ],
                    sizeFactor: 0.16,
                    duration: 0,
                    opacity: 100,
                    paintingStyle: PaintingStyle.fill,
                    strokeWidth: 8,
                    shape: BubbleShape.circle,
                    speed: BubbleSpeed.slow,
                  )),
              Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsetsDirectional.all(10),
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                        color: const Color(0xFF25203A),
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "剩余10次",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "获取更多次数",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFFDCC2FF), fontSize: 13),
                            )),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 10),
                              child: Image.asset(
                                Assets.iconNextP,
                                matchTextDirection: true,
                                width: 18,
                                height: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  UnconstrainedBox(
                    child: InkWell(
                      onTap: () => ARoutes.toMatching(),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 40, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                        child: Text(
                          "开始匹配",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              )
            ],
          ),
        ),
        PositionedDirectional(
            bottom: 55,
            start: 20,
            end: 20,
            child: Image.asset(
              Assets.iconMatchForeground,
              matchTextDirection: true,
            ))
      ],
    );
  }
}
