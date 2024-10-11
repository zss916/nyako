import 'package:oliapro/entities/app_end_call_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

EndCallEntity $EndCallEntityFromJson(Map<String, dynamic> json) {
  final EndCallEntity endCallEntity = EndCallEntity();
  final String? channelId = jsonConvert.convert<String>(json['channelId']);
  if (channelId != null) {
    endCallEntity.channelId = channelId;
  }
  final bool? usedProp = jsonConvert.convert<bool>(json['usedProp']);
  if (usedProp != null) {
    endCallEntity.usedProp = usedProp;
  }
  final String? callTime = jsonConvert.convert<String>(json['callTime']);
  if (callTime != null) {
    endCallEntity.callTime = callTime;
  }
  final String? totalCallTime =
      jsonConvert.convert<String>(json['totalCallTime']);
  if (totalCallTime != null) {
    endCallEntity.totalCallTime = totalCallTime;
  }
  final int? callAmount = jsonConvert.convert<int>(json['callAmount']);
  if (callAmount != null) {
    endCallEntity.callAmount = callAmount;
  }
  final int? giftAmount = jsonConvert.convert<int>(json['giftAmount']);
  if (giftAmount != null) {
    endCallEntity.giftAmount = giftAmount;
  }
  final int? remainAmount = jsonConvert.convert<int>(json['remainAmount']);
  if (remainAmount != null) {
    endCallEntity.remainAmount = remainAmount;
  }
  final bool? ratedApp = jsonConvert.convert<bool>(json['ratedApp']);
  if (ratedApp != null) {
    endCallEntity.ratedApp = ratedApp;
  }
  return endCallEntity;
}

Map<String, dynamic> $EndCallEntityToJson(EndCallEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['channelId'] = entity.channelId;
  data['usedProp'] = entity.usedProp;
  data['callTime'] = entity.callTime;
  data['totalCallTime'] = entity.totalCallTime;
  data['callAmount'] = entity.callAmount;
  data['giftAmount'] = entity.giftAmount;
  data['remainAmount'] = entity.remainAmount;
  data['ratedApp'] = entity.ratedApp;
  return data;
}

extension EndCallEntityExtension on EndCallEntity {
  EndCallEntity copyWith({
    String? channelId,
    bool? usedProp,
    String? callTime,
    String? totalCallTime,
    int? callAmount,
    int? giftAmount,
    int? remainAmount,
    bool? ratedApp,
  }) {
    return EndCallEntity()
      ..channelId = channelId ?? this.channelId
      ..usedProp = usedProp ?? this.usedProp
      ..callTime = callTime ?? this.callTime
      ..totalCallTime = totalCallTime ?? this.totalCallTime
      ..callAmount = callAmount ?? this.callAmount
      ..giftAmount = giftAmount ?? this.giftAmount
      ..remainAmount = remainAmount ?? this.remainAmount
      ..ratedApp = ratedApp ?? this.ratedApp;
  }
}
