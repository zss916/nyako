import 'package:flutter/material.dart';
import 'package:nyako/pages/widget/base_portrait.dart';
import 'package:nyako/pages/widget/line_state.dart';

class BuildAvatar extends StatelessWidget {
  String url;
  int lineState;

  BuildAvatar(this.url, this.lineState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          child: BasePortrait(url, -1),
        ),
        PositionedDirectional(bottom: 0, end: 0, child: LineState(lineState))
      ],
    );
  }
}
