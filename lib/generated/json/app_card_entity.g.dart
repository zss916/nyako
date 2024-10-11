import 'package:oliapro/entities/app_card_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

CardBean $CardBeanFromJson(Map<String, dynamic> json) {
  final CardBean cardBean = CardBean();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    cardBean.userId = userId;
  }
  final int? propType = jsonConvert.convert<int>(json['propType']);
  if (propType != null) {
    cardBean.propType = propType;
  }
  final int? propDuration = jsonConvert.convert<int>(json['propDuration']);
  if (propDuration != null) {
    cardBean.propDuration = propDuration;
  }
  final int? propNum = jsonConvert.convert<int>(json['propNum']);
  if (propNum != null) {
    cardBean.propNum = propNum;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    cardBean.icon = icon;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    cardBean.name = name;
  }
  final String? animEffectUrl =
      jsonConvert.convert<String>(json['animEffectUrl']);
  if (animEffectUrl != null) {
    cardBean.animEffectUrl = animEffectUrl;
  }
  return cardBean;
}

Map<String, dynamic> $CardBeanToJson(CardBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['propType'] = entity.propType;
  data['propDuration'] = entity.propDuration;
  data['propNum'] = entity.propNum;
  data['icon'] = entity.icon;
  data['name'] = entity.name;
  data['animEffectUrl'] = entity.animEffectUrl;
  return data;
}

extension CardBeanExtension on CardBean {
  CardBean copyWith({
    int? userId,
    int? propType,
    int? propDuration,
    int? propNum,
    String? icon,
    String? name,
    String? animEffectUrl,
  }) {
    return CardBean()
      ..userId = userId ?? this.userId
      ..propType = propType ?? this.propType
      ..propDuration = propDuration ?? this.propDuration
      ..propNum = propNum ?? this.propNum
      ..icon = icon ?? this.icon
      ..name = name ?? this.name
      ..animEffectUrl = animEffectUrl ?? this.animEffectUrl;
  }
}
