import 'dart:convert';

import 'package:nyako/generated/json/app_vip_dart_entity.g.dart';
import 'package:nyako/generated/json/base/json_field.dart';

@JsonSerializable()
class VipDartEntity {
  VipDartDiamondCard? diamondCard;
  List<VipDartChannelPays>? channelPays;
  int? productId;
  String? productNo;
  String? name;
  String? description;
  String? icon;
  int? price;
  int? value;
  int? bonus; // 赠送钻石数
  int? exp;
  int? appSystem;
  int? productType;
  int? discountType;
  int? discount;
  int? discountFrequency;
  int? discountDuration;
  int? vipDays;
  int? pushToGoogle;
  int? productStatus;
  String? createdAt;
  String? updatedAt;
  String? remark;
  int? usdRate;

  VipDartEntity();

  factory VipDartEntity.fromJson(Map<String, dynamic> json) =>
      $VipDartEntityFromJson(json);

  Map<String, dynamic> toJson() => $VipDartEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VipDartDiamondCard {
  int? increaseDiamonds;
  int? totalDiamonds;
  int? propDuration;

  VipDartDiamondCard();

  factory VipDartDiamondCard.fromJson(Map<String, dynamic> json) =>
      $VipDartDiamondCardFromJson(json);

  Map<String, dynamic> toJson() => $VipDartDiamondCardToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VipDartChannelPays {
  int? payId;
  int? payType;
  String? channelType;
  String? channelName;
  String? storeCode;
  String? nationalFlagPath;
  int? areaCode;
  int? discount;
  int? channelStatus;
  int? createdAt;
  int? updatedAt;
  int? payOrder;
  int? browserOpen;
  int? isExpand;
  int? discountDisplay;
  int? discountTop;
  int? currencyPrice;
  String? currency;
  String? productCode;

  VipDartChannelPays();

  factory VipDartChannelPays.fromJson(Map<String, dynamic> json) =>
      $VipDartChannelPaysFromJson(json);

  Map<String, dynamic> toJson() => $VipDartChannelPaysToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
