import 'package:oliapro/entities/app_draw_user_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

DrawUserEntity $DrawUserEntityFromJson(Map<String, dynamic> json) {
  final DrawUserEntity drawUserEntity = DrawUserEntity();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    drawUserEntity.userId = userId;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    drawUserEntity.nickname = nickname;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    drawUserEntity.portrait = portrait;
  }
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    drawUserEntity.configId = configId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    drawUserEntity.name = name;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    drawUserEntity.icon = icon;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    drawUserEntity.value = value;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    drawUserEntity.content = content;
  }
  return drawUserEntity;
}

Map<String, dynamic> $DrawUserEntityToJson(DrawUserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickname'] = entity.nickname;
  data['portrait'] = entity.portrait;
  data['configId'] = entity.configId;
  data['name'] = entity.name;
  data['icon'] = entity.icon;
  data['value'] = entity.value;
  data['content'] = entity.content;
  return data;
}

extension DrawUserEntityExtension on DrawUserEntity {
  DrawUserEntity copyWith({
    int? userId,
    String? nickname,
    String? portrait,
    int? configId,
    String? name,
    String? icon,
    int? value,
    String? content,
  }) {
    return DrawUserEntity()
      ..userId = userId ?? this.userId
      ..nickname = nickname ?? this.nickname
      ..portrait = portrait ?? this.portrait
      ..configId = configId ?? this.configId
      ..name = name ?? this.name
      ..icon = icon ?? this.icon
      ..value = value ?? this.value
      ..content = content ?? this.content;
  }
}
