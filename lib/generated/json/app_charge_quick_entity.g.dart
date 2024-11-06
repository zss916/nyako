import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

PayQuickData $PayQuickDataFromJson(Map<String, dynamic> json) {
  final PayQuickData payQuickData = PayQuickData();
  final PayQuickCommodite? discountProduct =
      jsonConvert.convert<PayQuickCommodite>(json['discountProduct']);
  if (discountProduct != null) {
    payQuickData.discountProduct = discountProduct;
  }
  final List<PayQuickCommodite>? normalProducts = (json['normalProducts']
          as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<PayQuickCommodite>(e) as PayQuickCommodite)
      .toList();
  if (normalProducts != null) {
    payQuickData.normalProducts = normalProducts;
  }
  final List<PayQuickCommodite>? vipProducts = (json['vipProducts']
          as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<PayQuickCommodite>(e) as PayQuickCommodite)
      .toList();
  if (vipProducts != null) {
    payQuickData.vipProducts = vipProducts;
  }
  final PayQuickCommodite? discountVip =
      jsonConvert.convert<PayQuickCommodite>(json['discountVip']);
  if (discountVip != null) {
    payQuickData.discountVip = discountVip;
  }
  final AreaData? area = jsonConvert.convert<AreaData>(json['area']);
  if (area != null) {
    payQuickData.area = area;
  }
  return payQuickData;
}

Map<String, dynamic> $PayQuickDataToJson(PayQuickData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['discountProduct'] = entity.discountProduct?.toJson();
  data['normalProducts'] =
      entity.normalProducts?.map((v) => v.toJson()).toList();
  data['vipProducts'] = entity.vipProducts?.map((v) => v.toJson()).toList();
  data['discountVip'] = entity.discountVip?.toJson();
  data['area'] = entity.area?.toJson();
  return data;
}

extension PayQuickDataExtension on PayQuickData {
  PayQuickData copyWith({
    PayQuickCommodite? discountProduct,
    List<PayQuickCommodite>? normalProducts,
    List<PayQuickCommodite>? vipProducts,
    PayQuickCommodite? discountVip,
    AreaData? area,
  }) {
    return PayQuickData()
      ..discountProduct = discountProduct ?? this.discountProduct
      ..normalProducts = normalProducts ?? this.normalProducts
      ..vipProducts = vipProducts ?? this.vipProducts
      ..discountVip = discountVip ?? this.discountVip
      ..area = area ?? this.area;
  }
}

