import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/call_status.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_widget.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_wrapper.dart';
import 'package:oliapro/routes/a_routes.dart';

class ChatMsgCall extends StatelessWidget {
  final ChatMsgWrapper wrapper;
  final bool? isOnline;
  const ChatMsgCall({super.key, required this.wrapper, this.isOnline = false});

  final double r = 16;

  @override
  Widget build(BuildContext context) {
    var her = wrapper.her;
    var msg = wrapper.msgEntity;
    Map<String, dynamic> jsonMap = json.decode(msg.rawData);
    var call = RTMMsgCallState.fromJson(jsonMap);
    String content = call.statusType == CallStatus.PICK_UP ||
            call.statusType == CallStatus.USE_VIDEO_CARD ||
            call.statusType == CallStatus.USE_CARD_AND_PAY
        ? call.duration ?? ''
        : Tr.app_call_disconnected.tr;
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onTap: () {
        if (AppConstants.isFakeMode) return;
        ARoutes.toLocalCall(her?.uid ?? "", her?.portrait);
      },
      child: wrapper.herSend
          ? LianChatMsgHer(
              wrapper: wrapper,
              isOnline: isOnline,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.zero,
                        bottomEnd: Radius.circular(r),
                        topEnd: Radius.circular(r),
                        bottomStart: Radius.circular(r)),
                    color: Colors.white10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.imgMsgCall2,
                      matchTextDirection: true,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Text(
                      content,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            )
          : LianChatMsgMe(
              wrapper: wrapper,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(r),
                        bottomEnd: Radius.circular(r),
                        topEnd: Radius.zero,
                        bottomStart: Radius.circular(r)),
                    gradient: const LinearGradient(colors: [
                      Color(0xFFB390F9),
                      Color(0xFF8865CC),
                    ])),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      matchTextDirection: true,
                      Assets.imgMsgCall2,
                      // repeat: ImageRepeat.repeatY,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Text(
                      content,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
