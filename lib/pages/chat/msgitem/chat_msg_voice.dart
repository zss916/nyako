import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/database/entity/app_her_entity.dart';
import 'package:oliapro/database/entity/app_msg_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_widget.dart';
import 'package:oliapro/pages/chat/msgitem/chat_msg_wrapper.dart';
import 'package:oliapro/utils/app_format_util.dart';
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

  final double r = 20;

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
                    RepaintBoundary(
                      child: _playing
                          ? Lottie.asset(Assets.jsonAnimaMsgAudioW,
                              width: 22, height: 22, fit: BoxFit.cover)
                          : Image.asset(
                              Assets.iconMsgAudio,
                              width: 22,
                              height: 22,
                              color: Colors.white,
                              matchTextDirection: true,
                            ),
                    ),
                    Text(
                      " ${AppFormatUtil.getTimeStrFromSecond(int.parse(msg.content))}",
                      //'  ${msg.content}\'',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w500),
                    ),
                    if (_loading)
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        width: 16,
                        height: 16,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Color(0x26FF7FEF),
                          // value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFF7FEF)),
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
                        bottomEnd: const Radius.circular(4),
                        topEnd: Radius.circular(r),
                        bottomStart: Radius.circular(r)),
                    color: const Color(0xFFF4F5F6)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RepaintBoundary(
                      child: _playing
                          ? Lottie.asset(Assets.jsonAnimaMsgAudio,
                              width: 22, height: 22, fit: BoxFit.cover)
                          : Image.asset(
                              Assets.iconMsgAudio,
                              width: 22,
                              height: 22,
                              color: Colors.black,
                              matchTextDirection: true,
                            ),
                    ),
                    Text(
                      " ${AppFormatUtil.getTimeStrFromSecond(int.parse(msg.content))}",
                      //'  ${msg.content}\'',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.w500),
                    ),
                    if (_loading)
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        width: 16,
                        height: 16,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Color(0x26FF7FEF),
                          // value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFF7FEF)),
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
