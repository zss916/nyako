import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/generated/json/app_draw_user_entity.g.dart';
import 'package:oliapro/generated/json/base/json_field.dart';
import 'package:oliapro/utils/app_some_extension.dart';

import '../common/language_key.dart';

@JsonSerializable()
class DrawUserEntity {
  int? userId;
  String? nickname;
  String? portrait;
  int? configId;
  String? name;
  String? icon;
  int? value;

  //本地
  String? content;

  DrawUserEntity();

  factory DrawUserEntity.fromJson(Map<String, dynamic> json) =>
      $DrawUserEntityFromJson(json);

  Map<String, dynamic> toJson() => $DrawUserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  String getContent() {
    String showName = "";
    String nName =
        (nickname ?? '--').replaceAll(RegExp(r"\d"), "*").clipWithChar;
    if (nName.length >= 15) {
      showName = "${nName.substring(0, 8)}...";
    } else {
      showName = nName;
    }
    return Tr.app_win_tip.trParams({"key1": showName, "key2": "$name"});
  }
}