PayQuickCommodite $PayQuickCommoditeFromJson(Map<String, dynamic> json) {
  final PayQuickCommodite payQuickCommodite = PayQuickCommodite();
  final AreaData? area = jsonConvert.convert<AreaData>(json['area']);
  if (area != null) {
    payQuickCommodite.area = area;
  }
  final String? productId = jsonConvert.convert<String>(json['productId']);
  if (productId != null) {
    payQuickCommodite.productId = productId;
  }
  final String? productNo = jsonConvert.convert<String>(json['productNo']);
  if (productNo != null) {
    payQuickCommodite.productNo = productNo;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    payQuickCommodite.name = name;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    payQuickCommodite.description = description;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    payQuickCommodite.icon = icon;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    payQuickCommodite.price = price;
  }
  final int? exp = jsonConvert.convert<int>(json['exp']);
  if (exp != null) {
    payQuickCommodite.exp = exp;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    payQuickCommodite.value = value;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    payQuickCommodite.bonus = bonus;
  }
  final int? vipDays = jsonConvert.convert<int>(json['vipDays']);
  if (vipDays != null) {
    payQuickCommodite.vipDays = vipDays;
  }
  final bool? isSelect = jsonConvert.convert<bool>(json['isSelect']);
  if (isSelect != null) {
    payQuickCommodite.isSelect = isSelect;
  }
  final dynamic appSystem = json['appSystem'];
  if (appSystem != null) {
    payQuickCommodite.appSystem = appSystem;
  }
  final int? productType = jsonConvert.convert<int>(json['productType']);
  if (productType != null) {
    payQuickCommodite.productType = productType;
  }
  final int? discountType = jsonConvert.convert<int>(json['discountType']);
  if (discountType != null) {
    payQuickCommodite.discountType = discountType;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    payQuickCommodite.discount = discount;
  }
  final dynamic discountFrequency = json['discountFrequency'];
  if (discountFrequency != null) {
    payQuickCommodite.discountFrequency = discountFrequency;
  }
  final int? discountDuration =
      jsonConvert.convert<int>(json['discountDuration']);
  if (discountDuration != null) {
    payQuickCommodite.discountDuration = discountDuration;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    payQuickCommodite.createdAt = createdAt;
  }
  final int? savetime = jsonConvert.convert<int>(json['savetime']);
  if (savetime != null) {
    payQuickCommodite.savetime = savetime;
  }
  final String? diamondIcon = jsonConvert.convert<String>(json['diamondIcon']);
  if (diamondIcon != null) {
    payQuickCommodite.diamondIcon = diamondIcon;
  }
  final DiamondCardBean? diamondCard =
      jsonConvert.convert<DiamondCardBean>(json['diamondCard']);
  if (diamondCard != null) {
    payQuickCommodite.diamondCard = diamondCard;
  }
  final String? drawImageIcon =
      jsonConvert.convert<String>(json['drawImageIcon']);
  if (drawImageIcon != null) {
    payQuickCommodite.drawImageIcon = drawImageIcon;
  }
  final String? cacheDrawImageIcon =
      jsonConvert.convert<String>(json['cacheDrawImageIcon']);
  if (cacheDrawImageIcon != null) {
    payQuickCommodite.cacheDrawImageIcon = cacheDrawImageIcon;
  }
  final int? pushToGoogle = jsonConvert.convert<int>(json['pushToGoogle']);
  if (pushToGoogle != null) {
    payQuickCommodite.pushToGoogle = pushToGoogle;
  }
  final int? productStatus = jsonConvert.convert<int>(json['productStatus']);
  if (productStatus != null) {
    payQuickCommodite.productStatus = productStatus;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    payQuickCommodite.remark = remark;
  }
  final String? usdRate = jsonConvert.convert<String>(json['usdRate']);
  if (usdRate != null) {
    payQuickCommodite.usdRate = usdRate;
  }
  final List<PayQuickChannel>? ppp = (json['ppp'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<PayQuickChannel>(e) as PayQuickChannel)
      .toList();
  if (ppp != null) {
    payQuickCommodite.ppp = ppp;
  }
  return payQuickCommodite;
}

Map<String, dynamic> $PayQuickCommoditeToJson(PayQuickCommodite entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['area'] = entity.area?.toJson();
  data['productId'] = entity.productId;
  data['productNo'] = entity.productNo;
  data['name'] = entity.name;
  data['description'] = entity.description;
  data['icon'] = entity.icon;
  data['price'] = entity.price;
  data['exp'] = entity.exp;
  data['value'] = entity.value;
  data['bonus'] = entity.bonus;
  data['vipDays'] = entity.vipDays;
  data['isSelect'] = entity.isSelect;
  data['appSystem'] = entity.appSystem;
  data['productType'] = entity.productType;
  data['discountType'] = entity.discountType;
  data['discount'] = entity.discount;
  data['discountFrequency'] = entity.discountFrequency;
  data['discountDuration'] = entity.discountDuration;
  data['createdAt'] = entity.createdAt;
  data['savetime'] = entity.savetime;
  data['diamondIcon'] = entity.diamondIcon;
  data['diamondCard'] = entity.diamondCard?.toJson();
  data['drawImageIcon'] = entity.drawImageIcon;
  data['cacheDrawImageIcon'] = entity.cacheDrawImageIcon;
  data['pushToGoogle'] = entity.pushToGoogle;
  data['productStatus'] = entity.productStatus;
  data['remark'] = entity.remark;
  data['usdRate'] = entity.usdRate;
  data['ppp'] = entity.ppp?.map((v) => v.toJson()).toList();
  return data;
}

extension PayQuickCommoditeExtension on PayQuickCommodite {
  PayQuickCommodite copyWith({
    AreaData? area,
    String? productId,
    String? productNo,
    String? name,
    String? description,
    String? icon,
    int? price,
    int? exp,
    int? value,
    int? bonus,
    int? vipDays,
    bool? isSelect,
    dynamic appSystem,
    int? productType,
    int? discountType,
    int? discount,
    dynamic discountFrequency,
    int? discountDuration,
    int? createdAt,
    int? savetime,
    String? diamondIcon,
    DiamondCardBean? diamondCard,
    String? drawImageIcon,
    String? cacheDrawImageIcon,
    int? pushToGoogle,
    int? productStatus,
    String? remark,
    String? usdRate,
    List<PayQuickChannel>? ppp,
  }) {
    return PayQuickCommodite()
      ..area = area ?? this.area
      ..productId = productId ?? this.productId
      ..productNo = productNo ?? this.productNo
      ..name = name ?? this.name
      ..description = description ?? this.description
      ..icon = icon ?? this.icon
      ..price = price ?? this.price
      ..exp = exp ?? this.exp
      ..value = value ?? this.value
      ..bonus = bonus ?? this.bonus
      ..vipDays = vipDays ?? this.vipDays
      ..isSelect = isSelect ?? this.isSelect
      ..appSystem = appSystem ?? this.appSystem
      ..productType = productType ?? this.productType
      ..discountType = discountType ?? this.discountType
      ..discount = discount ?? this.discount
      ..discountFrequency = discountFrequency ?? this.discountFrequency
      ..discountDuration = discountDuration ?? this.discountDuration
      ..createdAt = createdAt ?? this.createdAt
      ..savetime = savetime ?? this.savetime
      ..diamondIcon = diamondIcon ?? this.diamondIcon
      ..diamondCard = diamondCard ?? this.diamondCard
      ..drawImageIcon = drawImageIcon ?? this.drawImageIcon
      ..cacheDrawImageIcon = cacheDrawImageIcon ?? this.cacheDrawImageIcon
      ..pushToGoogle = pushToGoogle ?? this.pushToGoogle
      ..productStatus = productStatus ?? this.productStatus
      ..remark = remark ?? this.remark
      ..usdRate = usdRate ?? this.usdRate
      ..ppp = ppp ?? this.ppp;
  }
}

PayQuickChannel $PayQuickChannelFromJson(Map<String, dynamic> json) {
  final PayQuickChannel payQuickChannel = PayQuickChannel();
  final String? productCode = jsonConvert.convert<String>(json['productCode']);
  if (productCode != null) {
    payQuickChannel.productCode = productCode;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    payQuickChannel.storeCode = storeCode;
  }
  final int? browserOpen = jsonConvert.convert<int>(json['browserOpen']);
  if (browserOpen != null) {
    payQuickChannel.browserOpen = browserOpen;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    payQuickChannel.id = id;
  }
  final int? isTripartite = jsonConvert.convert<int>(json['isTripartite']);
  if (isTripartite != null) {
    payQuickChannel.isTripartite = isTripartite;
  }
  final int? isExpand = jsonConvert.convert<int>(json['isExpand']);
  if (isExpand != null) {
    payQuickChannel.isExpand = isExpand;
  }
  final String? nationalFlagPath =
      jsonConvert.convert<String>(json['nationalFlagPath']);
  if (nationalFlagPath != null) {
    payQuickChannel.nationalFlagPath = nationalFlagPath;
  }
  final bool? openMenu = jsonConvert.convert<bool>(json['openMenu']);
  if (openMenu != null) {
    payQuickChannel.openMenu = openMenu;
  }
  final int? currencyPrice = jsonConvert.convert<int>(json['currencyPrice']);
  if (currencyPrice != null) {
    payQuickChannel.currencyPrice = currencyPrice;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    payQuickChannel.currency = currency;
  }
  final int? uploadUsd = jsonConvert.convert<int>(json['uploadUsd']);
  if (uploadUsd != null) {
    payQuickChannel.uploadUsd = uploadUsd;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    payQuickChannel.price = price;
  }
  final String? productId = jsonConvert.convert<String>(json['productId']);
  if (productId != null) {
    payQuickChannel.productId = productId;
  }
  final String? ccType = jsonConvert.convert<String>(json['ccType']);
  if (ccType != null) {
    payQuickChannel.ccType = ccType;
  }
  final int? ppType = jsonConvert.convert<int>(json['ppType']);
  if (ppType != null) {
    payQuickChannel.ppType = ppType;
  }
  final String? ccName = jsonConvert.convert<String>(json['ccName']);
  if (ccName != null) {
    payQuickChannel.ccName = ccName;
  }
  final int? ppId = jsonConvert.convert<int>(json['ppId']);
  if (ppId != null) {
    payQuickChannel.ppId = ppId;
  }
  final int? ppOrder = jsonConvert.convert<int>(json['ppOrder']);
  if (ppOrder != null) {
    payQuickChannel.ppOrder = ppOrder;
  }
  final int? ccStatus = jsonConvert.convert<int>(json['ccStatus']);
  if (ccStatus != null) {
    payQuickChannel.ccStatus = ccStatus;
  }
  return payQuickChannel;
}

Map<String, dynamic> $PayQuickChannelToJson(PayQuickChannel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productCode'] = entity.productCode;
  data['storeCode'] = entity.storeCode;
  data['browserOpen'] = entity.browserOpen;
  data['id'] = entity.id;
  data['isTripartite'] = entity.isTripartite;
  data['isExpand'] = entity.isExpand;
  data['nationalFlagPath'] = entity.nationalFlagPath;
  data['openMenu'] = entity.openMenu;
  data['currencyPrice'] = entity.currencyPrice;
  data['currency'] = entity.currency;
  data['uploadUsd'] = entity.uploadUsd;
  data['price'] = entity.price;
  data['productId'] = entity.productId;
  data['ccType'] = entity.ccType;
  data['ppType'] = entity.ppType;
  data['ccName'] = entity.ccName;
  data['ppId'] = entity.ppId;
  data['ppOrder'] = entity.ppOrder;
  data['ccStatus'] = entity.ccStatus;
  return data;
}

extension PayQuickChannelExtension on PayQuickChannel {
  PayQuickChannel copyWith({
    String? productCode,
    String? storeCode,
    int? browserOpen,
    int? id,
    int? isTripartite,
    int? isExpand,
    String? nationalFlagPath,
    bool? openMenu,
    int? currencyPrice,
    String? currency,
    int? uploadUsd,
    String? price,
    String? productId,
    int? googlePrice,
    String? googleCurrencyCode,
    String? ccType,
    int? ppType,
    String? ccName,
    int? ppId,
    int? ppOrder,
    int? ccStatus,
  }) {
    return PayQuickChannel()
      ..productCode = productCode ?? this.productCode
      ..storeCode = storeCode ?? this.storeCode
      ..browserOpen = browserOpen ?? this.browserOpen
      ..id = id ?? this.id
      ..isTripartite = isTripartite ?? this.isTripartite
      ..isExpand = isExpand ?? this.isExpand
      ..nationalFlagPath = nationalFlagPath ?? this.nationalFlagPath
      ..openMenu = openMenu ?? this.openMenu
      ..currencyPrice = currencyPrice ?? this.currencyPrice
      ..currency = currency ?? this.currency
      ..uploadUsd = uploadUsd ?? this.uploadUsd
      ..price = price ?? this.price
      ..productId = productId ?? this.productId
      ..googlePrice = googlePrice ?? this.googlePrice
      ..googleCurrencyCode = googleCurrencyCode ?? this.googleCurrencyCode
      ..ccType = ccType ?? this.ccType
      ..ppType = ppType ?? this.ppType
      ..ccName = ccName ?? this.ccName
      ..ppId = ppId ?? this.ppId
      ..ppOrder = ppOrder ?? this.ppOrder
      ..ccStatus = ccStatus ?? this.ccStatus;
  }
}

DiamondCardBean $DiamondCardBeanFromJson(Map<String, dynamic> json) {
  final DiamondCardBean diamondCardBean = DiamondCardBean();
  final int? increaseDiamonds =
      jsonConvert.convert<int>(json['increaseDiamonds']);
  if (increaseDiamonds != null) {
    diamondCardBean.increaseDiamonds = increaseDiamonds;
  }
  final int? totalDiamonds = jsonConvert.convert<int>(json['totalDiamonds']);
  if (totalDiamonds != null) {
    diamondCardBean.totalDiamonds = totalDiamonds;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    diamondCardBean.propDuration = propDuration;
  }
  return diamondCardBean;
}

Map<String, dynamic> $DiamondCardBeanToJson(DiamondCardBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['increaseDiamonds'] = entity.increaseDiamonds;
  data['totalDiamonds'] = entity.totalDiamonds;
  data['propDuration'] = entity.propDuration;
  return data;
}

extension DiamondCardBeanExtension on DiamondCardBean {
  DiamondCardBean copyWith({
    int? increaseDiamonds,
    int? totalDiamonds,
    int? propDuration,
  }) {
    return DiamondCardBean()
      ..increaseDiamonds = increaseDiamonds ?? this.increaseDiamonds
      ..totalDiamonds = totalDiamonds ?? this.totalDiamonds
      ..propDuration = propDuration ?? this.propDuration;
  }
}
