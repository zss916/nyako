import 'package:nyako/entities/app_contribute_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

ContributeEntity $ContributeEntityFromJson(Map<String, dynamic> json) {
  final ContributeEntity contributeEntity = ContributeEntity();
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    contributeEntity.amount = amount;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    contributeEntity.isDoNotDisturb = isDoNotDisturb;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    contributeEntity.isOnline = isOnline;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    contributeEntity.nickname = nickname;
  }
  final int? offlineAt = jsonConvert.convert<int>(json['offlineAt']);
  if (offlineAt != null) {
    contributeEntity.offlineAt = offlineAt;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    contributeEntity.portrait = portrait;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    contributeEntity.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    contributeEntity.username = username;
  }
  return contributeEntity;
}

Map<String, dynamic> $ContributeEntityToJson(ContributeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['isOnline'] = entity.isOnline;
  data['nickname'] = entity.nickname;
  data['offlineAt'] = entity.offlineAt;
  data['portrait'] = entity.portrait;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  return data;
}

extension ContributeEntityExtension on ContributeEntity {
  ContributeEntity copyWith({
    int? amount,
    int? isDoNotDisturb,
    int? isOnline,
    String? nickname,
    int? offlineAt,
    String? portrait,
    int? userId,
    String? username,
  }) {
    return ContributeEntity()
      ..amount = amount ?? this.amount
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..isOnline = isOnline ?? this.isOnline
      ..nickname = nickname ?? this.nickname
      ..offlineAt = offlineAt ?? this.offlineAt
      ..portrait = portrait ?? this.portrait
      ..userId = userId ?? this.userId
      ..username = username ?? this.username;
  }
}
