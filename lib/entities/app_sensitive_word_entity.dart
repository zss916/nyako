import '../generated/json/base/json_field.dart';
import '../generated/json/app_sensitive_word_entity.g.dart';

@JsonSerializable()
class SensitiveWordBean {
  SensitiveWordBean();

  factory SensitiveWordBean.fromJson(Map<String, dynamic> json) =>
      $SensitiveWordBeanFromJson(json);

  Map<String, dynamic> toJson() => $SensitiveWordBeanToJson(this);

  String? areaCode;
  String? words;
}
