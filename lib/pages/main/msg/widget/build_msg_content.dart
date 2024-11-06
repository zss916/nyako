import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/database/entity/app_conversation_entity.dart';
import 'package:nyako/generated/assets.dart';

// type text = 10
// type gift = 11
// type call = 12
// type imge = 13 图片消息
// type voice = 14 语音消息
// type video = 15
// type severImge = 20//服务器图片消息
// type severVoice = 21 //服务器语音消息
// type = 24 //AIA下发的视频
// type = 25 //AIB
// type = 23    服务器会发送begincall
class BuildMsgContent extends StatelessWidget {
  final ConversationEntity msg;
  const BuildMsgContent(this.msg, {super.key});

  final double r = 21;

  @override
  Widget build(BuildContext context) {
    return msg.sendState == 2
        ? const Icon(
            Icons.error_outline_outlined,
            size: 25,
            color: Color(0xFFFF2A48),
          )
        : _getContent(msg);
  }

  Widget _getContent(ConversationEntity msg) {
    switch (msg.lastMsgType) {
      case 10:
        return Text(msg.content,
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: AppConstants.fontsRegular,
                color: const Color(0xFF9B989D),
                fontSize: 14));
      case 11:
        return Image.asset(
          Assets.iconMsgGift,
          height: r,
          width: r,
          matchTextDirection: true,
        );
      case 13:
      case 20:
        return Image.asset(Assets.iconMsgPic,
            matchTextDirection: true, height: r, width: r);
      case 14:
      case 21:
        return Image.asset(Assets.iconMsgAudio,
            matchTextDirection: true, height: r, width: r);
      case 12:
        return Image.asset(Assets.iconMsgCall,
            matchTextDirection: true, height: r, width: r);
    }
    return Text(msg.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: AppConstants.fontsRegular,
            color: const Color(0xFF9B989D),
            fontSize: 14));
  }
}
