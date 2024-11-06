import 'package:flutter/material.dart';
import 'package:nyako/pages/widget/bounce_widget.dart';
import 'package:nyako/utils/app_extends.dart';

class LineState extends StatelessWidget {
  final int lineState;
  final double? r;

  const LineState(this.lineState, {super.key, this.r});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (lineState == LineType.online.number)
          BounceWidget(
            child: Container(
              width: r ?? 12,
              height: r ?? 12,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(color: Color(0xFF4CE263), blurRadius: 6)
                  ],
                  color: const Color(0xFF4CE263),
                  borderRadius: BorderRadiusDirectional.circular(20),
                  border: Border.all(color: Colors.white, width: 1)),
            ),
          ),
        if (lineState == LineType.busy.number)
          Container(
            width: r ?? 12,
            height: r ?? 12,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Color(0xFFFF3CF0), blurRadius: 6)
                ],
                color: const Color(0xFFFF3CF0),
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(color: Colors.white, width: 1)),
          ),
        if (lineState == LineType.offline.number)
          Container(
            width: r ?? 12,
            height: r ?? 12,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Color(0xFFD5D6D7), blurRadius: 6)
                ],
                color: const Color(0xFFD5D6D7),
                borderRadius: BorderRadiusDirectional.circular(20),
                border: Border.all(color: Colors.white, width: 1)),
          ),
      ],
    );
  }
}
