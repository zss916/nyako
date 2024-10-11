import 'package:oliapro/entities/app_call_record_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

CallRecordEntity $CallRecordEntityFromJson(Map<String, dynamic> json) {
  final CallRecordEntity callRecordEntity = CallRecordEntity();
  final int? callId = jsonConvert.convert<int>(json['callId']);
  if (callId != null) {
    callRecordEntity.callId = callId;
  }
  final int? channelId = jsonConvert.convert<int>(json['channelId']);
  if (channelId != null) {
    callRecordEntity.channelId = channelId;
  }
  final int? currUserId = jsonConvert.convert<int>(json['currUserId']);
  if (currUserId != null) {
    callRecordEntity.currUserId = currUserId;
  }
  final int? peerUserId = jsonConvert.convert<int>(json['peerUserId']);
  if (peerUserId != null) {
    callRecordEntity.peerUserId = peerUserId;
  }
  final int? callRole = jsonConvert.convert<int>(json['callRole']);
  if (callRole != null) {
    callRecordEntity.callRole = callRole;
  }
  final int? chargePrice = jsonConvert.convert<int>(json['chargePrice']);
  if (chargePrice != null) {
    callRecordEntity.chargePrice = chargePrice;
  }
  final int? chargeCount = jsonConvert.convert<int>(json['chargeCount']);
  if (chargeCount != null) {
    callRecordEntity.chargeCount = chargeCount;
  }
  final int? endType = jsonConvert.convert<int>(json['endType']);
  if (endType != null) {
    callRecordEntity.endType = endType;
  }
  final int? clientEndAt = jsonConvert.convert<int>(json['clientEndAt']);
  if (clientEndAt != null) {
    callRecordEntity.clientEndAt = clientEndAt;
  }
  final int? clientDuration = jsonConvert.convert<int>(json['clientDuration']);
  if (clientDuration != null) {
    callRecordEntity.clientDuration = clientDuration;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    callRecordEntity.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    callRecordEntity.updatedAt = updatedAt;
  }
  final String? currUsername =
      jsonConvert.convert<String>(json['currUsername']);
  if (currUsername != null) {
    callRecordEntity.currUsername = currUsername;
  }
  final String? peerUsername =
      jsonConvert.convert<String>(json['peerUsername']);
  if (peerUsername != null) {
    callRecordEntity.peerUsername = peerUsername;
  }
  final String? peerNickname =
      jsonConvert.convert<String>(json['peerNickname']);
  if (peerNickname != null) {
    callRecordEntity.peerNickname = peerNickname;
  }
  final String? peerPortrait =
      jsonConvert.convert<String>(json['peerPortrait']);
  if (peerPortrait != null) {
    callRecordEntity.peerPortrait = peerPortrait;
  }
  final int? channelStatus = jsonConvert.convert<int>(json['channelStatus']);
  if (channelStatus != null) {
    callRecordEntity.channelStatus = channelStatus;
  }
  final int? startAt = jsonConvert.convert<int>(json['startAt']);
  if (startAt != null) {
    callRecordEntity.startAt = startAt;
  }
  final int? endAt = jsonConvert.convert<int>(json['endAt']);
  if (endAt != null) {
    callRecordEntity.endAt = endAt;
  }
  final int? peerIsOnline = jsonConvert.convert<int>(json['peerIsOnline']);
  if (peerIsOnline != null) {
    callRecordEntity.peerIsOnline = peerIsOnline;
  }
  final int? peerIsDoNotDisturb =
      jsonConvert.convert<int>(json['peerIsDoNotDisturb']);
  if (peerIsDoNotDisturb != null) {
    callRecordEntity.peerIsDoNotDisturb = peerIsDoNotDisturb;
  }
  return callRecordEntity;
}

Map<String, dynamic> $CallRecordEntityToJson(CallRecordEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['callId'] = entity.callId;
  data['channelId'] = entity.channelId;
  data['currUserId'] = entity.currUserId;
  data['peerUserId'] = entity.peerUserId;
  data['callRole'] = entity.callRole;
  data['chargePrice'] = entity.chargePrice;
  data['chargeCount'] = entity.chargeCount;
  data['endType'] = entity.endType;
  data['clientEndAt'] = entity.clientEndAt;
  data['clientDuration'] = entity.clientDuration;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['currUsername'] = entity.currUsername;
  data['peerUsername'] = entity.peerUsername;
  data['peerNickname'] = entity.peerNickname;
  data['peerPortrait'] = entity.peerPortrait;
  data['channelStatus'] = entity.channelStatus;
  data['startAt'] = entity.startAt;
  data['endAt'] = entity.endAt;
  data['peerIsOnline'] = entity.peerIsOnline;
  data['peerIsDoNotDisturb'] = entity.peerIsDoNotDisturb;
  return data;
}

extension CallRecordEntityExtension on CallRecordEntity {
  CallRecordEntity copyWith({
    int? callId,
    int? channelId,
    int? currUserId,
    int? peerUserId,
    int? callRole,
    int? chargePrice,
    int? chargeCount,
    int? endType,
    int? clientEndAt,
    int? clientDuration,
    int? createdAt,
    int? updatedAt,
    String? currUsername,
    String? peerUsername,
    String? peerNickname,
    String? peerPortrait,
    int? channelStatus,
    int? startAt,
    int? endAt,
    int? peerIsOnline,
    int? peerIsDoNotDisturb,
  }) {
    return CallRecordEntity()
      ..callId = callId ?? this.callId
      ..channelId = channelId ?? this.channelId
      ..currUserId = currUserId ?? this.currUserId
      ..peerUserId = peerUserId ?? this.peerUserId
      ..callRole = callRole ?? this.callRole
      ..chargePrice = chargePrice ?? this.chargePrice
      ..chargeCount = chargeCount ?? this.chargeCount
      ..endType = endType ?? this.endType
      ..clientEndAt = clientEndAt ?? this.clientEndAt
      ..clientDuration = clientDuration ?? this.clientDuration
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..currUsername = currUsername ?? this.currUsername
      ..peerUsername = peerUsername ?? this.peerUsername
      ..peerNickname = peerNickname ?? this.peerNickname
      ..peerPortrait = peerPortrait ?? this.peerPortrait
      ..channelStatus = channelStatus ?? this.channelStatus
      ..startAt = startAt ?? this.startAt
      ..endAt = endAt ?? this.endAt
      ..peerIsOnline = peerIsOnline ?? this.peerIsOnline
      ..peerIsDoNotDisturb = peerIsDoNotDisturb ?? this.peerIsDoNotDisturb;
  }
}
