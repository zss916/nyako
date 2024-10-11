import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/json/base/json_field.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_format_util.dart';
import 'package:oliapro/utils/app_some_extension.dart';

import '../generated/json/app_host_match_limit_entity.g.dart';

@JsonSerializable()
class HostMatchLimitEntity {
  int? matchCount;
  HostMatchLimitEntityAnchor? anchor;

  HostMatchLimitEntity();

  factory HostMatchLimitEntity.fromJson(Map<String, dynamic> json) =>
      $HostMatchLimitEntityFromJson(json);

  Map<String, dynamic> toJson() => $HostMatchLimitEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HostMatchLimitEntityAnchor {
  int? userId;
  String? nickName;
  String? portrait;
  int? charge;
  int? muteStatus; // 是否消音，0.消音，1.开启
  int? isOnline;
  int? isDoNotDisturb;
  String? areaCode;
  String? video;
  int? followed;
  int? birthday;

  String get showPortrait => portrait ?? "";
  String get showNickName =>
      ((nickName ?? '--').replaceAll(RegExp(r"\d"), "*").clipWithChar);
  String get showVideo => video ?? "";
  String get getUid => (userId ?? 0).toString();
  String get showBirthday => birthday == null
      ? "18"
      : AppFormatUtil.getAge(DateTime.fromMillisecondsSinceEpoch(birthday ?? 0))
          .toString();
  bool get isChat =>
      (isOnline ?? 1) == 1 &&
      (isDoNotDisturb ?? 1) == 0 &&
      !AppConstants.isFakeMode;
  bool get showMute => muteStatus == 1;

  int lineState() => (isOnline == 0 || isDoNotDisturb == 1)
      ? LineType.offline.number
      : (isOnline == 1)
          ? LineType.online.number
          : LineType.busy.number;

  String get stateStr => (isOnline == 0 || isDoNotDisturb == 1)
      ? Tr.app_base_offline.tr
      : (isOnline == 1)
          ? Tr.app_base_online.tr
          : Tr.app_base_busy.tr;

  HostMatchLimitEntityAnchor();

  factory HostMatchLimitEntityAnchor.fromJson(Map<String, dynamic> json) =>
      $HostMatchLimitEntityAnchorFromJson(json);

  Map<String, dynamic> toJson() => $HostMatchLimitEntityAnchorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
