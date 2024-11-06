import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/utils/app_extends.dart';

class BaseLocalPortrait extends StatelessWidget {
  final String portrait;
  final int lineState;
  final double? r;

  const BaseLocalPortrait(this.portrait, this.lineState, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: r ?? 100,
      height: r ?? 100,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsetsDirectional.all(0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
              fit: BoxFit.cover,
              matchTextDirection: true,
              image: ExactAssetImage(Assets.iconAnchorDefault))),
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
