import 'package:oliapro/entities/app_card_entity.dart';
import 'package:oliapro/services/user_info.dart';

import '../generated/json/app_gift_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class GiftEntity {
  GiftEntity();

  factory GiftEntity.fromJson(Map<String, dynamic> json) =>
      $GiftEntityFromJson(json);

  Map<String, dynamic> toJson() => $GiftEntityToJson(this);

  int? createdAt;
  int? updatedAt;
  int? gid;
  String? name;
  int? diamonds;
  int? type;
  String? icon;
  String? animEffectUrl;
  int? areaCode;
  int? online;
  int? rankBy;
  bool? choose;
  int? vipVisible; // 是否vip专属，0.否，1.是
  //本地使用 用于传值 表示用户送了几个礼物
  int? quantity;

  ///本地判断
  bool? isPropGift;

  //本地使用 赠送了这个礼物的这条记录的id
  String? sendGiftRecordId;

  int? i;

  /// 余额大于0 and 余额 >= 礼物钻石
  bool get isSendDiamondGift =>
      ((UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0) != 0) &&
      ((UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0) >=
          (diamonds ?? 0));

  static GiftEntity createGift(CardBean propGift) {
    return GiftEntity()
      ..icon = propGift.icon
      ..name = ""
      ..quantity = propGift.propNum ?? 1
      ..gid = propGift.propDuration
      ..animEffectUrl = propGift.animEffectUrl
      ..diamonds = 0
      ..isPropGift = true;
  }
}
