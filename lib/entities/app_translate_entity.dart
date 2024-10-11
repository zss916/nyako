import 'dart:convert';
import '../generated/json/base/json_field.dart';
import '../generated/json/app_translate_entity.g.dart';

@JsonSerializable()
class TranslateData {
  String? appChannel;
  String? appVersion;
  String? language;
  int? configVersion;
  String? configUrl;
  int? appNumber;
  List<TranslateDataConfigs>? configs;

  TranslateData();

  factory TranslateData.fromJson(Map<String, dynamic> json) =>
      $TranslateDataFromJson(json);

  Map<String, dynamic> toJson() => $TranslateDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TranslateDataConfigs {
  String? configKey;
  String? configValue;
  String? language;

  TranslateDataConfigs();

  factory TranslateDataConfigs.fromJson(Map<String, dynamic> json) =>
      $TranslateDataConfigsFromJson(json);

  Map<String, dynamic> toJson() => $TranslateDataConfigsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
