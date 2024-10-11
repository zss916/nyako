import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/database/entity/app_her_entity.dart';
import 'package:oliapro/database/entity/app_msg_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_widget.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_wrapper.dart';
import 'package:oliapro/utils/app_voice_player.dart';

class ChatMsgVoice extends StatefulWidget {
  final ChatMsgWrapper wrapper;
  final bool? isOnline;
  const ChatMsgVoice({super.key, required this.wrapper, this.isOnline = false});

  @override
  State<ChatMsgVoice> createState() => _ChatMsgVoiceState();
}

class _ChatMsgVoiceState extends State<ChatMsgVoice> {
  HerEntity? her;
  late MsgEntity msg = widget.wrapper.msgEntity;
  RTMMsgVoice? rtmMsg;
  String? url;
  bool _playing = false;
  bool _loading = false;
  late StreamSubscription sub;

  final double r = 16;

  @override
  void initState() {
    super.initState();
    her = widget.wrapper.her;
    msg = widget.wrapper.msgEntity;
    if (msg.rawData.isNotEmpty) {
      Map<String, dynamic> jsonMap = json.decode(msg.rawData);
      rtmMsg = RTMMsgVoice.fromJson(jsonMap);
    }
    // 收到的消息有rtmMsg，发送中的图片消息还没有
    url = rtmMsg?.voiceUrl;
    sub = AppAudioPlayer().onPlayerStateChanged.listen((event) {
      final bool isCurrent = url == AppAudioPlayer().currentUrl;
      //  debugPrint("AudioPlayer====>>3 ${isCurrent} ${event.name} ==>${currentUrl.url}");
      switch (event) {
        case PlayerState.playing:
          if (mounted) {
            setState(() {
              _playing = isCurrent;
              _loading = false;
            });
          }
          break;
        case PlayerState.stopped:
        case PlayerState.paused:
        case PlayerState.completed:
        case PlayerState.disposed:
          if (isCurrent) {
            if (mounted) {
              setState(() {
                _playing = false;
                _loading = false;
              });
            }
          }
          break;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  void playIt({String? url}) {
    if (url == null) return;
    if (_playing) {
      AppAudioPlayer().stop();
      setState(() {
        _playing = false;
        _loading = false;
      });
    } else {
      AppAudioPlayer().playUrl(url);
      setState(() {
        _playing = true;
        _loading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.wrapper.herSend
        ? GestureDetector(
            onTap: () {
              playIt(url: url);
            },
            child: LianChatMsgHer(
              isOnline: widget.isOnline,
              wrapper: widget.wrapper,
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
                    RepaintBoundary(
                      child: Image.asset(
                        _playing ? Assets.animaMsgVoice : Assets.imgMsgVoice,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                        matchTextDirection: true,
                      ),
                    ),
                    Text(
                      '  ${msg.content}\'',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    if (_loading)
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        width: 16,
                        height: 16,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Color(0x26FFFFFF),
                          // value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => playIt(url: url),
            child: LianChatMsgMe(
              wrapper: widget.wrapper,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RepaintBoundary(
                      child: Image.asset(
                        _playing ? Assets.animaMsgVoice : Assets.imgMsgVoice,
                        width: 20,
                        height: 20,
                        color: Colors.white,
                        matchTextDirection: true,
                      ),
                    ),
                    Text(
                      '  ${msg.content}\'',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    if (_loading)
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        width: 16,
                        height: 16,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Color(0x26FFFFFF),
                          // value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
