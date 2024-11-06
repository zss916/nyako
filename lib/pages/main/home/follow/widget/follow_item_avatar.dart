import 'package:flutter/material.dart';
import 'package:nyako/pages/widget/line_state.dart';
import 'package:nyako/utils/app_extends.dart';

class FollowItemAvatar extends StatelessWidget {
  final String url;
  final int lineState;

  const FollowItemAvatar(this.url, this.lineState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          width: 56,
          height: 56,
          padding: const EdgeInsetsDirectional.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(50),
              border: Border.all(width: 2, color: const Color(0xFFFF3B7A))),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(50),
            child: cachedImage(url, fit: BoxFit.cover),
          ),
        ),
        PositionedDirectional(
            top: 1,
            start: 1,
            child: LineState(
              lineState,
              r: 13,
            ))
      ],
    );
  }
}
