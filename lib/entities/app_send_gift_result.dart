import '../generated/json/base/json_field.dart';
import '../generated/json/app_send_gift_result.g.dart';

@JsonSerializable()
class SendGiftResult {
  SendGiftResult();

  factory SendGiftResult.fromJson(Map<String, dynamic> json) =>
      $SendGiftResultFromJson(json);

  Map<String, dynamic> toJson() => $SendGiftResultToJson(this);

  int? gid;
  int? deposit;
  int? time;
}
