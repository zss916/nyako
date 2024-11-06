import 'package:nyako/entities/app_host_match_limit_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

HostMatchLimitEntity $HostMatchLimitEntityFromJson(Map<String, dynamic> json) {
  final HostMatchLimitEntity hostMatchLimitEntity = HostMatchLimitEntity();
  final int? matchCount = jsonConvert.convert<int>(json['matchCount']);
  if (matchCount != null) {
    hostMatchLimitEntity.matchCount = matchCount;
  }
  final HostMatchLimitEntityAnchor? anchor =
      jsonConvert.convert<HostMatchLimitEntityAnchor>(json['anchor']);
  if (anchor != null) {
    hostMatchLimitEntity.anchor = anchor;
  }
  return hostMatchLimitEntity;
}

Map<String, dynamic> $HostMatchLimitEntityToJson(HostMatchLimitEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['matchCount'] = entity.matchCount;
  data['anchor'] = entity.anchor?.toJson();
  return data;
}

extension HostMatchLimitEntityExtension on HostMatchLimitEntity {
  HostMatchLimitEntity copyWith({
    int? matchCount,
    HostMatchLimitEntityAnchor? anchor,
  }) {
    return HostMatchLimitEntity()
      ..matchCount = matchCount ?? this.matchCount
      ..anchor = anchor ?? this.anchor;
  }
}

HostMatchLimitEntityAnchor $HostMatchLimitEntityAnchorFromJson(
    Map<String, dynamic> json) {
  final HostMatchLimitEntityAnchor hostMatchLimitEntityAnchor =
      HostMatchLimitEntityAnchor();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    hostMatchLimitEntityAnchor.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    hostMatchLimitEntityAnchor.nickName = nickName;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    hostMatchLimitEntityAnchor.portrait = portrait;
  }
  final int? charge = jsonConvert.convert<int>(json['charge']);
  if (charge != null) {
    hostMatchLimitEntityAnchor.charge = charge;
  }
  final int? muteStatus = jsonConvert.convert<int>(json['muteStatus']);
  if (muteStatus != null) {
    hostMatchLimitEntityAnchor.muteStatus = muteStatus;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    hostMatchLimitEntityAnchor.isOnline = isOnline;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    hostMatchLimitEntityAnchor.isDoNotDisturb = isDoNotDisturb;
  }
  final String? areaCode = jsonConvert.convert<String>(json['areaCode']);
  if (areaCode != null) {
    hostMatchLimitEntityAnchor.areaCode = areaCode;
  }
  final String? video = jsonConvert.convert<String>(json['video']);
  if (video != null) {
    hostMatchLimitEntityAnchor.video = video;
  }
  final int? followed = jsonConvert.convert<int>(json['followed']);
  if (followed != null) {
    hostMatchLimitEntityAnchor.followed = followed;
  }
  final int? birthday = jsonConvert.convert<int>(json['birthday']);
  if (birthday != null) {
    hostMatchLimitEntityAnchor.birthday = birthday;
  }
  return hostMatchLimitEntityAnchor;
}

Map<String, dynamic> $HostMatchLimitEntityAnchorToJson(
    HostMatchLimitEntityAnchor entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['portrait'] = entity.portrait;
  data['charge'] = entity.charge;
  data['muteStatus'] = entity.muteStatus;
  data['isOnline'] = entity.isOnline;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['areaCode'] = entity.areaCode;
  data['video'] = entity.video;
  data['followed'] = entity.followed;
  data['birthday'] = entity.birthday;
  return data;
}

extension HostMatchLimitEntityAnchorExtension on HostMatchLimitEntityAnchor {
  HostMatchLimitEntityAnchor copyWith({
    int? userId,
    String? nickName,
    String? portrait,
    int? charge,
    int? muteStatus,
    int? isOnline,
    int? isDoNotDisturb,
    String? areaCode,
    String? video,
    int? followed,
    int? birthday,
  }) {
    return HostMatchLimitEntityAnchor()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..portrait = portrait ?? this.portrait
      ..charge = charge ?? this.charge
      ..muteStatus = muteStatus ?? this.muteStatus
      ..isOnline = isOnline ?? this.isOnline
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..areaCode = areaCode ?? this.areaCode
      ..video = video ?? this.video
      ..followed = followed ?? this.followed
      ..birthday = birthday ?? this.birthday;
  }
}
