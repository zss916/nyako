import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/remote/index.dart';
import 'package:oliapro/pages/call/remote/widget/base_remote_portrait.dart';
import 'package:oliapro/pages/call/remote/widget/build_avatar_bg.dart';
import 'package:oliapro/pages/call/remote/widget/build_backgrand.dart';
import 'package:oliapro/pages/call/remote/widget/build_free_tip.dart';
import 'package:oliapro/pages/call/remote/widget/build_free_tip2.dart';

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
                alignment: AlignmentDirectional.center,
                children: [
                  const BuildAvatarBg(),
                  Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 0),
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
            /*Container(
              margin: const EdgeInsetsDirectional.only(top: 10),
              child: BuildCallPrice(price: logic.detail.charge),
            ),*/
            const Spacer(),
            //  if (logic.freeTip == 2) const BuildTip(),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 60),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => logic.hangUp(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            if (logic.freeTip == 1)
                              const SizedBox(
                                height: 35,
                              ),
                            if (logic.freeTip == 2)
                              const SizedBox(
                                height: 44,
                              ),
                          ],
                        ),
                        Image.asset(
                          Assets.iconHangUp,
                          matchTextDirection: true,
                          height: 84,
                          width: 84,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => logic.toPickUp(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              if (logic.freeTip == 1) const BuildFreeTip(),
                              if (logic.freeTip == 2) const BuildFreeTip2(),
                            ],
                          ),
                          RepaintBoundary(
                            child: Lottie.asset(
                              Assets.jsonAnimaPickUp,
                              width: 84,
                              height: 84,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
