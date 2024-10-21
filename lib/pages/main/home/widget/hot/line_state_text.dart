import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/utils/app_extends.dart';

class LineStateText extends StatelessWidget {
  final int lineState;

  const LineStateText(this.lineState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (lineState == LineType.online.number)
          Text(
            Tr.app_base_online.tr,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        if (lineState == LineType.busy.number)
          Text(
            Tr.app_base_busy.tr,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        if (lineState == LineType.offline.number)
          Text(
            Tr.app_base_offline.tr,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
      ],
    );
  }
}
