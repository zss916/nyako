import 'package:flutter/material.dart';
import 'package:oliapro/generated/assets.dart';

class Black extends StatelessWidget {
  const Black({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
      child: Image.asset(
        Assets.iconCloseDialog,
        matchTextDirection: true,
        width: 36,
        height: 36,
      ),
    );
  }
}
