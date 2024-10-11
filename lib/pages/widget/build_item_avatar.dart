import 'package:flutter/material.dart';
import 'package:oliapro/pages/widget/base_portrait.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildItemAvatar extends StatelessWidget {
  final String url;
  final int lineState;
  final double? r;

  const BuildItemAvatar(this.url, this.lineState, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          child:
              BasePortrait(url, LineType.other.number, r: r ?? 42, radius: 50),
        ),
      ],
    );
  }
}
