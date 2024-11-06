import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/call/local/index.dart';
import 'package:nyako/pages/call/local/widget/base_local_portrait.dart';
import 'package:nyako/pages/call/local/widget/build_call_price.dart';
import 'package:nyako/pages/call/remote/widget/build_backgrand.dart';

class Body extends StatelessWidget {
  final LocalLogic logic;

  const Body(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned.fill(
          child: BuildBackgrand(logic.portrait),
        ),
        Positioned.fill(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsetsDirectional.only(top: 100),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 15),
                      child: BaseLocalPortrait(
                          logic.showPortrait, logic.detail.lineState()),
                    ),
                    // if (logic.detail.followed != null) Follow(logic.detail)
                  ],
                )),
            //AgeAndSex(logic.detail.showBirthday),
            Container(
              margin:
                  const EdgeInsetsDirectional.only(top: 20, start: 15, end: 15),
              child: Text(
                logic.showNick,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
              child: BuildCallPrice(price: logic.detail.charge),
            ),
            Obx(() => Text(
                  logic.waitingStr.value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => logic.toHangUp(),
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 45, bottom: 60),
                child: Image.asset(
                  Assets.iconHangUp,
                  height: 84,
                  width: 84,
                  matchTextDirection: true,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
