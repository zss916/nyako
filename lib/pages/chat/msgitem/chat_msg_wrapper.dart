import 'package:nyako/database/entity/app_her_entity.dart';

import '../../../database/entity/app_msg_entity.dart';

/// 用于显示消息的bean的封装
class ChatMsgWrapper {
  MsgEntity msgEntity;

  // 时间
  int date;

  // 要显示时间？
  bool showTime = false;

  // 是收到的？
  bool herSend;

  HerEntity? her;
  String herId;

  ChatMsgWrapper(this.msgEntity, this.herSend, this.date,
      {this.her, this.showTime = false, required this.herId});
}
