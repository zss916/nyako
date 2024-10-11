import 'package:oliapro/entities/app_oss_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

OssConfig $OssConfigFromJson(Map<String, dynamic> json) {
  final OssConfig ossConfig = OssConfig();
  final String? endpoint = jsonConvert.convert<String>(json['endpoint']);
  if (endpoint != null) {
    ossConfig.endpoint = endpoint;
  }
  final String? bucket = jsonConvert.convert<String>(json['bucket']);
  if (bucket != null) {
    ossConfig.bucket = bucket;
  }
  final String? path = jsonConvert.convert<String>(json['path']);
  if (path != null) {
    ossConfig.path = path;
  }
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    ossConfig.key = key;
  }
  final String? secret = jsonConvert.convert<String>(json['secret']);
  if (secret != null) {
    ossConfig.secret = secret;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    ossConfig.token = token;
  }
  final int? expire = jsonConvert.convert<int>(json['expire']);
  if (expire != null) {
    ossConfig.expire = expire;
  }
  return ossConfig;
}

Map<String, dynamic> $OssConfigToJson(OssConfig entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['endpoint'] = entity.endpoint;
  data['bucket'] = entity.bucket;
  data['path'] = entity.path;
  data['key'] = entity.key;
  data['secret'] = entity.secret;
  data['token'] = entity.token;
  data['expire'] = entity.expire;
  return data;
}

extension OssConfigExtension on OssConfig {
  OssConfig copyWith({
    String? endpoint,
    String? bucket,
    String? path,
    String? key,
    String? secret,
    String? token,
    int? expire,
  }) {
    return OssConfig()
      ..endpoint = endpoint ?? this.endpoint
      ..bucket = bucket ?? this.bucket
      ..path = path ?? this.path
      ..key = key ?? this.key
      ..secret = secret ?? this.secret
      ..token = token ?? this.token
      ..expire = expire ?? this.expire;
  }
}
