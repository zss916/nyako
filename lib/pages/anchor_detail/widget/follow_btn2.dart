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
    return Container(
      height: 36,
      width: 60,
      margin: const EdgeInsetsDirectional.only(start: 10),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          color: widget.isFollowed
              ? const Color(0xFFF5F4F6)
              : const Color(0xFF9341FF),
          borderRadius: BorderRadiusDirectional.circular(13)),
      child: Image.asset(
        widget.isFollowed ? Assets.iconFollowedIc : Assets.iconFollowIc,
        width: 24,
        height: 24,
        matchTextDirection: true,
      ),
    );
  }
}
