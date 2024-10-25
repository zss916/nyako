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

  final double r = 20;

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
              height: 211,
              width: 150,
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(r),
                    topStart: Radius.circular(r),
                    bottomEnd: Radius.circular(r),
                    bottomStart: const Radius.circular(4)),
              ),
              child: LimitedBox(
                child: GestureDetector(
                    onTap: () {
                      showPreview([url ?? ""],
                          initIndex: 0, uid: wrapper.herId, type: 0);
                    },
                    child: AppNetImage2(
                      url ?? '',
                      radius: 0,
                    )),
              ),
            ),
          )
        : LianChatMsgMe(
            wrapper: wrapper,
            child: Container(
              height: 211,
              width: 150,
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.centerEnd,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(r),
                    topStart: Radius.circular(r),
                    bottomEnd: const Radius.circular(4),
                    bottomStart: Radius.circular(r)),
              ),
              child: LimitedBox(
                maxHeight: 211,
                maxWidth: 150,
                child: url != null
                    ? GestureDetector(
                        onTap: () {
                          showPreview([url], initIndex: 0, uid: "0", type: 0);
                        },
                        child: AppNetImage2(
                          url,
                          radius: 0,
                          fit: BoxFit.fill,
                        ))
                    : GestureDetector(
                        onTap: () {
                          showPreview([msg.extra ?? ''],
                              initIndex: 0, uid: "0", type: 0, isFile: true);
                        },
                        child: Container(
                          height: 211,
                          width: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(r),
                                topStart: Radius.circular(r),
                                bottomEnd: const Radius.circular(4),
                                bottomStart: Radius.circular(r)),
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
