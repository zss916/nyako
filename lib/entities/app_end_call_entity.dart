import '../generated/json/base/json_field.dart';
import '../generated/json/app_end_call_entity.g.dart';

@JsonSerializable()
class EndCallEntity {
  EndCallEntity();

  factory EndCallEntity.fromJson(Map<String, dynamic> json) =>
      $EndCallEntityFromJson(json);

  Map<String, dynamic> toJson() => $EndCallEntityToJson(this);

  String? channelId;
  bool? usedProp;
  String? callTime;
  String? totalCallTime;
  int? callAmount;
  int? giftAmount;
  int? remainAmount;
  bool? ratedApp;
}
