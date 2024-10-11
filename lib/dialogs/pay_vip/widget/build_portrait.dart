import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildPortrait extends StatelessWidget {
  final String? portrait;

  const BuildPortrait({super.key, this.portrait});

  @override
  Widget build(BuildContext context) {
    return avatar();
  }

  Widget avatar() => Container(
        width: 36,
        height: 36,
        margin: const EdgeInsetsDirectional.only(top: 0, start: 0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          // border
          borderRadius: BorderRadius.circular((50)), // 圆角
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: cachedImage(portrait ?? ""),
        ),
      );
}
