import 'package:oliapro/entities/app_info_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

InfoDetail $InfoDetailFromJson(Map<String, dynamic> json) {
  final InfoDetail infoDetail = InfoDetail();
  final int? isNewUser = jsonConvert.convert<int>(json['isNewUser']);
  if (isNewUser != null) {
    infoDetail.isNewUser = isNewUser;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    infoDetail.userId = userId;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    infoDetail.username = username;
  }
  final int? auth = jsonConvert.convert<int>(json['auth']);
  if (auth != null) {
    infoDetail.auth = auth;
  }
  final String? intro = jsonConvert.convert<String>(json['intro']);
  if (intro != null) {
    infoDetail.intro = intro;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    infoDetail.portrait = portrait;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    infoDetail.nickname = nickname;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    infoDetail.areaCode = areaCode;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    infoDetail.status = status;
  }
  final int? isDoNotDisturb = jsonConvert.convert<int>(json['isDoNotDisturb']);
  if (isDoNotDisturb != null) {
    infoDetail.isDoNotDisturb = isDoNotDisturb;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    infoDetail.createdAt = createdAt;
  }
  final int? created = jsonConvert.convert<int>(json['created']);
  if (created != null) {
    infoDetail.created = created;
  }
  final int? isOnline = jsonConvert.convert<int>(json['isOnline']);
  if (isOnline != null) {
    infoDetail.isOnline = isOnline;
  }
  final int? isSignIn = jsonConvert.convert<int>(json['isSignIn']);
  if (isSignIn != null) {
    infoDetail.isSignIn = isSignIn;
  }
  final int? propCount = jsonConvert.convert<int>(json['propCount']);
  if (propCount != null) {
    infoDetail.propCount = propCount;
  }
  final int? callCardCount = jsonConvert.convert<int>(json['callCardCount']);
  if (callCardCount != null) {
    infoDetail.callCardCount = callCardCount;
  }
  final int? callCardUsedCount =
      jsonConvert.convert<int>(json['callCardUsedCount']);
  if (callCardUsedCount != null) {
    infoDetail.callCardUsedCount = callCardUsedCount;
  }
  final int? callCardDuration =
      jsonConvert.convert<int>(json['callCardDuration']);
  if (callCardDuration != null) {
    infoDetail.callCardDuration = callCardDuration;
  }
  final int? releaseTime = jsonConvert.convert<int>(json['releaseTime']);
  if (releaseTime != null) {
    infoDetail.releaseTime = releaseTime;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    infoDetail.gender = gender;
  }
  final int? country = jsonConvert.convert<int>(json['country']);
  if (country != null) {
    infoDetail.country = country;
  }
  final int? connectRate = jsonConvert.convert<int>(json['connectRate']);
  if (connectRate != null) {
    infoDetail.connectRate = connectRate;
  }
  final int? birthday = jsonConvert.convert<int>(json['birthday']);
  if (birthday != null) {
    infoDetail.birthday = birthday;
  }
  final int? expLevel = jsonConvert.convert<int>(json['expLevel']);
  if (expLevel != null) {
    infoDetail.expLevel = expLevel;
  }
  final int? followingCount = jsonConvert.convert<int>(json['followingCount']);
  if (followingCount != null) {
    infoDetail.followingCount = followingCount;
  }
  final BalanceBean? userBalance =
      jsonConvert.convert<BalanceBean>(json['userBalance']);
  if (userBalance != null) {
    infoDetail.userBalance = userBalance;
  }
  final String? startBirthday =
      jsonConvert.convert<String>(json['startBirthday']);
  if (startBirthday != null) {
    infoDetail.startBirthday = startBirthday;
  }
  final bool? timeBirthday = jsonConvert.convert<bool>(json['timeBirthday']);
  if (timeBirthday != null) {
    infoDetail.timeBirthday = timeBirthday;
  }
  final int? stateGender = jsonConvert.convert<int>(json['stateGender']);
  if (stateGender != null) {
    infoDetail.stateGender = stateGender;
  }
  final int? isVip = jsonConvert.convert<int>(json['isVip']);
  if (isVip != null) {
    infoDetail.isVip = isVip;
  }
  final int? vipSignIn = jsonConvert.convert<int>(json['vipSignIn']);
  if (vipSignIn != null) {
    infoDetail.vipSignIn = vipSignIn;
  }
  final int? vipEndTime = jsonConvert.convert<int>(json['vipEndTime']);
  if (vipEndTime != null) {
    infoDetail.vipEndTime = vipEndTime;
  }
  final int? rechargeDrawCount =
      jsonConvert.convert<int>(json['rechargeDrawCount']);
  if (rechargeDrawCount != null) {
    infoDetail.rechargeDrawCount = rechargeDrawCount;
  }
  final String? inviterCode = jsonConvert.convert<String>(json['inviterCode']);
  if (inviterCode != null) {
    infoDetail.inviterCode = inviterCode;
  }
  final int? boundGoogle = jsonConvert.convert<int>(json['boundGoogle']);
  if (boundGoogle != null) {
    infoDetail.boundGoogle = boundGoogle;
  }
  return infoDetail;
}

