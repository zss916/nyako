import 'dart:convert';

import 'package:oliapro/generated/json/app_contribute_entity.g.dart';
import 'package:oliapro/generated/json/base/json_field.dart';
import 'package:oliapro/utils/app_some_extension.dart';

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

  ContributeEntity();

  factory ContributeEntity.fromJson(Map<String, dynamic> json) =>
      $ContributeEntityFromJson(json);

  Map<String, dynamic> toJson() => $ContributeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
