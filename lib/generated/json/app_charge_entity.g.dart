import 'package:oliapro/entities/app_charge_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

PayChannelBean $PayChannelBeanFromJson(Map<String, dynamic> json) {
  final PayChannelBean payChannelBean = PayChannelBean();
  final int? browserOpen = jsonConvert.convert<int>(json['browserOpen']);
  if (browserOpen != null) {
    payChannelBean.browserOpen = browserOpen;
  }
  final String? channelType = jsonConvert.convert<String>(json['channelType']);
  if (channelType != null) {
    payChannelBean.channelType = channelType;
  }
  final int? payType = jsonConvert.convert<int>(json['payType']);
  if (payType != null) {
    payChannelBean.payType = payType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    payChannelBean.id = id;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    payChannelBean.storeCode = storeCode;
  }
  final String? channelName = jsonConvert.convert<String>(json['channelName']);
  if (channelName != null) {
    payChannelBean.channelName = channelName;
  }
  final int? isTripartite = jsonConvert.convert<int>(json['isTripartite']);
  if (isTripartite != null) {
    payChannelBean.isTripartite = isTripartite;
  }
  final int? isExpand = jsonConvert.convert<int>(json['isExpand']);
  if (isExpand != null) {
    payChannelBean.isExpand = isExpand;
  }
  final String? nationalFlagPath =
      jsonConvert.convert<String>(json['nationalFlagPath']);
  if (nationalFlagPath != null) {
    payChannelBean.nationalFlagPath = nationalFlagPath;
  }
  final dynamic areaInfo = json['areaInfo'];
  if (areaInfo != null) {
    payChannelBean.areaInfo = areaInfo;
  }
  final List<PayCommoditeBean>? commodities = (json['commodities']
          as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<PayCommoditeBean>(e) as PayCommoditeBean)
      .toList();
  if (commodities != null) {
    payChannelBean.commodities = commodities;
  }
  final int? payOrder = jsonConvert.convert<int>(json['payOrder']);
  if (payOrder != null) {
    payChannelBean.payOrder = payOrder;
  }
  final bool? openMenu = jsonConvert.convert<bool>(json['openMenu']);
  if (openMenu != null) {
    payChannelBean.openMenu = openMenu;
  }
  return payChannelBean;
}

Map<String, dynamic> $PayChannelBeanToJson(PayChannelBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['browserOpen'] = entity.browserOpen;
  data['channelType'] = entity.channelType;
  data['payType'] = entity.payType;
  data['id'] = entity.id;
  data['storeCode'] = entity.storeCode;
  data['channelName'] = entity.channelName;
  data['isTripartite'] = entity.isTripartite;
  data['isExpand'] = entity.isExpand;
  data['nationalFlagPath'] = entity.nationalFlagPath;
  data['areaInfo'] = entity.areaInfo;
  data['commodities'] = entity.commodities?.map((v) => v.toJson()).toList();
  data['payOrder'] = entity.payOrder;
  data['openMenu'] = entity.openMenu;
  return data;
}

extension PayChannelBeanExtension on PayChannelBean {
  PayChannelBean copyWith({
    int? browserOpen,
    String? channelType,
    int? payType,
    int? id,
    String? storeCode,
    String? channelName,
    int? isTripartite,
    int? isExpand,
    String? nationalFlagPath,
    dynamic areaInfo,
    List<PayCommoditeBean>? commodities,
    int? payOrder,
    bool? openMenu,
  }) {
    return PayChannelBean()
      ..browserOpen = browserOpen ?? this.browserOpen
      ..channelType = channelType ?? this.channelType
      ..payType = payType ?? this.payType
      ..id = id ?? this.id
      ..storeCode = storeCode ?? this.storeCode
      ..channelName = channelName ?? this.channelName
      ..isTripartite = isTripartite ?? this.isTripartite
      ..isExpand = isExpand ?? this.isExpand
      ..nationalFlagPath = nationalFlagPath ?? this.nationalFlagPath
      ..areaInfo = areaInfo ?? this.areaInfo
      ..commodities = commodities ?? this.commodities
      ..payOrder = payOrder ?? this.payOrder
      ..openMenu = openMenu ?? this.openMenu;
  }
}

