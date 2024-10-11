import 'package:oliapro/entities/app_recharge_active_config_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

AppRechargeActiveConfigEntity $AppRechargeActiveConfigEntityFromJson(
    Map<String, dynamic> json) {
  final AppRechargeActiveConfigEntity appRechargeActiveConfigEntity =
      AppRechargeActiveConfigEntity();
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    appRechargeActiveConfigEntity.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    appRechargeActiveConfigEntity.updatedAt = updatedAt;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    appRechargeActiveConfigEntity.id = id;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    appRechargeActiveConfigEntity.areaCode = areaCode;
  }
  final String? activityName =
      jsonConvert.convert<String>(json['activityName']);
  if (activityName != null) {
    appRechargeActiveConfigEntity.activityName = activityName;
  }
  final String? appChannelList =
      jsonConvert.convert<String>(json['appChannelList']);
  if (appChannelList != null) {
    appRechargeActiveConfigEntity.appChannelList = appChannelList;
  }
  final int? timeLimit = jsonConvert.convert<int>(json['timeLimit']);
  if (timeLimit != null) {
    appRechargeActiveConfigEntity.timeLimit = timeLimit;
  }
  final int? sendDiamond = jsonConvert.convert<int>(json['sendDiamond']);
  if (sendDiamond != null) {
    appRechargeActiveConfigEntity.sendDiamond = sendDiamond;
  }
  final String? userLimit = jsonConvert.convert<String>(json['userLimit']);
  if (userLimit != null) {
    appRechargeActiveConfigEntity.userLimit = userLimit;
  }
  final int? rewardLimit = jsonConvert.convert<int>(json['rewardLimit']);
  if (rewardLimit != null) {
    appRechargeActiveConfigEntity.rewardLimit = rewardLimit;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    appRechargeActiveConfigEntity.status = status;
  }
  return appRechargeActiveConfigEntity;
}

Map<String, dynamic> $AppRechargeActiveConfigEntityToJson(
    AppRechargeActiveConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['id'] = entity.id;
  data['areaCode'] = entity.areaCode;
  data['activityName'] = entity.activityName;
  data['appChannelList'] = entity.appChannelList;
  data['timeLimit'] = entity.timeLimit;
  data['sendDiamond'] = entity.sendDiamond;
  data['userLimit'] = entity.userLimit;
  data['rewardLimit'] = entity.rewardLimit;
  data['status'] = entity.status;
  return data;
}

extension AppRechargeActiveConfigEntityExtension
    on AppRechargeActiveConfigEntity {
  AppRechargeActiveConfigEntity copyWith({
    int? createdAt,
    int? updatedAt,
    int? id,
    int? areaCode,
    String? activityName,
    String? appChannelList,
    int? timeLimit,
    int? sendDiamond,
    String? userLimit,
    int? rewardLimit,
    int? status,
  }) {
    return AppRechargeActiveConfigEntity()
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..id = id ?? this.id
      ..areaCode = areaCode ?? this.areaCode
      ..activityName = activityName ?? this.activityName
      ..appChannelList = appChannelList ?? this.appChannelList
      ..timeLimit = timeLimit ?? this.timeLimit
      ..sendDiamond = sendDiamond ?? this.sendDiamond
      ..userLimit = userLimit ?? this.userLimit
      ..rewardLimit = rewardLimit ?? this.rewardLimit
      ..status = status ?? this.status;
  }
}
