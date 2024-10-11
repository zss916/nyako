import 'package:flutter/material.dart';
import 'package:oliapro/pages/widget/line_state.dart';

class StateWidget extends StatelessWidget {
  final int lineState;
  final String state;

  const StateWidget(this.lineState, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return online(lineState, state);
  }

  Widget online(int lineState, String state) {
    return Container(
      alignment: Alignment.center,
      height: 20,
      padding:
          const EdgeInsetsDirectional.only(top: 0, bottom: 0, start: 4, end: 5),
      decoration: const BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 3),
            child: LineState(
              lineState,
              r: 8,
            ),
          ),
          Text(
            state,
            maxLines: 1,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
