import 'package:flutter/material.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/follow_btn.dart';

class BuildFollow extends StatelessWidget {
  final AnchorDetailLogic logic;

  const BuildFollow(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logic.follow(),
      child: FollowBtn(
        isFollowed: logic.state.host.isFollowed,
      ),
    );
  }
}
