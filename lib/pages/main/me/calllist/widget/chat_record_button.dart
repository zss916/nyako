import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_call_record_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/calllist/index.dart';

class ChatRecordButton extends StatelessWidget {
  final bool isVideoChat;
  final CallRecordEntity item;
  final ChatRecordLogic logic;

  const ChatRecordButton(this.isVideoChat, this.item, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return isVideoChat
        ? GestureDetector(
            onTap: () => logic.callUp(item.peerUserId ?? 0),
            child: Image.asset(
              Assets.imgCallIcon,
              width: 44,
              height: 44,
              matchTextDirection: true,
            ),
          )
        : GestureDetector(
            onTap: () => logic.startMsg((item.peerUserId ?? 0).toString()),
            child: Image.asset(
              Assets.imgMsgIcon,
              width: 44,
              height: 44,
              matchTextDirection: true,
            ),
          );
  }
}
