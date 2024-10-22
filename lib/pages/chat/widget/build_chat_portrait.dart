import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/pages/chat/widget/buildLineState.dart';

class ChatPortrait extends StatelessWidget {
  final ChatLogic logic;
  const ChatPortrait(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildLineState(logic),
        const SizedBox(
          width: 2,
        ),
        LimitedBox(
          maxWidth: 200,
          child: Text(
            logic.herId == AppConstants.systemId
                ? Tr.app_message_official.tr
                : logic.herId == AppConstants.serviceId
                    ? AppConstants.appName
                    : logic.herDetail?.nickname ?? '--',
            maxLines: 1,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
