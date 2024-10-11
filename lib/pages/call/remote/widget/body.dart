import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/local/widget/build_call_price.dart';
import 'package:oliapro/pages/call/remote/index.dart';
import 'package:oliapro/pages/call/remote/widget/base_remote_portrait.dart';
import 'package:oliapro/pages/call/remote/widget/build_backgrand.dart';
import 'package:oliapro/pages/call/remote/widget/build_free_tip.dart';
import 'package:oliapro/pages/call/remote/widget/build_free_tip2.dart';
import 'package:oliapro/pages/call/remote/widget/build_tip.dart';
import 'package:oliapro/utils/app_some_extension.dart';

class Body extends StatelessWidget {
  final RemoteLogic logic;

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
              margin: const EdgeInsetsDirectional.only(top: 85),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 15),
                    child: BaseRemotePortrait(
                        logic.portrait, logic.detail.lineState()),
                  ),
                  // if (logic.detail.followed != null) Follow(logic.detail)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 15, bottom: 5),
              child: Text(
                logic.showNick,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //AgeAndSex(logic.detail.showBirthday),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 10),
              child: BuildCallPrice(price: logic.detail.charge),
            ),
            const Spacer(),
            if (logic.freeTip == 2) const BuildTip(),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => logic.hangUp(),
                    child: Image.asset(
                      Assets.imgHangUp,
                      matchTextDirection: true,
                      height: 75,
                      width: 75,
                    ),
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => logic.toPickUp(),
                      child: RepaintBoundary(
                        child: Image.asset(
                          Assets.animaPickUp,
                          matchTextDirection: true,
                          height: 75 + 25,
                          width: 75 + 25,
                        ),
                      )),
                ],
              ),
            ),
          ],
        )),
        if (logic.freeTip == 1 && Get.locale?.languageCode != "hi")
          PositionedDirectional(
              bottom: Get.isTr ? 140 : 130,
              end: Get.isTr ? 25 : 65,
              child: const BuildFreeTip()),
        if (logic.freeTip == 1 && Get.locale?.languageCode == "hi")
          const PositionedDirectional(
              bottom: 130, end: 85, child: BuildFreeTip2()),
      ],
    );
  }
}
