import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class BasePortrait extends StatelessWidget {
  final String portrait;
  final int lineState;
  final double? r;
  final double? radius;

  const BasePortrait(this.portrait, this.lineState,
      {super.key, this.r, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: r ?? 72,
      height: r ?? 72,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsetsDirectional.all(2),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: getColor(lineState), width: 2), // border
        borderRadius: BorderRadius.circular((radius ?? 50)), // 圆角
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 50),
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
