import 'package:flutter/material.dart';
import 'package:oliapro/pages/widget/bounce_widget.dart';
import 'package:oliapro/utils/app_extends.dart';

class LineState extends StatelessWidget {
  final int lineState;
  final double? r;

  const LineState(this.lineState, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (lineState == LineType.online.number)
          BounceWidget(
            child: Container(
              width: r ?? 12,
              height: r ?? 12,
              decoration: BoxDecoration(
                  color: const Color(0xFF13D411),
                  borderRadius: BorderRadiusDirectional.circular(20),
                  border: Border.all(color: Colors.transparent, width: 1)),
            ),
          ),
        if (lineState == LineType.busy.number)
          Container(
            width: r ?? 12,
            height: r ?? 12,
            decoration: BoxDecoration(
                color: const Color(0xFFF447FF),
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(color: Colors.transparent, width: 1)),
          ),
        if (lineState == LineType.offline.number)
          Container(
            width: r ?? 12,
            height: r ?? 12,
            decoration: BoxDecoration(
                color: const Color(0xFF929292),
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(color: Colors.transparent, width: 1)),
          ),
      ],
    );
  }
}