PayCommoditeBean $PayCommoditeBeanFromJson(Map<String, dynamic> json) {
  final PayCommoditeBean payCommoditeBean = PayCommoditeBean();
  final String? productCode = jsonConvert.convert<String>(json['productCode']);
  if (productCode != null) {
    payCommoditeBean.productCode = productCode;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    payCommoditeBean.storeCode = storeCode;
  }
  final int? discountType = jsonConvert.convert<int>(json['discountType']);
  if (discountType != null) {
    payCommoditeBean.discountType = discountType;
  }
  final int? payType = jsonConvert.convert<int>(json['payType']);
  if (payType != null) {
    payCommoditeBean.payType = payType;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    payCommoditeBean.icon = icon;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    payCommoditeBean.currency = currency;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    payCommoditeBean.discount = discount;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    payCommoditeBean.createdAt = createdAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    payCommoditeBean.name = name;
  }
  final int? browserOpen = jsonConvert.convert<int>(json['browserOpen']);
  if (browserOpen != null) {
    payCommoditeBean.browserOpen = browserOpen;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    payCommoditeBean.updatedAt = updatedAt;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    payCommoditeBean.bonus = bonus;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    payCommoditeBean.id = id;
  }
  final dynamic discountFrequency = json['discountFrequency'];
  if (discountFrequency != null) {
    payCommoditeBean.discountFrequency = discountFrequency;
  }
  final int? exp = jsonConvert.convert<int>(json['exp']);
  if (exp != null) {
    payCommoditeBean.exp = exp;
  }
  final int? currencyPrice = jsonConvert.convert<int>(json['currencyPrice']);
  if (currencyPrice != null) {
    payCommoditeBean.currencyPrice = currencyPrice;
  }
  final int? discountDuration =
      jsonConvert.convert<int>(json['discountDuration']);
  if (discountDuration != null) {
    payCommoditeBean.discountDuration = discountDuration;
  }
  final String? channelType = jsonConvert.convert<String>(json['channelType']);
  if (channelType != null) {
    payCommoditeBean.channelType = channelType;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    payCommoditeBean.value = value;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    payCommoditeBean.price = price;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    payCommoditeBean.online = online;
  }
  final int? savetime = jsonConvert.convert<int>(json['savetime']);
  if (savetime != null) {
    payCommoditeBean.savetime = savetime;
  }
  return payCommoditeBean;
}

Map<String, dynamic> $PayCommoditeBeanToJson(PayCommoditeBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productCode'] = entity.productCode;
  data['storeCode'] = entity.storeCode;
  data['discountType'] = entity.discountType;
  data['payType'] = entity.payType;
  data['icon'] = entity.icon;
  data['currency'] = entity.currency;
  data['discount'] = entity.discount;
  data['createdAt'] = entity.createdAt;
  data['name'] = entity.name;
  data['browserOpen'] = entity.browserOpen;
  data['updatedAt'] = entity.updatedAt;
  data['bonus'] = entity.bonus;
  data['id'] = entity.id;
  data['discountFrequency'] = entity.discountFrequency;
  data['exp'] = entity.exp;
  data['currencyPrice'] = entity.currencyPrice;
  data['discountDuration'] = entity.discountDuration;
  data['channelType'] = entity.channelType;
  data['value'] = entity.value;
  data['price'] = entity.price;
  data['online'] = entity.online;
  data['savetime'] = entity.savetime;
  return data;
}

