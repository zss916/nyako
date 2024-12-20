import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/utils/app_extends.dart';

class BaseMsgPortrait extends StatelessWidget {
  final String portrait;
  final int lineState;
  const BaseMsgPortrait(this.portrait, this.lineState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsetsDirectional.all(0),
      decoration: BoxDecoration(
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(Assets.iconAnchorDefault)),
        borderRadius: BorderRadius.circular((60)), // 圆角
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: cachedImage(portrait, fit: BoxFit.cover),
      ),
    );
  }

  Color getColor(int lineState) {
    if (lineState == LineType.online.number) {
      return const Color(0xFFB1FF5C);
    } else if (lineState == LineType.busy.number) {
      return const Color(0xFFFF8A56);
    } else if (lineState == LineType.offline.number) {
      return const Color(0xFFCAC5CA);
    } else {
      return const Color(0xFF49E1CC);
    }
  }
}
