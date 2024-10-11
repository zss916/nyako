import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class StateWidget extends StatelessWidget {
  final int lineState;
  final String state;

  const StateWidget(this.lineState, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (lineState == LineType.online.number) online(state),
        if (lineState == LineType.busy.number) busy(state),
        if (lineState == LineType.offline.number) offline(state),
      ],
    );
  }

  Widget online(String state) {
    return Container(
      alignment: Alignment.center,
      height: 18,
      padding:
          const EdgeInsetsDirectional.only(top: 2, bottom: 2, start: 3, end: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF13D411),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        state,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget busy(String state) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsetsDirectional.only(top: 2, bottom: 2, start: 3, end: 5),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        state,
        maxLines: 1,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget offline(String state) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsetsDirectional.only(top: 2, bottom: 2, start: 3, end: 5),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: AutoSizeText(
        state,
        maxLines: 1,
        maxFontSize: 12,
        minFontSize: 8,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }
}
