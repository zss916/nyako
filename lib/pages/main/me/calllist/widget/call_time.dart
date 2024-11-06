import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/utils/app_extends.dart';

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
      child: Row(
        children: [
          Image.asset(
            Assets.iconOnlineDisconnected,
            matchTextDirection: true,
            width: 20,
            height: 20,
          ),
          Text(
            state,
            style: TextStyle(
                color: const Color(0xFF9B989D),
                fontSize: 15,
                fontFamily: AppConstants.fontsRegular,
                fontWeight: FontWeight.w400),
          )
        ],
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
      child: Row(
        children: [
          Image.asset(
            Assets.iconDisconnected,
            matchTextDirection: true,
            width: 20,
            height: 20,
          ),
          Text(
            state,
            style: TextStyle(
                color: const Color(0xFFFF4864),
                fontSize: 15,
                fontFamily: AppConstants.fontsRegular,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
