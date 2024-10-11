import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class FollowBtn2 extends StatefulWidget {
  final bool isFollowed;

  const FollowBtn2({super.key, required this.isFollowed});

  @override
  State<FollowBtn2> createState() => _FollowBtnState2();
}

class _FollowBtnState2 extends State<FollowBtn2> {
  @override
  Widget build(BuildContext context) {
    return widget.isFollowed == true
        ? Image.asset(
            Assets.imgFollowed2,
            width: 36,
            height: 36,
            matchTextDirection: true,
          )
        : Image.asset(
            Assets.imgFollow2,
            matchTextDirection: true,
            width: 36,
            height: 36,
          );
  }
}
