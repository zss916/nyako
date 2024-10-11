import 'package:flutter/material.dart';
import 'package:oliapro/utils/app_extends.dart';

class CallTime extends StatelessWidget {
  final int lineState;
  final String state;
  const CallTime(this.lineState, this.state, {super.key});

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
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        state,
        style: const TextStyle(
            color: Color(0xFF27EF83),
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget busy(String state) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        state,
        style: const TextStyle(
            color: Color(0xFFF447FF),
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget offline(String state) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        state,
        style: const TextStyle(
            color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
