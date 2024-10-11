import 'package:flutter/material.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';

class GiftPlay extends StatelessWidget {
  final AnchorDetailLogic logic;
  final Widget child;

  const GiftPlay({super.key, required this.child, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        child,
        Positioned.fill(
            child: AppVapPlayer(
          vapController: logic.myVapController,
        ))
      ],
    );
  }
}
