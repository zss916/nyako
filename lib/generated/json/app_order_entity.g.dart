import 'package:nyako/generated/json/base/json_convert_content.dart';
import 'package:nyako/entities/app_order_entity.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:nyako/common/language_key.dart';


OrderBean $OrderBeanFromJson(Map<String, dynamic> json) {
  final OrderBean orderBean = OrderBean();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    orderBean.userId = userId;
  }
  final int? linkId = jsonConvert.convert<int>(json['linkId']);
  if (linkId != null) {
    orderBean.linkId = linkId;
  }
  final int? afterChange = jsonConvert.convert<int>(json['afterChange']);
  if (afterChange != null) {
    orderBean.afterChange = afterChange;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    orderBean.id = id;
  }
  final int? beforeChange = jsonConvert.convert<int>(json['beforeChange']);
  if (beforeChange != null) {
    orderBean.beforeChange = beforeChange;
  }
  final int? depletionType = jsonConvert.convert<int>(json['depletionType']);
  if (depletionType != null) {
    orderBean.depletionType = depletionType;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    orderBean.updatedAt = updatedAt;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    orderBean.createdAt = createdAt;
  }
  final int? anchorId = jsonConvert.convert<int>(json['anchorId']);
  if (anchorId != null) {
    orderBean.anchorId = anchorId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    orderBean.type = type;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    orderBean.diamonds = diamonds;
  }
  return orderBean;
}

Map<String, dynamic> $OrderBeanToJson(OrderBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['linkId'] = entity.linkId;
  data['afterChange'] = entity.afterChange;
  data['id'] = entity.id;
  data['beforeChange'] = entity.beforeChange;
  data['depletionType'] = entity.depletionType;
  data['updatedAt'] = entity.updatedAt;
  data['createdAt'] = entity.createdAt;
  data['anchorId'] = entity.anchorId;
  data['type'] = entity.type;
  data['diamonds'] = entity.diamonds;
  return data;
}

extension OrderBeanExtension on OrderBean {
  OrderBean copyWith({
    int? userId,
    int? linkId,
    int? afterChange,
    int? id,
    int? beforeChange,
    int? depletionType,
    int? updatedAt,
    int? createdAt,
    int? anchorId,
    int? type,
    int? diamonds,
  }) {
    return OrderBean()
      ..userId = userId ?? this.userId
      ..linkId = linkId ?? this.linkId
      ..afterChange = afterChange ?? this.afterChange
      ..id = id ?? this.id
      ..beforeChange = beforeChange ?? this.beforeChange
      ..depletionType = depletionType ?? this.depletionType
      ..updatedAt = updatedAt ?? this.updatedAt
      ..createdAt = createdAt ?? this.createdAt
      ..anchorId = anchorId ?? this.anchorId
      ..type = type ?? this.type
      ..diamonds = diamonds ?? this.diamonds;
  }
}

OrderData $OrderDataFromJson(Map<String, dynamic> json) {
  final OrderData orderData = OrderData();
  final int? currencyFee = jsonConvert.convert<int>(json['currencyFee']);
  if (currencyFee != null) {
    orderData.currencyFee = currencyFee;
  }
  final int? paidAt = jsonConvert.convert<int>(json['paidAt']);
  if (paidAt != null) {
    orderData.paidAt = paidAt;
  }
  final String? currencyCode = jsonConvert.convert<String>(
      json['currencyCode']);
  if (currencyCode != null) {
    orderData.currencyCode = currencyCode;
  }
  final String? orderNo = jsonConvert.convert<String>(json['orderNo']);
  if (orderNo != null) {
    orderData.orderNo = orderNo;
  }
  final String? channelName = jsonConvert.convert<String>(json['channelName']);
  if (channelName != null) {
    orderData.channelName = channelName;
  }
  final String? tradeNo = jsonConvert.convert<String>(json['tradeNo']);
  if (tradeNo != null) {
    orderData.tradeNo = tradeNo;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    orderData.orderStatus = orderStatus;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    orderData.createdAt = createdAt;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    orderData.updatedAt = updatedAt;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    orderData.diamonds = diamonds;
  }
  final int? vipDays = jsonConvert.convert<int>(json['vipDays']);
  if (vipDays != null) {
    orderData.vipDays = vipDays;
  }
  return orderData;
}

Map<String, dynamic> $OrderDataToJson(OrderData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['currencyFee'] = entity.currencyFee;
  data['paidAt'] = entity.paidAt;
  data['currencyCode'] = entity.currencyCode;
  data['orderNo'] = entity.orderNo;
  data['channelName'] = entity.channelName;
  data['tradeNo'] = entity.tradeNo;
  data['orderStatus'] = entity.orderStatus;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  data['diamonds'] = entity.diamonds;
  data['vipDays'] = entity.vipDays;
  return data;
}

