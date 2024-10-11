import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oliapro/entities/app_draw_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

DrawEntity $DrawEntityFromJson(Map<String, dynamic> json) {
  final DrawEntity drawEntity = DrawEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    drawEntity.code = code;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    drawEntity.message = message;
  }
  final List<DrawData>? data = (json['data'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<DrawData>(e) as DrawData)
      .toList();
  if (data != null) {
    drawEntity.data = data;
  }
  final dynamic page = json['page'];
  if (page != null) {
    drawEntity.page = page;
  }
  return drawEntity;
}

Map<String, dynamic> $DrawEntityToJson(DrawEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['page'] = entity.page;
  return data;
}

extension DrawEntityExtension on DrawEntity {
  DrawEntity copyWith({
    int? code,
    String? message,
    List<DrawData>? data,
    dynamic page,
  }) {
    return DrawEntity()
      ..code = code ?? this.code
      ..message = message ?? this.message
      ..data = data ?? this.data
      ..page = page ?? this.page;
  }
}

DrawData $DrawDataFromJson(Map<String, dynamic> json) {
  final DrawData drawData = DrawData();
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    drawData.configId = configId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    drawData.name = name;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    drawData.icon = icon;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    drawData.areaCode = areaCode;
  }
  final int? probability = jsonConvert.convert<int>(json['probability']);
  if (probability != null) {
    drawData.probability = probability;
  }
  final int? drawMode = jsonConvert.convert<int>(json['drawMode']);
  if (drawMode != null) {
    drawData.drawMode = drawMode;
  }
  final int? drawType = jsonConvert.convert<int>(json['drawType']);
  if (drawType != null) {
    drawData.drawType = drawType;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    drawData.value = value;
  }
  final Color? color = jsonConvert.convert<Color>(json['color']);
  if (color != null) {
    drawData.color = color;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    drawData.content = content;
  }
  return drawData;
}

Map<String, dynamic> $DrawDataToJson(DrawData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['configId'] = entity.configId;
  data['name'] = entity.name;
  data['icon'] = entity.icon;
  data['areaCode'] = entity.areaCode;
  data['probability'] = entity.probability;
  data['drawMode'] = entity.drawMode;
  data['drawType'] = entity.drawType;
  data['value'] = entity.value;
  data['content'] = entity.content;
  return data;
}

extension DrawDataExtension on DrawData {
  DrawData copyWith({
    int? configId,
    String? name,
    String? icon,
    int? areaCode,
    int? probability,
    int? drawMode,
    int? drawType,
    int? value,
    Color? color,
    String? content,
  }) {
    return DrawData()
      ..configId = configId ?? this.configId
      ..name = name ?? this.name
      ..icon = icon ?? this.icon
      ..areaCode = areaCode ?? this.areaCode
      ..probability = probability ?? this.probability
      ..drawMode = drawMode ?? this.drawMode
      ..drawType = drawType ?? this.drawType
      ..value = value ?? this.value
      ..image = image ?? this.image
      ..color = color ?? this.color
      ..content = content ?? this.content;
  }
}
