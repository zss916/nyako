import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/widget/build_msg_card_downtime.dart';

class ChatMsgCard extends StatelessWidget {
  const ChatMsgCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(12),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0x4D5A34FF),
        Color(0x3365C8FF),
      ])),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(end: 5),
            child: Image.asset(
              Assets.imgChatCard,
              width: 27,
              height: 18,
              matchTextDirection: true,
            ),
          ),
          Text(
            Tr.appEffect.tr,
            style: const TextStyle(color: Colors.white70),
          ),
          const Spacer(),
          const BuildMsgCardDownTime()
        ],
      ),
    );
  }
}
