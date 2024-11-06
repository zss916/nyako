import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/pages/chat/index.dart';
import 'package:nyako/pages/widget/line_state.dart';
import 'package:nyako/utils/app_extends.dart';

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
            margin: const EdgeInsetsDirectional.only(start: 0),
            child: LineState(
              LineType.online.number,
              r: 10,
            ),
          )
        : const SizedBox.shrink();
  }
}
