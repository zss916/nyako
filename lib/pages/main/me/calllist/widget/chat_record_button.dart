import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nyako/entities/app_call_record_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/calllist/index.dart';

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
            child: Container(
              width: 60,
              height: 36,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [
                        Color(0xFF8A29F8),
                        Color(0xFFFC0193),
                      ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Lottie.asset(Assets.jsonAnimaCall, width: 22, height: 22),
            ),
          )
        : GestureDetector(
            onTap: () => logic.startMsg((item.peerUserId ?? 0).toString()),
            child: Container(
              width: 60,
              height: 36,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFF81E0FF),
                    Color(0xFF4AC6FF),
                  ]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Image.asset(
                Assets.iconToMsgIcon,
                width: 24,
                height: 24,
                matchTextDirection: true,
              ),
            ),
          );
  }
}
