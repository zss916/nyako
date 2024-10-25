import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_widget.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_wrapper.dart';
import 'package:oliapro/widget/app_net_image.dart';

class ChatMsgGift extends StatelessWidget {
  final ChatMsgWrapper wrapper;
  final bool? isOnline;
  final double r = 20;

  const ChatMsgGift({super.key, required this.wrapper, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    var msg = wrapper.msgEntity;
    RTMMsgGift? rtmMsg;
    if (msg.rawData.isNotEmpty) {
      Map<String, dynamic> jsonMap = json.decode(msg.rawData);
      rtmMsg = RTMMsgGift.fromJson(jsonMap);
    }
    // 收到的消息有rtmMsg，发送中的图片消息还没有
    var url = rtmMsg?.giftImageUrl;
    return wrapper.herSend
        ? LianChatMsgHer(
            wrapper: wrapper,
            isOnline: isOnline,
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(20),
                      bottomStart: Radius.circular(4)),
                  color: Color(0xFFFF7FEF)),
              margin: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  /* Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      rtmMsg?.giftName ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(0)),
                    child: AppNetImage(
                      url ?? '',
                      width: 100,
                      height: 100,
                    ),
                  )
                ],
              ),
            ),
          )
        : LianChatMsgMe(
            wrapper: wrapper,
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      bottomEnd: Radius.circular(4),
                      bottomStart: Radius.circular(20)),
                  color: Color(0xFF4C1F87)),
              margin: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      rtmMsg?.giftName ?? '',
                      style: const TextStyle(
                          color: Color(0xFF00C5EC),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(0)),
                    child: AppNetImage(
                      url ?? '',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
