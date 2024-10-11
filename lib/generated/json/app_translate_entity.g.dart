import 'package:oliapro/entities/app_translate_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

TranslateData $TranslateDataFromJson(Map<String, dynamic> json) {
  final TranslateData translateData = TranslateData();
  final String? appChannel = jsonConvert.convert<String>(json['appChannel']);
  if (appChannel != null) {
    translateData.appChannel = appChannel;
  }
  final String? appVersion = jsonConvert.convert<String>(json['appVersion']);
  if (appVersion != null) {
    translateData.appVersion = appVersion;
  }
  final String? language = jsonConvert.convert<String>(json['language']);
  if (language != null) {
    translateData.language = language;
  }
  final int? configVersion = jsonConvert.convert<int>(json['configVersion']);
  if (configVersion != null) {
    translateData.configVersion = configVersion;
  }
  final String? configUrl = jsonConvert.convert<String>(json['configUrl']);
  if (configUrl != null) {
    translateData.configUrl = configUrl;
  }
  final int? appNumber = jsonConvert.convert<int>(json['appNumber']);
  if (appNumber != null) {
    translateData.appNumber = appNumber;
  }
  final List<TranslateDataConfigs>? configs = (json['configs']
          as List<dynamic>?)
      ?.map((e) =>
          jsonConvert.convert<TranslateDataConfigs>(e) as TranslateDataConfigs)
      .toList();
  if (configs != null) {
    translateData.configs = configs;
  }
  return translateData;
}

Map<String, dynamic> $TranslateDataToJson(TranslateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['appChannel'] = entity.appChannel;
  data['appVersion'] = entity.appVersion;
  data['language'] = entity.language;
  data['configVersion'] = entity.configVersion;
  data['configUrl'] = entity.configUrl;
  data['appNumber'] = entity.appNumber;
  data['configs'] = entity.configs?.map((v) => v.toJson()).toList();
  return data;
}

extension TranslateDataExtension on TranslateData {
  TranslateData copyWith({
    String? appChannel,
    String? appVersion,
    String? language,
    int? configVersion,
    String? configUrl,
    int? appNumber,
    List<TranslateDataConfigs>? configs,
  }) {
    return TranslateData()
      ..appChannel = appChannel ?? this.appChannel
      ..appVersion = appVersion ?? this.appVersion
      ..language = language ?? this.language
      ..configVersion = configVersion ?? this.configVersion
      ..configUrl = configUrl ?? this.configUrl
      ..appNumber = appNumber ?? this.appNumber
      ..configs = configs ?? this.configs;
  }
}

TranslateDataConfigs $TranslateDataConfigsFromJson(Map<String, dynamic> json) {
  final TranslateDataConfigs translateDataConfigs = TranslateDataConfigs();
  final String? configKey = jsonConvert.convert<String>(json['configKey']);
  if (configKey != null) {
    translateDataConfigs.configKey = configKey;
  }
  final String? configValue = jsonConvert.convert<String>(json['configValue']);
  if (configValue != null) {
    translateDataConfigs.configValue = configValue;
  }
  final String? language = jsonConvert.convert<String>(json['language']);
  if (language != null) {
    translateDataConfigs.language = language;
  }
  return translateDataConfigs;
}

Map<String, dynamic> $TranslateDataConfigsToJson(TranslateDataConfigs entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['configKey'] = entity.configKey;
  data['configValue'] = entity.configValue;
  data['language'] = entity.language;
  return data;
}

extension TranslateDataConfigsExtension on TranslateDataConfigs {
  TranslateDataConfigs copyWith({
    String? configKey,
    String? configValue,
    String? language,
  }) {
    return TranslateDataConfigs()
      ..configKey = configKey ?? this.configKey
      ..configValue = configValue ?? this.configValue
      ..language = language ?? this.language;
  }
}
