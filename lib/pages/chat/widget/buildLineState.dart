import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildLineState extends StatelessWidget {
  final ChatLogic logic;
  const BuildLineState(this.logic, {super.key});

  bool get isShow => (logic.herId != AppConstants.systemId &&
      logic.herId != AppConstants.serviceId &&
      logic.herDetail?.userId != null &&
      logic.herDetail?.isOnline == 1 &&
      logic.herDetail?.isDoNotDisturb == 0);

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            child: LineState(
              LineType.online.number,
              r: 14,
            ),
          )
        : const SizedBox.shrink();
  }
}
