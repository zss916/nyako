import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/app_extends.dart';

class BaseRemotePortrait extends StatelessWidget {
  final String portrait;
  final int lineState;
  final double? r;

  const BaseRemotePortrait(this.portrait, this.lineState, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: r ?? 106,
      height: r ?? 106,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsetsDirectional.all(0),
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(Assets.imgAnchorDefaultAvatar)),
        color: Colors.transparent,
        border: Border.all(color: Colors.white, width: 1), // border
        borderRadius: BorderRadius.circular((100)), // 圆角
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: cachedImage(portrait, fit: BoxFit.cover),
      ),
    );
  }

  Color getColor(int lineState) {
    if (lineState == LineType.online.number) {
      return const Color(0xFF00C900);
    } else if (lineState == LineType.busy.number) {
      return const Color(0xFFF45240);
    } else if (lineState == LineType.offline.number) {
      return const Color(0xFFCAC5CA);
    } else {
      return Colors.transparent;
    }
  }
}
