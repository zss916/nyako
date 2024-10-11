import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/json/app_sign_card_entity.g.dart';
import 'package:oliapro/pages/main/me/mine/widget/avatar_state.dart';

import '../generated/json/base/json_field.dart';

@JsonSerializable()
class AppLiveSignCard {
  AppLiveSignCard();

  factory AppLiveSignCard.fromJson(Map<String, dynamic> json) =>
      $AppLiveSignCardFromJson(json);

  Map<String, dynamic> toJson() => $AppLiveSignCardToJson(this);

  int? propId;
  int? userId;
  int? propType; // 1.通话体验卡，2.钻石加成卡，3.礼物卡，4.视频卡，5.聊天卡，6.头像框
  int? propStatus; // 道具状态，0.未使用，1.已使用，2.已作废
  int? propDuration; // 体验卡道具可使用的时长 天数
  int? createdAt; //
  String? icon; // 图标
  String? name; // 名字
  String? signDate; //  签到时间（没签到过就没有）
  ///本地
  String? showEndTime;

  ///是否使用
  bool? isUsed;

  ///是否是vip 头像
  bool get isVipFrame => propId == AvatarStatusHand.vipPropID;

  String avatarEndTime() {
    return (propId == AvatarStatusHand.vipPropID)
        ? ''
        : Tr.appOverdueDays.trArgs([getRemainDays().toString()]);
  }

  // 剩余的毫秒数
  int getRemainTimes() {
    if (createdAt == null || propDuration == null) return 0;
    return (createdAt! + propDuration! * 24 * 60 * 60 * 1000) -
        DateTime.now().millisecondsSinceEpoch;
  }

  // int get propTime => (createdAt! + propDuration! * 24 * 60 * 60 * 1000);

  // 剩余的天数
  int getRemainDays() {
    int ms = getRemainTimes();
    if (ms <= 0) {
      ms = 0;
    }
    return Duration(milliseconds: ms).inDays + 1;
  }

  ///chatCardTitle
  String get showChatCardTitle =>
      Tr.appSignMsgCard.trArgs([(propDuration ?? 1).toString()]);

  ///chatCardContent
  String get showChatCardContent =>
      Tr.appMsgCardDays.trArgs([(propDuration ?? 1).toString()]);

  String showChatCardStatus() {
    String status = "";
    switch (propStatus) {
      case 0:
        status = "未使用";
        break;
      case 1:
        status = "已使用";
        break;
      case 2:
        status = "已作废";
        break;
    }
    return status;
  }
}