extension OrderDataExtension on OrderData {
  OrderData copyWith({
    int? currencyFee,
    int? paidAt,
    String? currencyCode,
    String? orderNo,
    String? channelName,
    String? tradeNo,
    int? orderStatus,
    int? createdAt,
    int? updatedAt,
    int? diamonds,
    int? vipDays,
  }) {
    return OrderData()
      ..currencyFee = currencyFee ?? this.currencyFee
      ..paidAt = paidAt ?? this.paidAt
      ..currencyCode = currencyCode ?? this.currencyCode
      ..orderNo = orderNo ?? this.orderNo
      ..channelName = channelName ?? this.channelName
      ..tradeNo = tradeNo ?? this.tradeNo
      ..orderStatus = orderStatus ?? this.orderStatus
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..diamonds = diamonds ?? this.diamonds
      ..vipDays = vipDays ?? this.vipDays;
  }
}

CostBean $CostBeanFromJson(Map<String, dynamic> json) {
  final CostBean costBean = CostBean();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    costBean.userId = userId;
  }
  final int? linkId = jsonConvert.convert<int>(json['linkId']);
  if (linkId != null) {
    costBean.linkId = linkId;
  }
  final int? afterChange = jsonConvert.convert<int>(json['afterChange']);
  if (afterChange != null) {
    costBean.afterChange = afterChange;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    costBean.id = id;
  }
  final int? beforeChange = jsonConvert.convert<int>(json['beforeChange']);
  if (beforeChange != null) {
    costBean.beforeChange = beforeChange;
  }
  final int? depletionType = jsonConvert.convert<int>(json['depletionType']);
  if (depletionType != null) {
    costBean.depletionType = depletionType;
  }
  final int? updatedAt = jsonConvert.convert<int>(json['updatedAt']);
  if (updatedAt != null) {
    costBean.updatedAt = updatedAt;
  }
  final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
  if (createdAt != null) {
    costBean.createdAt = createdAt;
  }
  final int? anchorId = jsonConvert.convert<int>(json['anchorId']);
  if (anchorId != null) {
    costBean.anchorId = anchorId;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    costBean.type = type;
  }
  final int? diamonds = jsonConvert.convert<int>(json['diamonds']);
  if (diamonds != null) {
    costBean.diamonds = diamonds;
  }
  final String? inviterNickname = jsonConvert.convert<String>(
      json['inviterNickname']);
  if (inviterNickname != null) {
    costBean.inviterNickname = inviterNickname;
  }
  final int? inviteeRepeat = jsonConvert.convert<int>(json['inviteeRepeat']);
  if (inviteeRepeat != null) {
    costBean.inviteeRepeat = inviteeRepeat;
  }
  return costBean;
}

Map<String, dynamic> $CostBeanToJson(CostBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['linkId'] = entity.linkId;
  data['afterChange'] = entity.afterChange;
  data['id'] = entity.id;
  data['beforeChange'] = entity.beforeChange;
  data['depletionType'] = entity.depletionType;
  data['updatedAt'] = entity.updatedAt;
  data['createdAt'] = entity.createdAt;
  data['anchorId'] = entity.anchorId;
  data['type'] = entity.type;
  data['diamonds'] = entity.diamonds;
  data['inviterNickname'] = entity.inviterNickname;
  data['inviteeRepeat'] = entity.inviteeRepeat;
  return data;
}

extension CostBeanExtension on CostBean {
  CostBean copyWith({
    int? userId,
    int? linkId,
    int? afterChange,
    int? id,
    int? beforeChange,
    int? depletionType,
    int? updatedAt,
    int? createdAt,
    int? anchorId,
    int? type,
    int? diamonds,
    String? inviterNickname,
    int? inviteeRepeat,
  }) {
    return CostBean()
      ..userId = userId ?? this.userId
      ..linkId = linkId ?? this.linkId
      ..afterChange = afterChange ?? this.afterChange
      ..id = id ?? this.id
      ..beforeChange = beforeChange ?? this.beforeChange
      ..depletionType = depletionType ?? this.depletionType
      ..updatedAt = updatedAt ?? this.updatedAt
      ..createdAt = createdAt ?? this.createdAt
      ..anchorId = anchorId ?? this.anchorId
      ..type = type ?? this.type
      ..diamonds = diamonds ?? this.diamonds
      ..inviterNickname = inviterNickname ?? this.inviterNickname
      ..inviteeRepeat = inviteeRepeat ?? this.inviteeRepeat;
  }
}