import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/chat/widget/build_msg_card_downtime.dart';

class ChatMsgCard extends StatelessWidget {
  const ChatMsgCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12, bottom: 5),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0x4D81E0FF),
            Color(0x334AC6FF),
          ]),
          borderRadius: BorderRadiusDirectional.circular(12)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 5),
            child: Image.asset(
              Assets.iconChatCard,
              width: 32,
              height: 32,
              matchTextDirection: true,
            ),
          ),
          Text(
            Tr.appEffect.tr,
            style: TextStyle(
                color: Colors.black,
                fontFamily: AppConstants.fontsRegular,
                fontSize: 16),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsetsDirectional.only(end: 6),
            child: const BuildMsgCardDownTime(),
          )
        ],
      ),
    );
  }
}
