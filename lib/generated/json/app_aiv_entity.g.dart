import 'package:oliapro/entities/app_aiv_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

AivBean $AivBeanFromJson(Map<String, dynamic> json) {
  final AivBean aivBean = AivBean();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    aivBean.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    aivBean.username = username;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    aivBean.portrait = portrait;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    aivBean.nickname = nickname;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    aivBean.isOnline = isOnline;
  }
  final String? filename = jsonConvert.convert<String>(json['filename']);
  if (filename != null) {
    aivBean.filename = filename;
  }
  final int? muteStatus = jsonConvert.convert<int>(json['muteStatus']);
  if (muteStatus != null) {
    aivBean.muteStatus = muteStatus;
  }
  final int? isCard = jsonConvert.convert<int>(json['isCard']);
  if (isCard != null) {
    aivBean.isCard = isCard;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    aivBean.propDuration = propDuration;
  }
  final int? callCardCount = jsonConvert.convert<int>(json['callCardCount']);
  if (callCardCount != null) {
    aivBean.callCardCount = callCardCount;
  }
  return aivBean;
}

Map<String, dynamic> $AivBeanToJson(AivBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['portrait'] = entity.portrait;
  data['nickname'] = entity.nickname;
  data['isOnline'] = entity.isOnline;
  data['filename'] = entity.filename;
  data['muteStatus'] = entity.muteStatus;
  data['isCard'] = entity.isCard;
  data['propDuration'] = entity.propDuration;
  data['callCardCount'] = entity.callCardCount;
  return data;
}

extension AivBeanExtension on AivBean {
  AivBean copyWith({
    String? userId,
    String? username,
    String? portrait,
    String? nickname,
    int? isOnline,
    String? filename,
    int? muteStatus,
    int? isCard,
    int? propDuration,
    int? callCardCount,
  }) {
    return AivBean()
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..portrait = portrait ?? this.portrait
      ..nickname = nickname ?? this.nickname
      ..isOnline = isOnline ?? this.isOnline
      ..filename = filename ?? this.filename
      ..muteStatus = muteStatus ?? this.muteStatus
      ..isCard = isCard ?? this.isCard
      ..propDuration = propDuration ?? this.propDuration
      ..callCardCount = callCardCount ?? this.callCardCount;
  }
}
