import '../generated/json/base/json_field.dart';
import '../generated/json/app_oss_entity.g.dart';

@JsonSerializable()
class OssConfig {
  OssConfig();

  factory OssConfig.fromJson(Map<String, dynamic> json) =>
      $OssConfigFromJson(json);

  Map<String, dynamic> toJson() => $OssConfigToJson(this);

  String? endpoint;
  String? bucket;
  String? path;
  String? key;
  String? secret;
  String? token;
  int? expire;
}
