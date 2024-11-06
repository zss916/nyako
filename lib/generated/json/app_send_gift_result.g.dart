import 'package:nyako/entities/app_send_gift_result.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

SendGiftResult $SendGiftResultFromJson(Map<String, dynamic> json) {
  final SendGiftResult sendGiftResult = SendGiftResult();
  final int? gid = jsonConvert.convert<int>(json['gid']);
  if (gid != null) {
    sendGiftResult.gid = gid;
  }
  final int? deposit = jsonConvert.convert<int>(json['deposit']);
  if (deposit != null) {
    sendGiftResult.deposit = deposit;
  }
  final int? time = jsonConvert.convert<int>(json['time']);
  if (time != null) {
    sendGiftResult.time = time;
  }
  return sendGiftResult;
}

Map<String, dynamic> $SendGiftResultToJson(SendGiftResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['gid'] = entity.gid;
  data['deposit'] = entity.deposit;
  data['time'] = entity.time;
  return data;
}

extension SendGiftResultExtension on SendGiftResult {
  SendGiftResult copyWith({
    int? gid,
    int? deposit,
    int? time,
  }) {
    return SendGiftResult()
      ..gid = gid ?? this.gid
      ..deposit = deposit ?? this.deposit
      ..time = time ?? this.time;
  }
}