Map<String, dynamic> $InfoDetailToJson(InfoDetail entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isNewUser'] = entity.isNewUser;
  data['userId'] = entity.userId;
  data['username'] = entity.username;
  data['auth'] = entity.auth;
  data['intro'] = entity.intro;
  data['portrait'] = entity.portrait;
  data['nickname'] = entity.nickname;
  data['areaCode'] = entity.areaCode;
  data['status'] = entity.status;
  data['isDoNotDisturb'] = entity.isDoNotDisturb;
  data['createdAt'] = entity.createdAt;
  data['created'] = entity.created;
  data['isOnline'] = entity.isOnline;
  data['isSignIn'] = entity.isSignIn;
  data['propCount'] = entity.propCount;
  data['callCardCount'] = entity.callCardCount;
  data['callCardUsedCount'] = entity.callCardUsedCount;
  data['callCardDuration'] = entity.callCardDuration;
  data['releaseTime'] = entity.releaseTime;
  data['gender'] = entity.gender;
  data['country'] = entity.country;
  data['connectRate'] = entity.connectRate;
  data['birthday'] = entity.birthday;
  data['expLevel'] = entity.expLevel;
  data['followingCount'] = entity.followingCount;
  data['userBalance'] = entity.userBalance?.toJson();
  data['startBirthday'] = entity.startBirthday;
  data['timeBirthday'] = entity.timeBirthday;
  data['stateGender'] = entity.stateGender;
  data['isVip'] = entity.isVip;
  data['vipSignIn'] = entity.vipSignIn;
  data['vipEndTime'] = entity.vipEndTime;
  data['rechargeDrawCount'] = entity.rechargeDrawCount;
  data['inviterCode'] = entity.inviterCode;
  data['boundGoogle'] = entity.boundGoogle;
  return data;
}

