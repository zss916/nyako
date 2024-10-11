import 'package:flutter/material.dart';
import 'package:oliapro/pages/chat/msgitem/build_switch.dart';
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
  double r = 12;

  @override
  Widget build(BuildContext context) {
    //var her = widget.wrapper.her;
    var msg = widget.wrapper.msgEntity;
    return widget.wrapper.herSend
        ? LianChatMsgHer(
            wrapper: widget.wrapper,
            isOnline: widget.isOnline,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 50),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.zero,
                                topEnd: Radius.circular(r),
                                bottomStart: Radius.circular(r),
                                bottomEnd: Radius.circular(r)),
                            color: Colors.white10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        margin: const EdgeInsetsDirectional.only(end: 15),
                        child: Text(
                          msg.content,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      if (widget.hasTranslateFunction == true)
                        PositionedDirectional(
                            child: BuildTranslateIcon(
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
                if (widget.hasTranslateFunction! &&
                    msg.translateContent != null &&
                    msg.translateContent!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    margin: const EdgeInsetsDirectional.only(end: 50, top: 2),
                    child: Text(
                      msg.translateContent ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
              ],
            ),
          )
        : LianChatMsgMe(
            wrapper: widget.wrapper,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.zero,
                      topStart: Radius.circular(r),
                      bottomEnd: Radius.circular(r),
                      bottomStart: Radius.circular(r)),
                  gradient: const LinearGradient(colors: [
                    Color(0xFFB390F9),
                    Color(0xFF8865CC),
                  ])),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                msg.content,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          );
  }
}
