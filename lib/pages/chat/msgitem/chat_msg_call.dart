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

  final double r = 20;

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
                        topStart: Radius.circular(r),
                        bottomEnd: Radius.circular(r),
                        topEnd: Radius.circular(r),
                        bottomStart: const Radius.circular(4)),
                    color: const Color(0xFFFF7FEF)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.iconMsgCall,
                      matchTextDirection: true,
                      height: 22,
                      width: 22,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                      height: 10,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w500),
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
                        bottomEnd: const Radius.circular(4),
                        topEnd: Radius.circular(r),
                        bottomStart: Radius.circular(r)),
                    color: const Color(0xFFF4F5F6)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      matchTextDirection: true,
                      Assets.iconMsgCall,
                      // repeat: ImageRepeat.repeatY,
                      height: 22,
                      width: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 4,
                      height: 10,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
