import 'package:nyako/entities/app_sensitive_word_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

SensitiveWordBean $SensitiveWordBeanFromJson(Map<String, dynamic> json) {
  final SensitiveWordBean sensitiveWordBean = SensitiveWordBean();
  final String? areaCode = jsonConvert.convert<String>(json['areaCode']);
  if (areaCode != null) {
    sensitiveWordBean.areaCode = areaCode;
  }
  final String? words = jsonConvert.convert<String>(json['words']);
  if (words != null) {
    sensitiveWordBean.words = words;
  }
  return sensitiveWordBean;
}

Map<String, dynamic> $SensitiveWordBeanToJson(SensitiveWordBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['areaCode'] = entity.areaCode;
  data['words'] = entity.words;
  return data;
}

extension SensitiveWordBeanExtension on SensitiveWordBean {
  SensitiveWordBean copyWith({
    String? areaCode,
    String? words,
  }) {
    return SensitiveWordBean()
      ..areaCode = areaCode ?? this.areaCode
      ..words = words ?? this.words;
  }
}
