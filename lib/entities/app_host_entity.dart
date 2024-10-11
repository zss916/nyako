import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_format_util.dart';
import 'package:oliapro/utils/app_some_extension.dart';

import '../generated/json/app_host_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class HostDetail {
  HostDetail();

  factory HostDetail.fromJson(Map<String, dynamic> json) =>
      $HostDetailFromJson(json);

  Map<String, dynamic> toJson() => $HostDetailToJson(this);

  String? userId;
  String? username;
  int? auth;
  String? intro;
  String? portrait;
  String? nickname;
  int? areaCode;
  // 0,是否免打扰
  int? isDoNotDisturb;
  int? createdAt;
  // 0离线 1在线 2忙线
  int? isOnline;

  //用于匹配 自定义离线状态 0 为视频播放完毕 主播显示为离线
  int? customOnline;

  //用于匹配 标识这个播放器归属
  String? customVideoId;

  int? gender;
  int? country;
  int? charge;
  int? followed;
  int? followCount;
  int? connectRate;
  String? video;
  int? birthday;
  int? expLevel;
  int? heatValue;

  //拉黑主播时间
  int? updatedAt;

  List<HostMedia>? medias;
  List<HostMedia>? videos;

  AreaData? area;

  int get sortOnline => (realOnlineState == 1) ? 1 : 0;
  bool get isShowOnline => realOnlineState == 1;
  int get realOnlineState {
    if (isDoNotDisturb == 0) {
      return isOnline ?? 0;
    } else {
      return 0;
    }
  }

  List<HostTag>? tags;

  ///主播标签
  bool? isCurrentVideo;

  ///是否是当前视频(发现专用)

  // 默认Object的==是利用hashCode进行比较，跟Java一样，
  // 然后如果要实现dart对象的比较，可以重写==和hashCode
  @override
  bool operator ==(Object other) {
    // return super == other;
    if (identical(this, other)) return true;
    if (other is HostDetail) {
      return runtimeType == other.runtimeType && userId == other.userId;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + userId.hashCode;
    // result = 37 * result + age.hashCode;
    return result;
  }

  String get getUid => userId ?? "--";

  String get showId => username ?? "--";

  String get showPortrait => portrait ?? "";

  String get showVideo => (videos ?? []).first.path ?? "";

  String get showNickName =>
      ((nickname ?? '--').replaceAll(RegExp(r"\d"), "*").clipWithChar);

  String get showIntro =>
      (intro ?? "--").trim().isNotEmpty ? ((intro ?? "--").trim()) : "...";

  String get showBlackTime =>
      Tr.app_black_time.trArgs([dateFormat(updatedAt ?? 0)]).clipWithChar;

  String get showBirthday => birthday == null
      ? "18"
      : AppFormatUtil.getAge(DateTime.fromMillisecondsSinceEpoch(birthday ?? 0))
          .toString();

  /*String get stateIcon => (isOnline == 0 || isDoNotDisturb == 1)
      ? Assets.imgOfflineIcon
      : (isOnline == 1)
          ? Assets.imageOnlineIcon
          : Assets.imageBusyIcon;*/

  Color get stateColor => (isOnline == 0 || isDoNotDisturb == 1)
      ? const Color(0xFFBBBBBB)
      : (isOnline == 1)
          ? const Color(0xFF00C900)
          : const Color(0xFFF45240);

  bool get isNull => (portrait ?? "").isEmpty;

  bool get isChat =>
      (isOnline ?? 1) == 1 &&
      (isDoNotDisturb ?? 1) == 0 &&
      !AppConstants.isFakeMode;

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

  bool get isFollowed => followed == 1;

  List<String> get hostTags =>
      (tags ?? []).map((e) => e.tagValue ?? "--").toList();

  List<String> get hostTags2 => [
        "dsafdsa",
        "dsfdsafasfdsaewer",
        "dsafd",
        "dddd",
        "dsafdsa",
      ];

  void createData() {
    List<String> data = [];
    data = List.generate(100, (index) => "");
  }
}

@JsonSerializable()
class HostMedia {
  HostMedia();

  factory HostMedia.fromJson(Map<String, dynamic> json) =>
      $HostMediaFromJson(json);

  Map<String, dynamic> toJson() => $HostMediaToJson(this);

  int? mid;
  int? userId;
  String? path;
  //类型  图片 0  视频1
  int? type;
  int? selected;
  String? cover;
  int? locked;
  int? diamonds;
  int? likeCount;
  int? unlockCount;
  int? playCount;
  int? status;
  int? createdAt;
  int? updatedAt;
  dynamic? isPay;
  int? vipVisible; // 是否vip可见，0.否，1.是
  bool? isSelected; //本地

  String get showPath => (type == 0) ? path ?? "" : cover ?? "";
  bool get showLock => (vipVisible == 1); //vip 才可见
}

@JsonSerializable()
class HostTag {
  HostTag();

  factory HostTag.fromJson(Map<String, dynamic> json) => $HostTagFromJson(json);

  Map<String, dynamic> toJson() => $HostTagToJson(this);

  String? tagValue;
}
