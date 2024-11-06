import 'package:nyako/entities/app_invite_info_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

InviteInfoEntity $InviteInfoEntityFromJson(Map<String, dynamic> json) {
  final InviteInfoEntity inviteInfoEntity = InviteInfoEntity();
  final String? inviteCode = jsonConvert.convert<String>(json['inviteCode']);
  if (inviteCode != null) {
    inviteInfoEntity.inviteCode = inviteCode;
  }
  final int? inviteCount = jsonConvert.convert<int>(json['inviteCount']);
  if (inviteCount != null) {
    inviteInfoEntity.inviteCount = inviteCount;
  }
  final int? awardIncome = jsonConvert.convert<int>(json['awardIncome']);
  if (awardIncome != null) {
    inviteInfoEntity.awardIncome = awardIncome;
  }
  final int? inviteAward = jsonConvert.convert<int>(json['inviteAward']);
  if (inviteAward != null) {
    inviteInfoEntity.inviteAward = inviteAward;
  }
  final int? rechargeAward = jsonConvert.convert<int>(json['rechargeAward']);
  if (rechargeAward != null) {
    inviteInfoEntity.rechargeAward = rechargeAward;
  }
  final int? inviteeCardCount =
      jsonConvert.convert<int>(json['inviteeCardCount']);
  if (inviteeCardCount != null) {
    inviteInfoEntity.inviteeCardCount = inviteeCardCount;
  }
  final String? shareContent =
      jsonConvert.convert<String>(json['shareContent']);
  if (shareContent != null) {
    inviteInfoEntity.shareContent = shareContent;
  }
  final String? shareUrl = jsonConvert.convert<String>(json['shareUrl']);
  if (shareUrl != null) {
    inviteInfoEntity.shareUrl = shareUrl;
  }
  final List<String>? portraits = (json['portraits'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (portraits != null) {
    inviteInfoEntity.portraits = portraits;
  }
  return inviteInfoEntity;
}

Map<String, dynamic> $InviteInfoEntityToJson(InviteInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['inviteCode'] = entity.inviteCode;
  data['inviteCount'] = entity.inviteCount;
  data['awardIncome'] = entity.awardIncome;
  data['inviteAward'] = entity.inviteAward;
  data['rechargeAward'] = entity.rechargeAward;
  data['inviteeCardCount'] = entity.inviteeCardCount;
  data['shareContent'] = entity.shareContent;
  data['shareUrl'] = entity.shareUrl;
  data['portraits'] = entity.portraits;
  return data;
}

extension InviteInfoEntityExtension on InviteInfoEntity {
  InviteInfoEntity copyWith({
    String? inviteCode,
    int? inviteCount,
    int? awardIncome,
    int? inviteAward,
    int? rechargeAward,
    int? inviteeCardCount,
    String? shareContent,
    String? shareUrl,
    List<String>? portraits,
  }) {
    return InviteInfoEntity()
      ..inviteCode = inviteCode ?? this.inviteCode
      ..inviteCount = inviteCount ?? this.inviteCount
      ..awardIncome = awardIncome ?? this.awardIncome
      ..inviteAward = inviteAward ?? this.inviteAward
      ..rechargeAward = rechargeAward ?? this.rechargeAward
      ..inviteeCardCount = inviteeCardCount ?? this.inviteeCardCount
      ..shareContent = shareContent ?? this.shareContent
      ..shareUrl = shareUrl ?? this.shareUrl
      ..portraits = portraits ?? this.portraits;
  }
}
