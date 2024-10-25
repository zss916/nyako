import 'package:flutter/material.dart';
import 'package:oliapro/pages/chat/msgitem/build_switch2.dart';
import 'package:oliapro/services/storage_service.dart';

import 'chat_msg_widget.dart';
import 'chat_msg_wrapper.dart';

class ChatMsgText extends StatefulWidget {
  final ChatMsgWrapper wrapper;
  final bool? isOnline;
  final bool? hasTranslateFunction;

  const ChatMsgText(
      {super.key,
      required this.wrapper,
      this.isOnline = false,
      this.hasTranslateFunction = false});

  @override
  State<ChatMsgText> createState() => _ChatMsgTextState();
}

class _ChatMsgTextState extends State<ChatMsgText> {
  double r = 20;

  @override
  Widget build(BuildContext context) {
    //var her = widget.wrapper.her;
    var msg = widget.wrapper.msgEntity;
    return widget.wrapper.herSend
        ? LianChatMsgHer(
            wrapper: widget.wrapper,
            isOnline: widget.isOnline,
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 30),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(r),
                            topEnd: Radius.circular(r),
                            bottomStart: const Radius.circular(4),
                            bottomEnd: Radius.circular(r)),
                        color: const Color(0xFFFF7FEF)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    margin: const EdgeInsetsDirectional.only(end: 35),
                    child: Column(
                      children: [
                        Text(
                          msg.content,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        if (widget.hasTranslateFunction! &&
                            msg.translateContent != null &&
                            msg.translateContent!.isNotEmpty)
                          Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                vertical: 10),
                            child: const Divider(
                              height: 1,
                              color: Color(0x33FFFFFF),
                            ),
                          ),
                        if (widget.hasTranslateFunction! &&
                            msg.translateContent != null &&
                            msg.translateContent!.isNotEmpty)
                          Text(
                            msg.translateContent ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          )
                      ],
                    ),
                  ),
                  if (widget.hasTranslateFunction == true)
                    PositionedDirectional(
                        end: 0,
                        child: BuildSelectIcon(
                            content: msg.content,
                            isTranslated: (msg.translateContent != null),
                            fun: (tranContent) {
                              if (mounted) {
                                setState(() {
                                  msg.translateContent = tranContent;
                                  StorageService.to.objectBoxMsg
                                      .insertOrUpdateMsg(msg);
                                });
                              }
                            }))
                ],
              ),
            ),
          )
        : LianChatMsgMe(
            wrapper: widget.wrapper,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F6),
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(r),
                    topStart: Radius.circular(r),
                    bottomEnd: const Radius.circular(4),
                    bottomStart: Radius.circular(r)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              margin: const EdgeInsets.only(top: 0),
              child: Text(
                msg.content,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
  }
}
