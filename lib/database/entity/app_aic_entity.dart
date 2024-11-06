import 'dart:convert';

import 'package:nyako/agora/rtm_msg_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AicEntity {
  int id;
  String? extra;
  int? callCardCount;
  int? aicId;
  int? isOnline;
  int? muteStatus;
  int? isCard;
  int? propDuration;
  bool? isFollowed;
  String? nickname;
  String? filename;
  String? portrait;
  String? localPath;

  // 主播的id
  String? userId;

  // 消息插入库时间
  int dateInsert;
  // aic播放状态，0收到未下载，1已下载未播放，2已播放，3失败的
  int playState = 0;

  // 原本json
  String rawData;

  AicEntity(this.dateInsert, {this.id = 0}) : rawData = '';

  AicEntity.fromRtm(RTMMsgAIC aic, this.dateInsert, {this.id = 0})
      : extra = aic.extra,
        callCardCount = aic.callCardCount,
        aicId = aic.id,
        isCard = aic.isCard,
        isOnline = aic.isOnline,
        muteStatus = aic.muteStatus,
        propDuration = aic.propDuration,
        isFollowed = aic.isFollowed,
        nickname = aic.nickname,
        filename = aic.filename,
        portrait = aic.portrait,
        userId = aic.userId,
        rawData = json.encode(aic);
}
