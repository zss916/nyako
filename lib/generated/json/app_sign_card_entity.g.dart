import 'package:nyako/entities/app_sign_card_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

AppLiveSignCard $AppLiveSignCardFromJson(Map<String, dynamic> json) {
  final AppLiveSignCard appLiveSignCard = AppLiveSignCard();
  final int? propId = jsonConvert.convert<int>(json['propId']);
  if (propId != null) {
    appLiveSignCard.propId = propId;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    appLiveSignCard.userId = userId;
  }
  final int? propType = jsonConvert.convert<int>(json['propType']);
  if (propType != null) {
    appLiveSignCard.propType = propType;
  }
  final int? propStatus = jsonConvert.convert<int>(json['propStatus']);
  if (propStatus != null) {
    appLiveSignCard.propStatus = propStatus;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    appLiveSignCard.propDuration = propDuration;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    appLiveSignCard.createdAt = createdAt;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    appLiveSignCard.icon = icon;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    appLiveSignCard.name = name;
  }
  final String? signDate = jsonConvert.convert<String>(json['signDate']);
  if (signDate != null) {
    appLiveSignCard.signDate = signDate;
  }
  final String? showEndTime = jsonConvert.convert<String>(json['showEndTime']);
  if (showEndTime != null) {
    appLiveSignCard.showEndTime = showEndTime;
  }
  final bool? isUsed = jsonConvert.convert<bool>(json['isUsed']);
  if (isUsed != null) {
    appLiveSignCard.isUsed = isUsed;
  }
  return appLiveSignCard;
}

Map<String, dynamic> $AppLiveSignCardToJson(AppLiveSignCard entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['propId'] = entity.propId;
  data['userId'] = entity.userId;
  data['propType'] = entity.propType;
  data['propStatus'] = entity.propStatus;
  data['propDuration'] = entity.propDuration;
  data['createdAt'] = entity.createdAt;
  data['icon'] = entity.icon;
  data['name'] = entity.name;
  data['signDate'] = entity.signDate;
  data['showEndTime'] = entity.showEndTime;
  data['isUsed'] = entity.isUsed;
  return data;
}

extension AppLiveSignCardExtension on AppLiveSignCard {
  AppLiveSignCard copyWith({
    int? propId,
    int? userId,
    int? propType,
    int? propStatus,
    int? propDuration,
    int? createdAt,
    String? icon,
    String? name,
    String? signDate,
    String? showEndTime,
    bool? isUsed,
  }) {
    return AppLiveSignCard()
      ..propId = propId ?? this.propId
      ..userId = userId ?? this.userId
      ..propType = propType ?? this.propType
      ..propStatus = propStatus ?? this.propStatus
      ..propDuration = propDuration ?? this.propDuration
      ..createdAt = createdAt ?? this.createdAt
      ..icon = icon ?? this.icon
      ..name = name ?? this.name
      ..signDate = signDate ?? this.signDate
      ..showEndTime = showEndTime ?? this.showEndTime
      ..isUsed = isUsed ?? this.isUsed;
  }
}
