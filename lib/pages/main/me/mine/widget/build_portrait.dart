import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';
import 'package:oliapro/pages/main/me/mine/widget/avatar_state.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildPortrait extends StatelessWidget {
  final MeLogic logic;
  const BuildPortrait(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => logic.toEdit(),
      child: buildContent(state: AvatarStatusHand.getType()),
    );
  }

  Widget buildContent({int state = 0}) {
    return switch (state) {
      _ when state == AvatarStatus.vip.index => Container(
          width: 100,
          height: 100,
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  matchTextDirection: true,
                  image: ExactAssetImage(
                    Assets.frameVipFrame,
                  ))),
          child: Center(
            child: Container(
              width: 84,
              height: 84,
              margin: const EdgeInsetsDirectional.only(bottom: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: cachedImage(logic.state.portrait, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      _ when state == AvatarStatus.sign.index => Container(
          width: 100,
          height: 100,
          padding: const EdgeInsetsDirectional.only(top: 0),
          foregroundDecoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  matchTextDirection: true,
                  image: ExactAssetImage(
                    Assets.frameSignFrame,
                  ))),
          child: Center(
            child: Container(
              width: 84,
              height: 84,
              alignment: AlignmentDirectional.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: cachedImage(logic.state.portrait,
                    type: 8, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      _ when state == AvatarStatus.common.index => Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: cachedImage(logic.state.portrait, fit: BoxFit.cover),
          ),
        ),
      _ => Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: cachedImage(logic.state.portrait, fit: BoxFit.cover),
          ),
        ),
    };
  }
}
