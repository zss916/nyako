import 'package:flutter/material.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/utils/app_format_util.dart';
import 'package:nyako/utils/app_some_extension.dart';

import '../generated/json/app_moment_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class MomentDetail {
  MomentDetail();

  factory MomentDetail.fromJson(Map<String, dynamic> json) =>
      $MomentDetailFromJson(json);

  Map<String, dynamic> toJson() => $MomentDetailToJson(this);
  // "momentId": 1559453194816651265,// 动态id
  // "userId": 107780487,// 主播id
  // "content": "abc",// 内容
  // "createdAt": 1660637589534,// 创建时间
  // "username": "1057684",// 主播短id
  // "nickname": "Mima",// 昵称
  // "portrait": "https://oss.hanilink.com/users_test/107780487/upload/media/2022-03-29/_1648521386627_sendimg.JPEG",// 头像
  // "isOnline": 0,// 是否在线，0.离线，1.在线，2.忙线
  // "isDoNotDisturb": 0,// 是否勿扰，0.否，1.勿扰
  // "followed": 0,// 是否关注，0.未关注，1.已关注
  // "praised": 0,// 是否点赞，0.未点赞，1.已点赞
  // "praiseCount": 0,// 点赞数
  // "charge": 60,// 主播视频收费
  // "medias": [// 资源列表
  //     {
  //         "mediaId": 1559453200571236353,// 资源id
  //         "mediaType": 0,// 资源类型，0.图片，1.视频
  //         "mediaUrl": "https://oss.hanilink.com/1.png",// 资源链接
  //         "screenshotUrl": null// 第一帧链接
  //     }
  // ]
  String? momentId;
  String? userId;
  String? content;
  String? username;
  int? createdAt;
  String? portrait;
  String? nickname;
  // 0,是否免打扰
  int? isDoNotDisturb;
  // 0离线 1在线 2忙线
  int? isOnline;

  int? gender;
  int? birthday;
  int? charge;
  int? followed;
  int? followCount;
  int? praised;
  int? praiseCount;

  List<MomentMedia>? medias;

  String get getUid => userId ?? "";

  String get showContent => (content ?? "").trim();

  String get showID => username ?? "";

  String get anchorId => userId ?? "";

  String get showPortrait => portrait ?? "";

  String get showTime => dateFormat(createdAt ?? 0, formatStr: 'yyyy.MM.dd');

  String get showNick =>
      (nickname ?? '--').replaceAll(RegExp(r"\d"), "*").clipWithChar;

  int lineState() => (isOnline == 0 || isDoNotDisturb == 1)
      ? LineType.offline.number
      : (isOnline == 1)
          ? LineType.online.number
          : LineType.busy.number;

  bool get isChat =>
      (isOnline ?? 1) == 1 &&
      (isDoNotDisturb ?? 1) == 0 &&
      !AppConstants.isFakeMode;

  List<String> get pathArray =>
      (medias ?? []).map((e) => e.mediaUrl ?? "").toList();

  String get dynamicTime => dateFormat(createdAt ?? 0, formatStr: 'yyyy/MM/dd');

  String get showBirthday => birthday == null
      ? "18"
      : AppFormatUtil.getAge(DateTime.fromMillisecondsSinceEpoch(birthday ?? 0))
          .toString();

  String get dynamicStartTime => dateFormat(createdAt ?? 0, formatStr: 'HH:mm');

  bool get isShowOnline => realOnlineState == 1;
  int get realOnlineState {
    if (isDoNotDisturb == 0) {
      return isOnline ?? 0;
    } else {
      return 0;
    }
  }

  Color get realOnlineColor {
    switch (realOnlineState) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  // 默认Object的==是利用hashCode进行比较，跟Java一样，
  // 然后如果要实现dart对象的比较，可以重写==和hashCode
  @override
  bool operator ==(Object other) {
    // return super == other;
    if (identical(this, other)) return true;
    if (other is MomentDetail) {
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
}

@JsonSerializable()
class MomentMedia {
  MomentMedia();

  factory MomentMedia.fromJson(Map<String, dynamic> json) =>
      $MomentMediaFromJson(json);

  Map<String, dynamic> toJson() => $MomentMediaToJson(this);

  String? mediaId;
  String? mediaUrl;
  String? screenshotUrl;
  //类型  图片 0  视频1
  int? mediaType;

  @JSONField(serialize: false, deserialize: false)
  String? localPath;
  // 0上传中，1上传完成，2失败
  @JSONField(serialize: false, deserialize: false)
  int? uploadState;
}
