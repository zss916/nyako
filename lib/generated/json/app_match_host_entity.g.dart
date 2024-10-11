import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/entities/app_match_host_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

MatchHost $MatchHostFromJson(Map<String, dynamic> json) {
  final MatchHost matchHost = MatchHost();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    matchHost.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    matchHost.nickName = nickName;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    matchHost.portrait = portrait;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    matchHost.isDoNotDisturb = isDoNotDisturb;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    matchHost.isOnline = isOnline;
  }
  final int? muteStatus = jsonConvert.convert<int>(json['muteStatus']);
  if (muteStatus != null) {
    matchHost.muteStatus = muteStatus;
  }
  final int? charge = jsonConvert.convert<int>(json['charge']);
  if (charge != null) {
    matchHost.charge = charge;
  }
  final AreaData? area = jsonConvert.convert<AreaData>(json['area']);
  if (area != null) {
    matchHost.area = area;
  }
  final int? birthday = jsonConvert.convert<int>(json['birthday']);
  if (birthday != null) {
    matchHost.birthday = birthday;
  }
  final int? followed = jsonConvert.convert<int>(json['followed']);
  if (followed != null) {
    matchHost.followed = followed;
  }
  final String? video = jsonConvert.convert<String>(json['video']);
  if (video != null) {
    matchHost.video = video;
  }
  return matchHost;
}

Map<String, dynamic> $MatchHostToJson(MatchHost entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['portrait'] = entity.portrait;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['isOnline'] = entity.isOnline;
  data['muteStatus'] = entity.muteStatus;
  data['charge'] = entity.charge;
  data['area'] = entity.area?.toJson();
  data['birthday'] = entity.birthday;
  data['followed'] = entity.followed;
  data['video'] = entity.video;
  return data;
}

extension MatchHostExtension on MatchHost {
  MatchHost copyWith({
    String? userId,
    String? nickName,
    String? portrait,
    int? isDoNotDisturb,
    int? isOnline,
    int? muteStatus,
    int? charge,
    AreaData? area,
    int? birthday,
    int? followed,
    String? video,
  }) {
    return MatchHost()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..portrait = portrait ?? this.portrait
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..isOnline = isOnline ?? this.isOnline
      ..muteStatus = muteStatus ?? this.muteStatus
      ..charge = charge ?? this.charge
      ..area = area ?? this.area
      ..birthday = birthday ?? this.birthday
      ..followed = followed ?? this.followed
      ..video = video ?? this.video;
  }
}
