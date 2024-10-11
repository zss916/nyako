import 'package:oliapro/entities/app_ai_config_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

AiConfigEntity $AiConfigEntityFromJson(Map<String, dynamic> json) {
  final AiConfigEntity aiConfigEntity = AiConfigEntity();
  final int? loginDelay = jsonConvert.convert<int>(json['loginDelay']);
  if (loginDelay != null) {
    aiConfigEntity.loginDelay = loginDelay;
  }
  final int? floorDiamondsThreshold =
      jsonConvert.convert<int>(json['floorDiamondsThreshold']);
  if (floorDiamondsThreshold != null) {
    aiConfigEntity.floorDiamondsThreshold = floorDiamondsThreshold;
  }
  final int? floorCallCardThreshold =
      jsonConvert.convert<int>(json['floorCallCardThreshold']);
  if (floorCallCardThreshold != null) {
    aiConfigEntity.floorCallCardThreshold = floorCallCardThreshold;
  }
  final AiConfigGroups? groups =
      jsonConvert.convert<AiConfigGroups>(json['groups']);
  if (groups != null) {
    aiConfigEntity.groups = groups;
  }
  return aiConfigEntity;
}

Map<String, dynamic> $AiConfigEntityToJson(AiConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['loginDelay'] = entity.loginDelay;
  data['floorDiamondsThreshold'] = entity.floorDiamondsThreshold;
  data['floorCallCardThreshold'] = entity.floorCallCardThreshold;
  data['groups'] = entity.groups?.toJson();
  return data;
}

extension AiConfigEntityExtension on AiConfigEntity {
  AiConfigEntity copyWith({
    int? loginDelay,
    int? floorDiamondsThreshold,
    int? floorCallCardThreshold,
    AiConfigGroups? groups,
  }) {
    return AiConfigEntity()
      ..loginDelay = loginDelay ?? this.loginDelay
      ..floorDiamondsThreshold =
          floorDiamondsThreshold ?? this.floorDiamondsThreshold
      ..floorCallCardThreshold =
          floorCallCardThreshold ?? this.floorCallCardThreshold
      ..groups = groups ?? this.groups;
  }
}

AiConfigGroups $AiConfigGroupsFromJson(Map<String, dynamic> json) {
  final AiConfigGroups aiConfigGroups = AiConfigGroups();
  final AiConfigGroupsItem? aibLackBalance =
      jsonConvert.convert<AiConfigGroupsItem>(json['AIB_LACK_BALANCE']);
  if (aibLackBalance != null) {
    aiConfigGroups.aibLackBalance = aibLackBalance;
  }
  final AiConfigGroupsItem? aibPaidLackBalance =
      jsonConvert.convert<AiConfigGroupsItem>(json['AIB_PAID_LACK_BALANCE']);
  if (aibPaidLackBalance != null) {
    aiConfigGroups.aibPaidLackBalance = aibPaidLackBalance;
  }
  final AiConfigGroupsItem? aibEnoughCallCard =
      jsonConvert.convert<AiConfigGroupsItem>(json['AIB_ENOUGH_CALL_CARD']);
  if (aibEnoughCallCard != null) {
    aiConfigGroups.aibEnoughCallCard = aibEnoughCallCard;
  }
  final AiConfigGroupsItem? aibEnoughBalance =
      jsonConvert.convert<AiConfigGroupsItem>(json['AIB_ENOUGH_BALANCE']);
  if (aibEnoughBalance != null) {
    aiConfigGroups.aibEnoughBalance = aibEnoughBalance;
  }
  return aiConfigGroups;
}

Map<String, dynamic> $AiConfigGroupsToJson(AiConfigGroups entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['AIB_LACK_BALANCE'] = entity.aibLackBalance?.toJson();
  data['AIB_PAID_LACK_BALANCE'] = entity.aibPaidLackBalance?.toJson();
  data['AIB_ENOUGH_CALL_CARD'] = entity.aibEnoughCallCard?.toJson();
  data['AIB_ENOUGH_BALANCE'] = entity.aibEnoughBalance?.toJson();
  return data;
}

extension AiConfigGroupsExtension on AiConfigGroups {
  AiConfigGroups copyWith({
    AiConfigGroupsItem? aibLackBalance,
    AiConfigGroupsItem? aibPaidLackBalance,
    AiConfigGroupsItem? aibEnoughCallCard,
    AiConfigGroupsItem? aibEnoughBalance,
  }) {
    return AiConfigGroups()
      ..aibLackBalance = aibLackBalance ?? this.aibLackBalance
      ..aibPaidLackBalance = aibPaidLackBalance ?? this.aibPaidLackBalance
      ..aibEnoughCallCard = aibEnoughCallCard ?? this.aibEnoughCallCard
      ..aibEnoughBalance = aibEnoughBalance ?? this.aibEnoughBalance;
  }
}

