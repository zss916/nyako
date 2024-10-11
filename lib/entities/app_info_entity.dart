import '../generated/json/app_info_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class InfoDetail {
  InfoDetail();

  factory InfoDetail.fromJson(Map<String, dynamic> json) =>
      $InfoDetailFromJson(json);

  Map<String, dynamic> toJson() => $InfoDetailToJson(this);

  //是否是新用户
  int? isNewUser;
  String? userId;
  String? username;
  int? auth;
  String? intro;
  String? portrait;
  String? nickname;
  int? areaCode;
  String? status;
  // 0,是否免打扰
  int? isDoNotDisturb;
  int? createdAt;
  // 1新用户 0老用户
  int? created;
  // 0离线 1在线 2忙线
  int? isOnline;
  int? isSignIn;
  // 1 所有道具数量,
  int? propCount;
  // 1 未使用的体验卡数量,
  int? callCardCount;
  // 已使用的体验卡数量,
  int? callCardUsedCount;
  // 体验卡时长,
  int? callCardDuration;
  int? releaseTime;
  // 1,性别1男0女
  int? gender;
  int? country; //
  int? connectRate;
  int? birthday;
  int? expLevel;
  int? followingCount;

  BalanceBean? userBalance;
  // fail false 0 的情况下才是
  String? startBirthday;
  bool? timeBirthday;
  int? stateGender;
  int? isVip;
  int? vipSignIn; // 1 已签到
  int? vipEndTime; // vip到期时间
  int? rechargeDrawCount; // 充值抽奖次数
  String? inviterCode; // 邀请人的邀请码
  // 是否绑定google账号, 0 未绑定 1 已绑定
  int? boundGoogle;
  //是否是审核模式
  bool get isAppRelease =>
      startBirthday == "fail" && timeBirthday == false && stateGender == 0;

  bool isTimeOut() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt ?? 0);
    int diffHours = DateTime.now().difference(dateTime).inHours;
    return (diffHours > 1);
  }

  ///vip 还剩7天 就提示续费
  bool isShowVipRenew() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(vipEndTime ?? 0);
    int diffDays = DateTime.now().difference(dateTime).inDays;
    return (diffDays <= 7) && (isVip == 1);
  }
}

@JsonSerializable()
class BalanceBean {
  BalanceBean();

  factory BalanceBean.fromJson(Map<String, dynamic> json) =>
      $BalanceBeanFromJson(json);

  Map<String, dynamic> toJson() => $BalanceBeanToJson(this);

  int? userId;
  int? totalRecharge;
  int? totalDiamonds;
  int? remainDiamonds;
  int? freeDiamonds;
  int? freeMsgCount;
  int? expLevel;
  int? createdAt;
  int? updatedAt;

  // 0：未充值
  // 1：累计充值金额10美元以下
  // 2：累计充值金额10-20
  // 3：累计充值金额20-30
  // 4：累计充值金额30-50
  // 5：累计充值金额50-80
  // 6：累计充值金额80-120
  // 7：累计充值金额120-200
  // 8：累计充值金额200-400
  // 9: 累计充值金额400-1000
  // 10：累计充值金额>1000
  int get userLevel {
    // 美元（分）
    final int money = totalRecharge ?? 0;
    if (money <= 0) {
      return 0;
    } else if (money < 1000) {
      return 1;
    } else if (money < 2000) {
      return 2;
    } else if (money < 3000) {
      return 3;
    } else if (money < 5000) {
      return 4;
    } else if (money < 8000) {
      return 5;
    } else if (money < 12000) {
      return 6;
    } else if (money < 20000) {
      return 7;
    } else if (money < 40000) {
      return 8;
    } else if (money < 100000) {
      return 9;
    } else {
      return 10;
    }
  }
}
