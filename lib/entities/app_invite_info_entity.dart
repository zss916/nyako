import 'dart:convert';

import 'package:oliapro/generated/json/app_invite_info_entity.g.dart';
import 'package:oliapro/generated/json/base/json_field.dart';

@JsonSerializable()
class InviteInfoEntity {
  String? inviteCode;
  int? inviteCount;
  int? awardIncome;
  int? inviteAward;
  int? rechargeAward;
  int? inviteeCardCount;
  String? shareContent;
  String? shareUrl;
  List<String>? portraits;

  InviteInfoEntity();

  factory InviteInfoEntity.fromJson(Map<String, dynamic> json) =>
      $InviteInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $InviteInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
