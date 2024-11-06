import 'dart:convert';

import 'package:nyako/generated/json/base/json_field.dart';
import 'package:nyako/utils/app_extends.dart';

import '../generated/json/app_call_record_entity.g.dart';

@JsonSerializable()
class CallRecordEntity {
  int? callId;
  int? channelId;
  int? currUserId;
  int? peerUserId;
  int? callRole;
  int? chargePrice;
  int? chargeCount;
  // 挂断原因，-1.电话未接通，0.正常挂断，1.对方离线，2.声网连接失败，3.对方挂断，
  // 4.续key失败，5.创建通话记录失败，6.余额不足，7.被封禁，8.连接超时
  int? endType;
  int? clientEndAt;
  int? clientDuration;
  int? createdAt;
  int? updatedAt;
  String? currUsername;
  String? peerUsername;
  String? peerNickname;
  String? peerPortrait;
  //频道状态，0.拨号中，1.已接通，2.被叫拒绝，3.主叫方取消，4.通话完成，5.异常结束
  int? channelStatus;
  int? startAt;

  ///通话开始时间
  int? endAt;

  ///通话结束时间
  int? peerIsOnline; // 对方是否在线，0.离线，1.在线，2.忙线
  int? peerIsDoNotDisturb; // 	对方是否勿扰，1勿扰

  ///通话时长
  String get callDuration => formatDuration(((endAt ?? 0) - (startAt ?? 0)));

  String get callTip => "Duration of this call";

  int lineState() => (peerIsOnline == 0 || peerIsDoNotDisturb == 1)
      ? LineType.offline.number
      : (peerIsOnline == 1)
          ? LineType.online.number
          : LineType.busy.number;

  CallRecordEntity();

  factory CallRecordEntity.fromJson(Map<String, dynamic> json) =>
      $CallRecordEntityFromJson(json);

  Map<String, dynamic> toJson() => $CallRecordEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