extension InfoDetailExtension on InfoDetail {
  InfoDetail copyWith({
    int? isNewUser,
    String? userId,
    String? username,
    int? auth,
    String? intro,
    String? portrait,
    String? nickname,
    int? areaCode,
    String? status,
    int? isDoNotDisturb,
    int? createdAt,
    int? created,
    int? isOnline,
    int? isSignIn,
    int? propCount,
    int? callCardCount,
    int? callCardUsedCount,
    int? callCardDuration,
    int? releaseTime,
    int? gender,
    int? country,
    int? connectRate,
    int? birthday,
    int? expLevel,
    int? followingCount,
    BalanceBean? userBalance,
    String? startBirthday,
    bool? timeBirthday,
    int? stateGender,
    int? isVip,
    int? vipSignIn,
    int? vipEndTime,
    int? rechargeDrawCount,
    String? inviterCode,
    int? boundGoogle,
  }) {
    return InfoDetail()
      ..isNewUser = isNewUser ?? this.isNewUser
      ..userId = userId ?? this.userId
      ..username = username ?? this.username
      ..auth = auth ?? this.auth
      ..intro = intro ?? this.intro
      ..portrait = portrait ?? this.portrait
      ..nickname = nickname ?? this.nickname
      ..areaCode = areaCode ?? this.areaCode
      ..status = status ?? this.status
      ..isDoNotDisturb = isDoNotDisturb ?? this.isDoNotDisturb
      ..createdAt = createdAt ?? this.createdAt
      ..created = created ?? this.created
      ..isOnline = isOnline ?? this.isOnline
      ..isSignIn = isSignIn ?? this.isSignIn
      ..propCount = propCount ?? this.propCount
      ..callCardCount = callCardCount ?? this.callCardCount
      ..callCardUsedCount = callCardUsedCount ?? this.callCardUsedCount
      ..callCardDuration = callCardDuration ?? this.callCardDuration
      ..releaseTime = releaseTime ?? this.releaseTime
      ..gender = gender ?? this.gender
      ..country = country ?? this.country
      ..connectRate = connectRate ?? this.connectRate
      ..birthday = birthday ?? this.birthday
      ..expLevel = expLevel ?? this.expLevel
      ..followingCount = followingCount ?? this.followingCount
      ..userBalance = userBalance ?? this.userBalance
      ..startBirthday = startBirthday ?? this.startBirthday
      ..timeBirthday = timeBirthday ?? this.timeBirthday
      ..stateGender = stateGender ?? this.stateGender
      ..isVip = isVip ?? this.isVip
      ..vipSignIn = vipSignIn ?? this.vipSignIn
      ..vipEndTime = vipEndTime ?? this.vipEndTime
      ..rechargeDrawCount = rechargeDrawCount ?? this.rechargeDrawCount
      ..inviterCode = inviterCode ?? this.inviterCode
      ..boundGoogle = boundGoogle ?? this.boundGoogle;
  }
}

BalanceBean $BalanceBeanFromJson(Map<String, dynamic> json) {
  final BalanceBean balanceBean = BalanceBean();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    balanceBean.userId = userId;
  }
  final int? totalRecharge = jsonConvert.convert<int>(json['totalRecharge']);
  if (totalRecharge != null) {
    balanceBean.totalRecharge = totalRecharge;
  }
  final int? totalDiamonds = jsonConvert.convert<int>(json['totalDiamonds']);
  if (totalDiamonds != null) {
    balanceBean.totalDiamonds = totalDiamonds;
  }
  final int? remainDiamonds = jsonConvert.convert<int>(json['remainDiamonds']);
  if (remainDiamonds != null) {
    balanceBean.remainDiamonds = remainDiamonds;
  }
  final int? freeDiamonds = jsonConvert.convert<int>(json['freeDiamonds']);
  if (freeDiamonds != null) {
    balanceBean.freeDiamonds = freeDiamonds;
  }
  final int? freeMsgCount = jsonConvert.convert<int>(json['freeMsgCount']);
  if (freeMsgCount != null) {
    balanceBean.freeMsgCount = freeMsgCount;
  }
  final int? expLevel = jsonConvert.convert<int>(json['expLevel']);
  if (expLevel != null) {
    balanceBean.expLevel = expLevel;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    balanceBean.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    balanceBean.updatedAt = updatedAt;
  }
  return balanceBean;
}

Map<String, dynamic> $BalanceBeanToJson(BalanceBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['totalRecharge'] = entity.totalRecharge;
  data['totalDiamonds'] = entity.totalDiamonds;
  data['remainDiamonds'] = entity.remainDiamonds;
  data['freeDiamonds'] = entity.freeDiamonds;
  data['freeMsgCount'] = entity.freeMsgCount;
  data['expLevel'] = entity.expLevel;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  return data;
}

extension BalanceBeanExtension on BalanceBean {
  BalanceBean copyWith({
    int? userId,
    int? totalRecharge,
    int? totalDiamonds,
    int? remainDiamonds,
    int? freeDiamonds,
    int? freeMsgCount,
    int? expLevel,
    int? createdAt,
    int? updatedAt,
  }) {
    return BalanceBean()
      ..userId = userId ?? this.userId
      ..totalRecharge = totalRecharge ?? this.totalRecharge
      ..totalDiamonds = totalDiamonds ?? this.totalDiamonds
      ..remainDiamonds = remainDiamonds ?? this.remainDiamonds
      ..freeDiamonds = freeDiamonds ?? this.freeDiamonds
      ..freeMsgCount = freeMsgCount ?? this.freeMsgCount
      ..expLevel = expLevel ?? this.expLevel
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}
