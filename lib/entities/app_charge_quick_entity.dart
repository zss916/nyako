import 'package:get/get.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/json/base/json_field.dart';
import 'package:oliapro/utils/app_format_util.dart';

import '../common/language_key.dart';
import '../generated/json/app_charge_quick_entity.g.dart';

@JsonSerializable()
class PayQuickData {
  PayQuickData();

  factory PayQuickData.fromJson(Map<String, dynamic> json) =>
      $PayQuickDataFromJson(json);

  Map<String, dynamic> toJson() => $PayQuickDataToJson(this);

  PayQuickCommodite? discountProduct;

  ///折扣商品
  List<PayQuickCommodite>? normalProducts;

  ///普通商品
  List<PayQuickCommodite>? vipProducts;

  ///VIP 商品
  PayQuickCommodite? discountVip;

  ///限时VIP

  AreaData? area;
}

// 折扣商品是商品里面有渠道
@JsonSerializable()
class PayQuickCommodite {
  PayQuickCommodite();

  factory PayQuickCommodite.fromJson(Map<String, dynamic> json) =>
      $PayQuickCommoditeFromJson(json);

  Map<String, dynamic> toJson() => $PayQuickCommoditeToJson(this);

  AreaData? area;
  String? productId;
  String? productNo;
  String? name;
  String? description;
  String? icon;
  int? price;
  int? exp;

  int? value;

  ///普通商品 value:商品的钻石数，VIP商品 value 是赠送钻石
  int? bonus;

  /// 普通商品 bonus:赠送的商品的钻石数
  int? vipDays;

  /// vip 特有
  bool? isSelect;

  dynamic? appSystem;
  int? productType;
  // 折扣类型，1.首充折扣，2.单次折扣，3.限时折扣
  int? discountType;
  // 折扣（50表示优惠50%）
  int? discount;
  dynamic? discountFrequency;
  // 折扣限时，0为不限时，单位毫秒数
  int? discountDuration;

  int? createdAt;
  //保存这条记录存储的时间
  int? savetime;

  //本地
  String? diamondIcon;

  int get showValue => (value ?? 0);
  int get showBonus => (bonus ?? 0);
  int get showDiscount => (discount ?? 0);

  //支付渠道
  // List<PayQuickChannel>? channelPays;
  DiamondCardBean? diamondCard;
  // 充值页面展示的价格
  String? drawImageIcon;

  //本地缓存
  String? cacheDrawImageIcon;
  int? pushToGoogle;
  int? productStatus;

  String? remark;
  String? usdRate;
  List<PayQuickChannel>? ppp;

  String get showPrice {
    if (ppp == null || ppp!.isEmpty) {
      return Tr.app_recharge.tr;
    }
    final channels = ppp!;
    return channels.first.showPrice;
  }

  String get showDialogPrice {
    if (ppp == null || ppp!.isEmpty) {
      return "--";
    }
    final channels = ppp!;
    return channels.first.showPrice;
  }

  String get showOldPrice {
    if (ppp == null || ppp!.isEmpty || discount == null) {
      return '';
    }
    final channels = ppp!;
    return "${channels.first.realCurrencySymbol} ${(num.parse(channels.first.showRealPrice) / ((100.0 - discount!) / 100.0)).toStringAsFixed(2)}";
  }
}

// {
// "payId":1534470782591389698,
// "payType":1,
// "channelType":null,
// "channelName":"Google Play",
// "storeCode":"1013",
// "nationalFlagPath":"https://wscdn.hanilink.com/assets/commodities/1652266068828.png",
// "areaCode":7,
// "discount":null,
// "channelStatus":1,
// "createdAt":1654681318314,
// "updatedAt":1654686153725,
// "payOrder":0,
// "browserOpen":0,
// "isExpand":1,
// "discountDisplay":null,
// "discountTop":null,
// "currencyPrice":399,
// "currency":"USD",
// "productCode":"some399"
//  }
@JsonSerializable()
class PayQuickChannel {
  PayQuickChannel();

  factory PayQuickChannel.fromJson(Map<String, dynamic> json) =>
      $PayQuickChannelFromJson(json);

  Map<String, dynamic> toJson() => $PayQuickChannelToJson(this);

  String? productCode;
  String? storeCode;

  int? browserOpen;
  //String? channelType;
  //int? payType;
  int? id;
  // String? channelName;
  int? isTripartite;
  int? isExpand;
  String? nationalFlagPath;
  //int? payOrder;
  //自定义字段 用户展开关闭支付方式
  bool? openMenu;
  int? currencyPrice;
  String? currency;
  int? uploadUsd;
  String? price;
  String? productId;

  @JSONField(serialize: false, deserialize: false)
  int? googlePrice;
  @JSONField(serialize: false, deserialize: false)
  String? googleCurrencyCode;
  int? get realPrice => googlePrice ?? currencyPrice;
  String? get realCurrency => googleCurrencyCode ?? currency;

  // 这个Google返回的有问题，可能港币返回的就是一个$
  // String? get realCurrencySymbol =>
  //     googleCurrencySymbol ?? HiDataConvert.currencyToSymbol(realCurrency);

  String? get realCurrencySymbol =>
      AppFormatUtil.currencyToSymbol(realCurrency);

  @override
  String toString() {
    return '$ccName $productCode $currency $currencyPrice';
  }

  String get showPrice {
    var price =
        "$realCurrencySymbol ${realPrice != null ? realPrice! / 100 : "--"}";

    if (price.endsWith('.0')) {
      // Rp 59670.0
      price = price.substring(0, price.length - 2);
    }
    if (price.endsWith('.00') && price.length > 9) {
      // usd 345.00
      price = price.substring(0, price.length - 3);
    }
    return price;
  }

  // 不带币种符号的价格
  String get showRealPrice {
    var price = "${realPrice != null ? realPrice! / 100 : "--"}";
    if (price.endsWith('.0')) {
      // Rp 59670.0
      price = price.substring(0, price.length - 2);
    }
    if (price.endsWith('.00') && price.length > 9) {
      // usd 345.00
      price = price.substring(0, price.length - 3);
    }
    // print("price====$price");
    return price;
  }

  ///中奖弹窗
  String? ccType;

  int? ppType;

  String? ccName;
  int? ppId;

  int? ppOrder;

  int? ccStatus;

//String? channelType;(ccType)
// int? payType;(ppType)
//String? channelName;(ccName)
//int? payOrder;(ppOrder)
//String? productId;(ppId)
}

@JsonSerializable()
class DiamondCardBean {
  DiamondCardBean();

  factory DiamondCardBean.fromJson(Map<String, dynamic> json) =>
      $DiamondCardBeanFromJson(json);

  Map<String, dynamic> toJson() => $DiamondCardBeanToJson(this);
  // 增量钻石数
  int? increaseDiamonds;
  // 加成后的总钻石数
  int? totalDiamonds;
  // 加成比例
  int? propDuration;
}
