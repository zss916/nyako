import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/match/index.dart';
import 'package:nyako/pages/main/match/widget/bubbles/bubbles.dart';

class GameBody extends StatelessWidget {
  final MatchLogic logic;

  GameBody(this.logic, {super.key});

  final String getMoreTip = "获取更多次数";

  // bool get isSmall => ScreenUtil().screenHeight < 600;

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
                      Colors.green.withAlpha(100),
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
                  GestureDetector(
                    onTap: () {
                      sheetToVip(
                          path: ChargePath.recharge_vip_dialog_match, index: 0);
                    },
                    child: Container(
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
                          GetBuilder<MatchLogic>(
                              id: "count",
                              init: MatchLogic(),
                              builder: (logic) {
                                return logic.isUserVip
                                    ? const SizedBox.shrink()
                                    : Text(
                                        Tr.appTimesLeft
                                            .trArgs(["${(10 - logic.count)}"]),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: AppConstants.fontsBold,
                                            fontWeight: FontWeight.bold),
                                      );
                              }),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                getMoreTip,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppConstants.fontsRegular,
                                    color: const Color(0xFFDCC2FF),
                                    fontSize: 13),
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
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                        start: 20, end: 20, bottom: 20, top: 40),
                    child: Obx(() => Text(
                          Tr.appPeopleOnline
                              .trArgs(["${logic.currentOnline.value}"]),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  UnconstrainedBox(
                    child: InkWell(
                      onTap: () {
                        logic.toMatch(logic);
                      },
                      //onTap: () => ARoutes.toMatching(),
                      child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 145, minHeight: 46),
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 30),
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 40, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                        child: Text(
                          Tr.app_match_start.tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstants.fontsBold,
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
            )),
      ],
    );
  }
}
