import 'package:oliapro/entities/app_leval_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

LevalBean $LevalBeanFromJson(Map<String, dynamic> json) {
  final LevalBean levalBean = LevalBean();
  final int? rid = jsonConvert.convert<int>(json['rid']);
  if (rid != null) {
    levalBean.rid = rid;
  }
  final int? grade = jsonConvert.convert<int>(json['grade']);
  if (grade != null) {
    levalBean.grade = grade;
  }
  final int? areaCode = jsonConvert.convert<int>(json['areaCode']);
  if (areaCode != null) {
    levalBean.areaCode = areaCode;
  }
  final int? howExp = jsonConvert.convert<int>(json['howExp']);
  if (howExp != null) {
    levalBean.howExp = howExp;
  }
  final int? awardType = jsonConvert.convert<int>(json['awardType']);
  if (awardType != null) {
    levalBean.awardType = awardType;
  }
  final int? awardVal = jsonConvert.convert<int>(json['awardVal']);
  if (awardVal != null) {
    levalBean.awardVal = awardVal;
  }
  final String? awardName = jsonConvert.convert<String>(json['awardName']);
  if (awardName != null) {
    levalBean.awardName = awardName;
  }
  final String? awardIcon = jsonConvert.convert<String>(json['awardIcon']);
  if (awardIcon != null) {
    levalBean.awardIcon = awardIcon;
  }
  final String? awardBackground =
      jsonConvert.convert<String>(json['awardBackground']);
  if (awardBackground != null) {
    levalBean.awardBackground = awardBackground;
  }
  return levalBean;
}

Map<String, dynamic> $LevalBeanToJson(LevalBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['rid'] = entity.rid;
  data['grade'] = entity.grade;
  data['areaCode'] = entity.areaCode;
  data['howExp'] = entity.howExp;
  data['awardType'] = entity.awardType;
  data['awardVal'] = entity.awardVal;
  data['awardName'] = entity.awardName;
  data['awardIcon'] = entity.awardIcon;
  data['awardBackground'] = entity.awardBackground;
  return data;
}

extension LevalBeanExtension on LevalBean {
  LevalBean copyWith({
    int? rid,
    int? grade,
    int? areaCode,
    int? howExp,
    int? awardType,
    int? awardVal,
    String? awardName,
    String? awardIcon,
    String? awardBackground,
  }) {
    return LevalBean()
      ..rid = rid ?? this.rid
      ..grade = grade ?? this.grade
      ..areaCode = areaCode ?? this.areaCode
      ..howExp = howExp ?? this.howExp
      ..awardType = awardType ?? this.awardType
      ..awardVal = awardVal ?? this.awardVal
      ..awardName = awardName ?? this.awardName
      ..awardIcon = awardIcon ?? this.awardIcon
      ..awardBackground = awardBackground ?? this.awardBackground;
  }
}
