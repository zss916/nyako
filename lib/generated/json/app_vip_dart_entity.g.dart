import 'package:oliapro/generated/json/base/json_convert_content.dart';
import 'package:oliapro/entities/app_vip_dart_entity.dart';

VipDartEntity $VipDartEntityFromJson(Map<String, dynamic> json) {
  final VipDartEntity vipDartEntity = VipDartEntity();
  final VipDartDiamondCard? diamondCard = jsonConvert.convert<
      VipDartDiamondCard>(json['diamondCard']);
  if (diamondCard != null) {
    vipDartEntity.diamondCard = diamondCard;
  }
  final List<VipDartChannelPays>? channelPays = (json['channelPays'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<VipDartChannelPays>(e) as VipDartChannelPays)
      .toList();
  if (channelPays != null) {
    vipDartEntity.channelPays = channelPays;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    vipDartEntity.productId = productId;
  }
  final String? productNo = jsonConvert.convert<String>(json['productNo']);
  if (productNo != null) {
    vipDartEntity.productNo = productNo;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    vipDartEntity.name = name;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    vipDartEntity.description = description;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    vipDartEntity.icon = icon;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    vipDartEntity.price = price;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    vipDartEntity.value = value;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    vipDartEntity.bonus = bonus;
  }
  final int? exp = jsonConvert.convert<int>(json['exp']);
  if (exp != null) {
    vipDartEntity.exp = exp;
  }
  final int? appSystem = jsonConvert.convert<int>(json['appSystem']);
  if (appSystem != null) {
    vipDartEntity.appSystem = appSystem;
  }
  final int? productType = jsonConvert.convert<int>(json['productType']);
  if (productType != null) {
    vipDartEntity.productType = productType;
  }
  final int? discountType = jsonConvert.convert<int>(json['discountType']);
  if (discountType != null) {
    vipDartEntity.discountType = discountType;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    vipDartEntity.discount = discount;
  }
  final int? discountFrequency = jsonConvert.convert<int>(
      json['discountFrequency']);
  if (discountFrequency != null) {
    vipDartEntity.discountFrequency = discountFrequency;
  }
  final int? discountDuration = jsonConvert.convert<int>(
      json['discountDuration']);
  if (discountDuration != null) {
    vipDartEntity.discountDuration = discountDuration;
  }
  final int? vipDays = jsonConvert.convert<int>(json['vipDays']);
  if (vipDays != null) {
    vipDartEntity.vipDays = vipDays;
  }
  final int? pushToGoogle = jsonConvert.convert<int>(json['pushToGoogle']);
  if (pushToGoogle != null) {
    vipDartEntity.pushToGoogle = pushToGoogle;
  }
  final int? productStatus = jsonConvert.convert<int>(json['productStatus']);
  if (productStatus != null) {
    vipDartEntity.productStatus = productStatus;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    vipDartEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
  if (updatedAt != null) {
    vipDartEntity.updatedAt = updatedAt;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    vipDartEntity.remark = remark;
  }
  final int? usdRate = jsonConvert.convert<int>(json['usdRate']);
  if (usdRate != null) {
    vipDartEntity.usdRate = usdRate;
  }
  return vipDartEntity;
}

Map<String, dynamic> $VipDartEntityToJson(VipDartEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['diamondCard'] = entity.diamondCard?.toJson();
  data['channelPays'] = entity.channelPays?.map((v) => v.toJson()).toList();
  data['productId'] = entity.productId;
  data['productNo'] = entity.productNo;
  data['name'] = entity.name;
  data['description'] = entity.description;
  data['icon'] = entity.icon;
  data['price'] = entity.price;
  data['value'] = entity.value;
  data['bonus'] = entity.bonus;
  data['exp'] = entity.exp;
  data['appSystem'] = entity.appSystem;
  data['productType'] = entity.productType;
  data['discountType'] = entity.discountType;
  data['discount'] = entity.discount;
  data['discountFrequency'] = entity.discountFrequency;
  data['discountDuration'] = entity.discountDuration;
  data['vipDays'] = entity.vipDays;
  data['pushToGoogle'] = entity.pushToGoogle;
  data['productStatus'] = entity.productStatus;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['remark'] = entity.remark;
  data['usdRate'] = entity.usdRate;
  return data;
}

extension VipDartEntityExtension on VipDartEntity {
  VipDartEntity copyWith({
    VipDartDiamondCard? diamondCard,
    List<VipDartChannelPays>? channelPays,
    int? productId,
    String? productNo,
    String? name,
    String? description,
    String? icon,
    int? price,
    int? value,
    int? bonus,
    int? exp,
    int? appSystem,
    int? productType,
    int? discountType,
    int? discount,
    int? discountFrequency,
    int? discountDuration,
    int? vipDays,
    int? pushToGoogle,
    int? productStatus,
    String? createdAt,
    String? updatedAt,
    String? remark,
    int? usdRate,
  }) {
    return VipDartEntity()
      ..diamondCard = diamondCard ?? this.diamondCard
      ..channelPays = channelPays ?? this.channelPays
      ..productId = productId ?? this.productId
      ..productNo = productNo ?? this.productNo
      ..name = name ?? this.name
      ..description = description ?? this.description
      ..icon = icon ?? this.icon
      ..price = price ?? this.price
      ..value = value ?? this.value
      ..bonus = bonus ?? this.bonus
      ..exp = exp ?? this.exp
      ..appSystem = appSystem ?? this.appSystem
      ..productType = productType ?? this.productType
      ..discountType = discountType ?? this.discountType
      ..discount = discount ?? this.discount
      ..discountFrequency = discountFrequency ?? this.discountFrequency
      ..discountDuration = discountDuration ?? this.discountDuration
      ..vipDays = vipDays ?? this.vipDays
      ..pushToGoogle = pushToGoogle ?? this.pushToGoogle
      ..productStatus = productStatus ?? this.productStatus
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..remark = remark ?? this.remark
      ..usdRate = usdRate ?? this.usdRate;
  }
}

VipDartDiamondCard $VipDartDiamondCardFromJson(Map<String, dynamic> json) {
  final VipDartDiamondCard vipDartDiamondCard = VipDartDiamondCard();
  final int? increaseDiamonds = jsonConvert.convert<int>(
      json['increaseDiamonds']);
  if (increaseDiamonds != null) {
    vipDartDiamondCard.increaseDiamonds = increaseDiamonds;
  }
  final int? totalDiamonds = jsonConvert.convert<int>(json['totalDiamonds']);
  if (totalDiamonds != null) {
    vipDartDiamondCard.totalDiamonds = totalDiamonds;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    vipDartDiamondCard.propDuration = propDuration;
  }
  return vipDartDiamondCard;
}

Map<String, dynamic> $VipDartDiamondCardToJson(VipDartDiamondCard entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['increaseDiamonds'] = entity.increaseDiamonds;
  data['totalDiamonds'] = entity.totalDiamonds;
  data['propDuration'] = entity.propDuration;
  return data;
}

extension VipDartDiamondCardExtension on VipDartDiamondCard {
  VipDartDiamondCard copyWith({
    int? increaseDiamonds,
    int? totalDiamonds,
    int? propDuration,
  }) {
    return VipDartDiamondCard()
      ..increaseDiamonds = increaseDiamonds ?? this.increaseDiamonds
      ..totalDiamonds = totalDiamonds ?? this.totalDiamonds
      ..propDuration = propDuration ?? this.propDuration;
  }
}

VipDartChannelPays $VipDartChannelPaysFromJson(Map<String, dynamic> json) {
  final VipDartChannelPays vipDartChannelPays = VipDartChannelPays();
  final int? payId = jsonConvert.convert<int>(json['payId']);
  if (payId != null) {
    vipDartChannelPays.payId = payId;
  }
  final int? payType = jsonConvert.convert<int>(json['payType']);
  if (payType != null) {
    vipDartChannelPays.payType = payType;
  }
  final String? channelType = jsonConvert.convert<String>(json['channelType']);
  if (channelType != null) {
    vipDartChannelPays.channelType = channelType;
  }
  final String? channelName = jsonConvert.convert<String>(json['channelName']);
  if (channelName != null) {
    vipDartChannelPays.channelName = channelName;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    vipDartChannelPays.storeCode = storeCode;
  }
  final String? nationalFlagPath = jsonConvert.convert<String>(
      json['nationalFlagPath']);
  if (nationalFlagPath != null) {
    vipDartChannelPays.nationalFlagPath = nationalFlagPath;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    vipDartChannelPays.areaCode = areaCode;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    vipDartChannelPays.discount = discount;
  }
  final int? channelStatus = jsonConvert.convert<int>(json['channelStatus']);
  if (channelStatus != null) {
    vipDartChannelPays.channelStatus = channelStatus;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    vipDartChannelPays.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    vipDartChannelPays.updatedAt = updatedAt;
  }
  final int? payOrder = jsonConvert.convert<int>(json['payOrder']);
  if (payOrder != null) {
    vipDartChannelPays.payOrder = payOrder;
  }
  final int? browserOpen = jsonConvert.convert<int>(json['browserOpen']);
  if (browserOpen != null) {
    vipDartChannelPays.browserOpen = browserOpen;
  }
  final int? isExpand = jsonConvert.convert<int>(json['isExpand']);
  if (isExpand != null) {
    vipDartChannelPays.isExpand = isExpand;
  }
  final int? discountDisplay = jsonConvert.convert<int>(
      json['discountDisplay']);
  if (discountDisplay != null) {
    vipDartChannelPays.discountDisplay = discountDisplay;
  }
  final int? discountTop = jsonConvert.convert<int>(json['discountTop']);
  if (discountTop != null) {
    vipDartChannelPays.discountTop = discountTop;
  }
  final int? currencyPrice = jsonConvert.convert<int>(json['currencyPrice']);
  if (currencyPrice != null) {
    vipDartChannelPays.currencyPrice = currencyPrice;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    vipDartChannelPays.currency = currency;
  }
  final String? productCode = jsonConvert.convert<String>(json['productCode']);
  if (productCode != null) {
    vipDartChannelPays.productCode = productCode;
  }
  return vipDartChannelPays;
}

Map<String, dynamic> $VipDartChannelPaysToJson(VipDartChannelPays entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['payId'] = entity.payId;
  data['payType'] = entity.payType;
  data['channelType'] = entity.channelType;
  data['channelName'] = entity.channelName;
  data['storeCode'] = entity.storeCode;
  data['nationalFlagPath'] = entity.nationalFlagPath;
  data['areaCode'] = entity.areaCode;
  data['discount'] = entity.discount;
  data['channelStatus'] = entity.channelStatus;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['payOrder'] = entity.payOrder;
  data['browserOpen'] = entity.browserOpen;
  data['isExpand'] = entity.isExpand;
  data['discountDisplay'] = entity.discountDisplay;
  data['discountTop'] = entity.discountTop;
  data['currencyPrice'] = entity.currencyPrice;
  data['currency'] = entity.currency;
  data['productCode'] = entity.productCode;
  return data;
}

extension VipDartChannelPaysExtension on VipDartChannelPays {
  VipDartChannelPays copyWith({
    int? payId,
    int? payType,
    String? channelType,
    String? channelName,
    String? storeCode,
    String? nationalFlagPath,
    int? areaCode,
    int? discount,
    int? channelStatus,
    int? createdAt,
    int? updatedAt,
    int? payOrder,
    int? browserOpen,
    int? isExpand,
    int? discountDisplay,
    int? discountTop,
    int? currencyPrice,
    String? currency,
    String? productCode,
  }) {
    return VipDartChannelPays()
      ..payId = payId ?? this.payId
      ..payType = payType ?? this.payType
      ..channelType = channelType ?? this.channelType
      ..channelName = channelName ?? this.channelName
      ..storeCode = storeCode ?? this.storeCode
      ..nationalFlagPath = nationalFlagPath ?? this.nationalFlagPath
      ..areaCode = areaCode ?? this.areaCode
      ..discount = discount ?? this.discount
      ..channelStatus = channelStatus ?? this.channelStatus
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..payOrder = payOrder ?? this.payOrder
      ..browserOpen = browserOpen ?? this.browserOpen
      ..isExpand = isExpand ?? this.isExpand
      ..discountDisplay = discountDisplay ?? this.discountDisplay
      ..discountTop = discountTop ?? this.discountTop
      ..currencyPrice = currencyPrice ?? this.currencyPrice
      ..currency = currency ?? this.currency
      ..productCode = productCode ?? this.productCode;
  }
}