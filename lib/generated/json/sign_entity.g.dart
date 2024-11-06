import 'package:nyako/entities/sign_entity.dart';
import 'package:nyako/generated/json/base/json_convert_content.dart';

SignData $SignDataFromJson(Map<String, dynamic> json) {
  final SignData signData = SignData();
  final List<SignBean>? signInDaily = (json['signInDaily'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<SignBean>(e) as SignBean)
      .toList();
  if (signInDaily != null) {
    signData.signInDaily = signInDaily;
  }
  final List<SignBean>? signInDailyVip =
      (json['signInDailyVip'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<SignBean>(e) as SignBean)
          .toList();
  if (signInDailyVip != null) {
    signData.signInDailyVip = signInDailyVip;
  }
  final bool? userSignFlag = jsonConvert.convert<bool>(json['userSignFlag']);
  if (userSignFlag != null) {
    signData.userSignFlag = userSignFlag;
  }
  final bool? vipSignFlag = jsonConvert.convert<bool>(json['vipSignFlag']);
  if (vipSignFlag != null) {
    signData.vipSignFlag = vipSignFlag;
  }
  final int? signDay = jsonConvert.convert<int>(json['signDay']);
  if (signDay != null) {
    signData.signDay = signDay;
  }
  return signData;
}

Map<String, dynamic> $SignDataToJson(SignData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['signInDaily'] = entity.signInDaily?.map((v) => v.toJson()).toList();
  data['signInDailyVip'] =
      entity.signInDailyVip?.map((v) => v.toJson()).toList();
  data['userSignFlag'] = entity.userSignFlag;
  data['vipSignFlag'] = entity.vipSignFlag;
  data['signDay'] = entity.signDay;
  return data;
}

extension SignDataExtension on SignData {
  SignData copyWith({
    List<SignBean>? signInDaily,
    List<SignBean>? signInDailyVip,
    bool? userSignFlag,
    bool? vipSignFlag,
    int? signDay,
  }) {
    return SignData()
      ..signInDaily = signInDaily ?? this.signInDaily
      ..signInDailyVip = signInDailyVip ?? this.signInDailyVip
      ..userSignFlag = userSignFlag ?? this.userSignFlag
      ..vipSignFlag = vipSignFlag ?? this.vipSignFlag
      ..signDay = signDay ?? this.signDay;
  }
}

SignBean $SignBeanFromJson(Map<String, dynamic> json) {
  final SignBean signBean = SignBean();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    signBean.id = id;
  }
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    signBean.configId = configId;
  }
  final int? isVip = jsonConvert.convert<int>(json['isVip']);
  if (isVip != null) {
    signBean.isVip = isVip;
  }
  final int? value = jsonConvert.convert<int>(json['value']);
  if (value != null) {
    signBean.value = value;
  }
  final int? vipDiamonds = jsonConvert.convert<int>(json['vipDiamonds']);
  if (vipDiamonds != null) {
    signBean.vipDiamonds = vipDiamonds;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    signBean.icon = icon;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    signBean.name = name;
  }
  final String? signDate = jsonConvert.convert<String>(json['signDate']);
  if (signDate != null) {
    signBean.signDate = signDate;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    signBean.type = type;
  }
  return signBean;
}

Map<String, dynamic> $SignBeanToJson(SignBean entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['configId'] = entity.configId;
  data['isVip'] = entity.isVip;
  data['value'] = entity.value;
  data['vipDiamonds'] = entity.vipDiamonds;
  data['icon'] = entity.icon;
  data['name'] = entity.name;
  data['signDate'] = entity.signDate;
  data['type'] = entity.type;
  return data;
}

extension SignBeanExtension on SignBean {
  SignBean copyWith({
    int? id,
    int? configId,
    int? isVip,
    int? value,
    int? vipDiamonds,
    String? icon,
    String? name,
    String? signDate,
    int? type,
  }) {
    return SignBean()
      ..id = id ?? this.id
      ..configId = configId ?? this.configId
      ..isVip = isVip ?? this.isVip
      ..value = value ?? this.value
      ..vipDiamonds = vipDiamonds ?? this.vipDiamonds
      ..icon = icon ?? this.icon
      ..name = name ?? this.name
      ..signDate = signDate ?? this.signDate
      ..type = type ?? this.type;
  }
}