extension PayCommoditeBeanExtension on PayCommoditeBean {
  PayCommoditeBean copyWith({
    String? productCode,
    String? storeCode,
    int? discountType,
    int? payType,
    String? icon,
    String? currency,
    int? discount,
    int? createdAt,
    String? name,
    int? browserOpen,
    int? updatedAt,
    int? bonus,
    int? id,
    dynamic discountFrequency,
    int? exp,
    int? currencyPrice,
    int? discountDuration,
    String? channelType,
    int? value,
    int? price,
    int? online,
    int? savetime,
    int? googlePrice,
    String? googleCurrencyCode,
  }) {
    return PayCommoditeBean()
      ..productCode = productCode ?? this.productCode
      ..storeCode = storeCode ?? this.storeCode
      ..discountType = discountType ?? this.discountType
      ..payType = payType ?? this.payType
      ..icon = icon ?? this.icon
      ..currency = currency ?? this.currency
      ..discount = discount ?? this.discount
      ..createdAt = createdAt ?? this.createdAt
      ..name = name ?? this.name
      ..browserOpen = browserOpen ?? this.browserOpen
      ..updatedAt = updatedAt ?? this.updatedAt
      ..bonus = bonus ?? this.bonus
      ..id = id ?? this.id
      ..discountFrequency = discountFrequency ?? this.discountFrequency
      ..exp = exp ?? this.exp
      ..currencyPrice = currencyPrice ?? this.currencyPrice
      ..discountDuration = discountDuration ?? this.discountDuration
      ..channelType = channelType ?? this.channelType
      ..value = value ?? this.value
      ..price = price ?? this.price
      ..online = online ?? this.online
      ..savetime = savetime ?? this.savetime
      ..googlePrice = googlePrice ?? this.googlePrice
      ..googleCurrencyCode = googleCurrencyCode ?? this.googleCurrencyCode;
  }
}

CreateOrderBean $CreateOrderBeanFromJson(Map<String, dynamic> json) {
  final CreateOrderBean createOrderBean = CreateOrderBean();
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    createOrderBean.orderNo = orderNo;
  }
  final String? productCode = jsonConvert.convert<String>(json['productCode']);
  if (productCode != null) {
    createOrderBean.productCode = productCode;
  }
  final int? ppType = jsonConvert.convert<int>(json['ppType']);
  if (ppType != null) {
    createOrderBean.ppType = ppType;
  }
  final String? ppUrl = jsonConvert.convert<String>(json['ppUrl']);
  if (ppUrl != null) {
    createOrderBean.ppUrl = ppUrl;
  }
  return createOrderBean;
}

Map<String, dynamic> $CreateOrderBeanToJson(CreateOrderBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderNo'] = entity.orderNo;
  data['productCode'] = entity.productCode;
  data['ppType'] = entity.ppType;
  data['ppUrl'] = entity.ppUrl;
  return data;
}

extension CreateOrderBeanExtension on CreateOrderBean {
  CreateOrderBean copyWith({
    String? orderNo,
    String? productCode,
    int? ppType,
    String? ppUrl,
  }) {
    return CreateOrderBean()
      ..orderNo = orderNo ?? this.orderNo
      ..productCode = productCode ?? this.productCode
      ..ppType = ppType ?? this.ppType
      ..ppUrl = ppUrl ?? this.ppUrl;
  }
}

