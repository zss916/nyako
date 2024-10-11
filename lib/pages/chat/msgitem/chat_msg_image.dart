import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/pages/widget/app_preview.dart';
import 'package:oliapro/widget/app_net_image2.dart';

import 'chat_msg_widget.dart';
import 'chat_msg_wrapper.dart';

class ChatMsgImage extends StatelessWidget {
  final ChatMsgWrapper wrapper;
  final bool? isOnline;

  final double r = 12;

  const ChatMsgImage({super.key, required this.wrapper, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    var msg = wrapper.msgEntity;
    RTMMsgPhoto? rtmMsg;
    if (msg.rawData.isNotEmpty) {
      Map<String, dynamic> jsonMap = json.decode(msg.rawData);
      rtmMsg = RTMMsgPhoto.fromJson(jsonMap);
    }
    // 收到的消息有rtmMsg，发送中的图片消息还没有
    var url = rtmMsg?.thumbnailUrl ?? rtmMsg?.imageUrl;

    /*return Image.file(
        File(
          msg.extra ?? '',
        ),
        fit: BoxFit.fill);*/

    return wrapper.herSend
        ? LianChatMsgHer(
            wrapper: wrapper,
            isOnline: isOnline,
            child: Container(
              height: 185,
              width: 248,
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: LimitedBox(
                child: GestureDetector(
                    onTap: () {
                      showPreview([url ?? ""],
                          initIndex: 0, uid: wrapper.herId, type: 0);
                    },
                    child: AppNetImage2(
                      url ?? '',
                      radius: 16,
                    )),
              ),
            ),
          )
        : LianChatMsgMe(
            wrapper: wrapper,
            child: Container(
              height: 185,
              width: 248,
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.centerEnd,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: LimitedBox(
                maxHeight: 185,
                maxWidth: 248,
                child: url != null
                    ? GestureDetector(
                        onTap: () {
                          showPreview([url], initIndex: 0, uid: "0", type: 0);
                        },
                        child: AppNetImage2(
                          url,
                          radius: 20,
                          fit: BoxFit.fill,
                        ))
                    : GestureDetector(
                        onTap: () {
                          showPreview([msg.extra ?? ''],
                              initIndex: 0, uid: "0", type: 0, isFile: true);
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.file(
                              File(
                                msg.extra ?? '',
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
              ),
            ),
          );
  }
}
