import '../generated/json/base/json_field.dart';
import '../generated/json/app_leval_entity.g.dart';

@JsonSerializable()
class LevalBean {
  LevalBean();

  factory LevalBean.fromJson(Map<String, dynamic> json) =>
      $LevalBeanFromJson(json);

  Map<String, dynamic> toJson() => $LevalBeanToJson(this);

  int? rid;
  int? grade;
  int? areaCode;
  int? howExp;
  int? awardType;
  int? awardVal;
  String? awardName;
  String? awardIcon;
  String? awardBackground;
}
