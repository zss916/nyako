import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/generated/json/sign_entity.g.dart';

import '../generated/json/base/json_field.dart';

@JsonSerializable()
class SignData {
  SignData();

  factory SignData.fromJson(Map<String, dynamic> json) =>
      $SignDataFromJson(json);

  Map<String, dynamic> toJson() => $SignDataToJson(this);

  List<SignBean>? signInDaily;
  List<SignBean>? signInDailyVip;

  ///new add
  bool? userSignFlag; // 普通是否可签到
  bool? vipSignFlag; // VIP是否可签到
  int? signDay; // 当前可签到天数,第几个（1-7）

  // 获取已经签到的天数
  int getSignNum({bool isVip = false}) {
    int total = 0;
    int normal = 0;
    if (signInDaily != null && signInDaily!.isNotEmpty) {
      normal = signInDaily!
          .where((element) => element.checkSinged())
          .toList()
          .length;

      /*for (var value
          in signInDaily!.where((element) => element.checkSinged()).toList()) {
        debugPrint("signDate com===>>> ${value.signDate}");
      }*/
    }
    int vip = 0;
    if (signInDailyVip != null && signInDailyVip!.isNotEmpty) {
      vip = signInDailyVip!
          .where((element) => element.checkSinged())
          .toList()
          .length;

      /*for (var value in signInDailyVip!
          .where((element) => element.checkSinged())
          .toList()) {
        debugPrint("signDate vip===>>> ${value.signDate}");
      }*/
    }
    // debugPrint("===>>> $normal, $vip");
    if (isVip) {
      if (vip == 0) {
        if (normal == 0) {
          total = normal + vip;
        } else {
          total = normal + vip - 1;
        }
      } else {
        if (normal == 0) {
          total = normal + vip;
        } else {
          total = normal + vip - 1;
        }
      }
    } else {
      total = normal + vip;
    }
    return total;
  }

  ///普通签到当天数据
  SignBean getCommonSignData({bool isVip = false}) {
    //getSignIndex(isVip: isVip)
    return (signInDaily ?? [])[((signDay ?? 1) - 1)];
  }

  ///vip签到当天数据
  SignBean getVipSignData({bool isVip = false}) {
    return (signInDailyVip ?? [])[((signDay ?? 1) - 1)];
  }

  int getSignIndex({bool isVip = false}) {
    return getSignNum(isVip: isVip) >= 7 ? 6 : getSignNum(isVip: isVip);
  }

  ///是否去签到
  bool isToSign({bool isVip = false}) {
    bool toSign = false;
    String toady = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bool isTodayVipSigned = (signInDailyVip ?? [])
        .where((element) => element.signDate != null)
        .map((e) => e.signDate)
        .contains(toady);
    bool isTodayCommonSigned = (signInDaily ?? [])
        .where((element) => element.signDate != null)
        .map((e) => e.signDate)
        .contains(toady);

    if (isVip) {
      toSign = (isTodayVipSigned == false);
    } else {
      toSign = (isTodayVipSigned == false) && (isTodayCommonSigned == false);
    }
    return toSign;
  }
}

@JsonSerializable()
class SignBean {
  SignBean();

  factory SignBean.fromJson(Map<String, dynamic> json) =>
      $SignBeanFromJson(json);

  Map<String, dynamic> toJson() => $SignBeanToJson(this);

  int? id;
  int? configId;
  int? isVip; // 是否VIP奖品

  // 大转盘次数，头像框类型，视频卡数量，聊天卡天数，钻石加成卡比例
  // 头像框类型是1.精致头像框，2.白金头像框，3.黄金头像框，4.钻石头像框，5.王者头像框
  int? value;
  int? vipDiamonds;
  String? icon; // 图标
  String? name; // 名字
  String? signDate; //  签到时间（没签到过就没有）
  int? type;

  // 钻石  DIAMOND(1),
  // 经验 EXPERIENCE(2),
  // 视频卡VIDEO_CARD(3),
  // 匹配卡 MATCHING_CARD(4),
  // 未中奖 NONE(5),
  // 随机奖励 RANDOM(6);
  // 聊天卡 CHAT_CARD(7),
  // 充值抽奖 RECHARGE_DRAW(8),
  // 钻石加成卡 DIAMOND_CARD(9),
  // 头像框 PORTRAIT_FRAME(10),

  String showSignName() {
    // debugPrint("==>>>${type},==>${value}");
    String name = "";
    switch (type) {
      case 6:
        name = Tr.appSignReward.tr;
        break;
      case 9:
        name = "x1";
        break;
      default:
        name = "x$value";
        break;
    }
    return name;
  }

  ///icon
  String showIcon() {
    String path = icon ?? '';
    switch (type) {
      case 1:
        path = Assets.imgDiamond;
        break;
      case 3:
        path = Assets.signRewardCallCard;
        break;
      case 5:
        path = Assets.lotteryLotteryEmpty;
        break;
      case 6:
        path = Assets.signGift;
        break;
      case 7:
        path = Assets.signRewardChatCard;
        break;
      case 8:
        path = Assets.signRewardTrun;
        break;
      case 9:
        path = Assets.signRewardDiamondAddCard;
        break;
      case 10:
        path = Assets.signRewardFrame;
        break;
      default:
        path = icon ?? '';
        break;
    }
    return path;
  }

  String showDailyIcon() {
    String path = icon ?? '';
    switch (type) {
      case 1:
        path = Assets.imgDiamond;
        break;
      case 3:
        path = Assets.signCallCard;
        break;
      case 5:
        path = Assets.lotteryLotteryEmpty;
        break;
      case 6:
        path = Assets.signGift;
        break;
      case 7:
        path = Assets.signChatCard;
        break;
      case 8:
        path = Assets.signTrun;
        break;
      case 9:
        path = Assets.signDiamondAddCard;
        break;
      case 10:
        path = Assets.signFrame;
        break;
      default:
        path = icon ?? '';
        break;
    }
    return path;
  }

  String showName() {
    String n = name ?? '';
    switch (type) {
      case 1:
        n = Tr.app_diamond.tr;
        break;
      case 3:
        n = Tr.app_dialog_call_experience_card.trArgs(['${value ?? 1}']);
        break;
      case 6:
        n = Tr.appSignReward.tr;
        break;
      case 7:
        n = Tr.appSignMsgCard.trArgs(['${value ?? 1}']);
        break;
      case 8:
        n = Tr.appSignDraw.trArgs(['${value ?? 1}']);
        break;
      case 9:
        n = Tr.app_prop_add_title.trArgs([(value ?? 0).toString()]);
        break;
      case 10:
        // 白金头像框先不搞了
        if (value == 3) {
          n = Tr.appSignHeaderGold.tr;
        } else if (value == 4) {
          n = Tr.appSignHeaderDiamond.tr;
        } else if (value == 5) {
          n = Tr.appSignHeaderKing.tr;
        } else {
          n = Tr.appSignHeader.tr;
        }
        break;
    }
    return n;
  }

  // 是否已经签到了
  bool checkSinged() {
    return signDate?.isNotEmpty == true;
  }

  bool get isSigned => signDate?.isNotEmpty == true;

  String get todayDate => DateFormat("yyyy-MM-dd").format(DateTime.now());
}