AiConfigGroupsItem $AiConfigGroupsItemFromJson(Map<String, dynamic> json) {
  final AiConfigGroupsItem aiConfigGroupsItem = AiConfigGroupsItem();
  final String? configGroup = jsonConvert.convert<String>(json['configGroup']);
  if (configGroup != null) {
    aiConfigGroupsItem.configGroup = configGroup;
  }
  final int? nextAibTime = jsonConvert.convert<int>(json['nextAibTime']);
  if (nextAibTime != null) {
    aiConfigGroupsItem.nextAibTime = nextAibTime;
  }
  final int? rejectDelay = jsonConvert.convert<int>(json['rejectDelay']);
  if (rejectDelay != null) {
    aiConfigGroupsItem.rejectDelay = rejectDelay;
  }
  final int? sendFlag = jsonConvert.convert<int>(json['sendFlag']);
  if (sendFlag != null) {
    aiConfigGroupsItem.sendFlag = sendFlag;
  }
  final int? minAivDelaySeconds =
      jsonConvert.convert<int>(json['minAivDelaySeconds']);
  if (minAivDelaySeconds != null) {
    aiConfigGroupsItem.minAivDelaySeconds = minAivDelaySeconds;
  }
  final int? maxAivDelaySeconds =
      jsonConvert.convert<int>(json['maxAivDelaySeconds']);
  if (maxAivDelaySeconds != null) {
    aiConfigGroupsItem.maxAivDelaySeconds = maxAivDelaySeconds;
  }
  final int? aivSendFlag = jsonConvert.convert<int>(json['aivSendFlag']);
  if (aivSendFlag != null) {
    aiConfigGroupsItem.aivSendFlag = aivSendFlag;
  }
  final int? aivFirstLoginCount =
      jsonConvert.convert<int>(json['aivFirstLoginCount']);
  if (aivFirstLoginCount != null) {
    aiConfigGroupsItem.aivFirstLoginCount = aivFirstLoginCount;
  }
  final int? aivNextLoginCount =
      jsonConvert.convert<int>(json['aivNextLoginCount']);
  if (aivNextLoginCount != null) {
    aiConfigGroupsItem.aivNextLoginCount = aivNextLoginCount;
  }
  final int? aivLoginInterval =
      jsonConvert.convert<int>(json['aivLoginInterval']);
  if (aivLoginInterval != null) {
    aiConfigGroupsItem.aivLoginInterval = aivLoginInterval;
  }
  final int? aivFirstDelay = jsonConvert.convert<int>(json['aivFirstDelay']);
  if (aivFirstDelay != null) {
    aiConfigGroupsItem.aivFirstDelay = aivFirstDelay;
  }
  final int? aivMinFirstLoginSeconds =
      jsonConvert.convert<int>(json['aivMinFirstLoginSeconds']);
  if (aivMinFirstLoginSeconds != null) {
    aiConfigGroupsItem.aivMinFirstLoginSeconds = aivMinFirstLoginSeconds;
  }
  final int? aivMaxFirstLoginSeconds =
      jsonConvert.convert<int>(json['aivMaxFirstLoginSeconds']);
  if (aivMaxFirstLoginSeconds != null) {
    aiConfigGroupsItem.aivMaxFirstLoginSeconds = aivMaxFirstLoginSeconds;
  }
  return aiConfigGroupsItem;
}

Map<String, dynamic> $AiConfigGroupsItemToJson(AiConfigGroupsItem entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['configGroup'] = entity.configGroup;
  data['nextAibTime'] = entity.nextAibTime;
  data['rejectDelay'] = entity.rejectDelay;
  data['sendFlag'] = entity.sendFlag;
  data['minAivDelaySeconds'] = entity.minAivDelaySeconds;
  data['maxAivDelaySeconds'] = entity.maxAivDelaySeconds;
  data['aivSendFlag'] = entity.aivSendFlag;
  data['aivFirstLoginCount'] = entity.aivFirstLoginCount;
  data['aivNextLoginCount'] = entity.aivNextLoginCount;
  data['aivLoginInterval'] = entity.aivLoginInterval;
  data['aivFirstDelay'] = entity.aivFirstDelay;
  data['aivMinFirstLoginSeconds'] = entity.aivMinFirstLoginSeconds;
  data['aivMaxFirstLoginSeconds'] = entity.aivMaxFirstLoginSeconds;
  return data;
}

extension AiConfigGroupsItemExtension on AiConfigGroupsItem {
  AiConfigGroupsItem copyWith({
    String? configGroup,
    int? nextAibTime,
    int? rejectDelay,
    int? sendFlag,
    int? minAivDelaySeconds,
    int? maxAivDelaySeconds,
    int? aivSendFlag,
    int? aivFirstLoginCount,
    int? aivNextLoginCount,
    int? aivLoginInterval,
    int? aivFirstDelay,
    int? aivMinFirstLoginSeconds,
    int? aivMaxFirstLoginSeconds,
  }) {
    return AiConfigGroupsItem()
      ..configGroup = configGroup ?? this.configGroup
      ..nextAibTime = nextAibTime ?? this.nextAibTime
      ..rejectDelay = rejectDelay ?? this.rejectDelay
      ..sendFlag = sendFlag ?? this.sendFlag
      ..minAivDelaySeconds = minAivDelaySeconds ?? this.minAivDelaySeconds
      ..maxAivDelaySeconds = maxAivDelaySeconds ?? this.maxAivDelaySeconds
      ..aivSendFlag = aivSendFlag ?? this.aivSendFlag
      ..aivFirstLoginCount = aivFirstLoginCount ?? this.aivFirstLoginCount
      ..aivNextLoginCount = aivNextLoginCount ?? this.aivNextLoginCount
      ..aivLoginInterval = aivLoginInterval ?? this.aivLoginInterval
      ..aivFirstDelay = aivFirstDelay ?? this.aivFirstDelay
      ..aivMinFirstLoginSeconds =
          aivMinFirstLoginSeconds ?? this.aivMinFirstLoginSeconds
      ..aivMaxFirstLoginSeconds =
          aivMaxFirstLoginSeconds ?? this.aivMaxFirstLoginSeconds;
  }
}