PayCutCommodite $PayCutCommoditeFromJson(Map<String, dynamic> json) {
  final PayCutCommodite payCutCommodite = PayCutCommodite();
  final String? productCode = jsonConvert.convert<String>(json['productCode']);
  if (productCode != null) {
    payCutCommodite.productCode = productCode;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    payCutCommodite.storeCode = storeCode;
  }
  final int? discountType = jsonConvert.convert<int>(json['discountType']);
  if (discountType != null) {
    payCutCommodite.discountType = discountType;
  }
  final int? discountDuration =
      jsonConvert.convert<int>(json['discountDuration']);
  if (discountDuration != null) {
    payCutCommodite.discountDuration = discountDuration;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    payCutCommodite.icon = icon;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    payCutCommodite.currency = currency;
  }
  final int? discount = jsonConvert.convert<int>(json['discount']);
  if (discount != null) {
    payCutCommodite.discount = discount;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    payCutCommodite.createdAt = createdAt;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    payCutCommodite.name = name;
  }
  final int? bonus = jsonConvert.convert<int>(json['bonus']);
  if (bonus != null) {
    payCutCommodite.bonus = bonus;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    payCutCommodite.id = id;
  }
  final dynamic discountFrequency = json['discountFrequency'];
  if (discountFrequency != null) {
    payCutCommodite.discountFrequency = discountFrequency;
  }
  final int? exp = jsonConvert.convert<int>(json['exp']);
  if (exp != null) {
    payCutCommodite.exp = exp;
  }
  final int? currencyPrice = jsonConvert.convert<int>(json['currencyPrice']);
  if (currencyPrice != null) {
    payCutCommodite.currencyPrice = currencyPrice;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    payCutCommodite.value = value;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    payCutCommodite.price = price;
  }
  final int? online = jsonConvert.convert<int>(json['online']);
  if (online != null) {
    payCutCommodite.online = online;
  }
  final int? savetime = jsonConvert.convert<int>(json['savetime']);
  if (savetime != null) {
    payCutCommodite.savetime = savetime;
  }
  final List<PayCutChannel>? channelPays =
      (json['channelPays'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<PayCutChannel>(e) as PayCutChannel)
          .toList();
  if (channelPays != null) {
    payCutCommodite.channelPays = channelPays;
  }
  return payCutCommodite;
}

Map<String, dynamic> $PayCutCommoditeToJson(PayCutCommodite entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productCode'] = entity.productCode;
  data['storeCode'] = entity.storeCode;
  data['discountType'] = entity.discountType;
  data['discountDuration'] = entity.discountDuration;
  data['icon'] = entity.icon;
  data['currency'] = entity.currency;
  data['discount'] = entity.discount;
  data['createdAt'] = entity.createdAt;
  data['name'] = entity.name;
  data['bonus'] = entity.bonus;
  data['id'] = entity.id;
  data['discountFrequency'] = entity.discountFrequency;
  data['exp'] = entity.exp;
  data['currencyPrice'] = entity.currencyPrice;
  data['value'] = entity.value;
  data['price'] = entity.price;
  data['online'] = entity.online;
  data['savetime'] = entity.savetime;
  data['channelPays'] = entity.channelPays?.map((v) => v.toJson()).toList();
  return data;
}

extension PayCutCommoditeExtension on PayCutCommodite {
  PayCutCommodite copyWith({
    String? productCode,
    String? storeCode,
    int? discountType,
    int? discountDuration,
    String? icon,
    String? currency,
    int? discount,
    int? createdAt,
    String? name,
    int? bonus,
    int? id,
    dynamic discountFrequency,
    int? exp,
    int? currencyPrice,
    int? value,
    int? price,
    int? online,
    int? savetime,
    List<PayCutChannel>? channelPays,
    int? googlePrice,
    String? googleCurrencyCode,
  }) {
    return PayCutCommodite()
      ..productCode = productCode ?? this.productCode
      ..storeCode = storeCode ?? this.storeCode
      ..discountType = discountType ?? this.discountType
      ..discountDuration = discountDuration ?? this.discountDuration
      ..icon = icon ?? this.icon
      ..currency = currency ?? this.currency
      ..discount = discount ?? this.discount
      ..createdAt = createdAt ?? this.createdAt
      ..name = name ?? this.name
      ..bonus = bonus ?? this.bonus
      ..id = id ?? this.id
      ..discountFrequency = discountFrequency ?? this.discountFrequency
      ..exp = exp ?? this.exp
      ..currencyPrice = currencyPrice ?? this.currencyPrice
      ..value = value ?? this.value
      ..price = price ?? this.price
      ..online = online ?? this.online
      ..savetime = savetime ?? this.savetime
      ..channelPays = channelPays ?? this.channelPays
      ..googlePrice = googlePrice ?? this.googlePrice
      ..googleCurrencyCode = googleCurrencyCode ?? this.googleCurrencyCode;
  }
}

PayCutChannel $PayCutChannelFromJson(Map<String, dynamic> json) {
  final PayCutChannel payCutChannel = PayCutChannel();
  final int? browserOpen = jsonConvert.convert<int>(json['browserOpen']);
  if (browserOpen != null) {
    payCutChannel.browserOpen = browserOpen;
  }
  final String? channelType = jsonConvert.convert<String>(json['channelType']);
  if (channelType != null) {
    payCutChannel.channelType = channelType;
  }
  final int? payType = jsonConvert.convert<int>(json['payType']);
  if (payType != null) {
    payCutChannel.payType = payType;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    payCutChannel.id = id;
  }
  final String? storeCode = jsonConvert.convert<String>(json['storeCode']);
  if (storeCode != null) {
    payCutChannel.storeCode = storeCode;
  }
  final String? channelName = jsonConvert.convert<String>(json['channelName']);
  if (channelName != null) {
    payCutChannel.channelName = channelName;
  }
  final int? isTripartite = jsonConvert.convert<int>(json['isTripartite']);
  if (isTripartite != null) {
    payCutChannel.isTripartite = isTripartite;
  }
  final int? isExpand = jsonConvert.convert<int>(json['isExpand']);
  if (isExpand != null) {
    payCutChannel.isExpand = isExpand;
  }
  final String? nationalFlagPath =
      jsonConvert.convert<String>(json['nationalFlagPath']);
  if (nationalFlagPath != null) {
    payCutChannel.nationalFlagPath = nationalFlagPath;
  }
  final int? payOrder = jsonConvert.convert<int>(json['payOrder']);
  if (payOrder != null) {
    payCutChannel.payOrder = payOrder;
  }
  final bool? openMenu = jsonConvert.convert<bool>(json['openMenu']);
  if (openMenu != null) {
    payCutChannel.openMenu = openMenu;
  }
  final int? currencyPrice = jsonConvert.convert<int>(json['currencyPrice']);
  if (currencyPrice != null) {
    payCutChannel.currencyPrice = currencyPrice;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    payCutChannel.currency = currency;
  }
  return payCutChannel;
}

Map<String, dynamic> $PayCutChannelToJson(PayCutChannel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['browserOpen'] = entity.browserOpen;
  data['channelType'] = entity.channelType;
  data['payType'] = entity.payType;
  data['id'] = entity.id;
  data['storeCode'] = entity.storeCode;
  data['channelName'] = entity.channelName;
  data['isTripartite'] = entity.isTripartite;
  data['isExpand'] = entity.isExpand;
  data['nationalFlagPath'] = entity.nationalFlagPath;
  data['payOrder'] = entity.payOrder;
  data['openMenu'] = entity.openMenu;
  data['currencyPrice'] = entity.currencyPrice;
  data['currency'] = entity.currency;
  return data;
}

extension PayCutChannelExtension on PayCutChannel {
  PayCutChannel copyWith({
    int? browserOpen,
    String? channelType,
    int? payType,
    int? id,
    String? storeCode,
    String? channelName,
    int? isTripartite,
    int? isExpand,
    String? nationalFlagPath,
    int? payOrder,
    bool? openMenu,
    int? currencyPrice,
    String? currency,
  }) {
    return PayCutChannel()
      ..browserOpen = browserOpen ?? this.browserOpen
      ..channelType = channelType ?? this.channelType
      ..payType = payType ?? this.payType
      ..id = id ?? this.id
      ..storeCode = storeCode ?? this.storeCode
      ..channelName = channelName ?? this.channelName
      ..isTripartite = isTripartite ?? this.isTripartite
      ..isExpand = isExpand ?? this.isExpand
      ..nationalFlagPath = nationalFlagPath ?? this.nationalFlagPath
      ..payOrder = payOrder ?? this.payOrder
      ..openMenu = openMenu ?? this.openMenu
      ..currencyPrice = currencyPrice ?? this.currencyPrice
      ..currency = currency ?? this.currency;
  }
}
