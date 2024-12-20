import 'dart:convert';

import 'package:nyako/generated/json/app_contribute_entity.g.dart';
import 'package:nyako/generated/json/base/json_field.dart';
import 'package:nyako/utils/app_some_extension.dart';

@JsonSerializable()
class ContributeEntity {
  int? amount;
  int? isDoNotDisturb;
  int? isOnline;
  String? nickname;
  int? offlineAt;
  String? portrait;
  int? userId;
  String? username;

  String get showNickName => (nickname ?? "--").convertName;

  String get showPortrait => (portrait ?? "");

  String get showUserName => "ID:${(username ?? "")}";

  ContributeEntity();

  factory ContributeEntity.fromJson(Map<String, dynamic> json) =>
      $ContributeEntityFromJson(json);

  Map<String, dynamic> toJson() => $ContributeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
