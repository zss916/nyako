import 'package:oliapro/entities/app_config_entity.dart';
import 'package:oliapro/generated/json/base/json_convert_content.dart';

ConfigData $ConfigDataFromJson(Map<String, dynamic> json) {
  final ConfigData configData = ConfigData();
  final String? aiHelp = jsonConvert.convert<String>(json['aiHelp']);
  if (aiHelp != null) {
    configData.aiHelp = aiHelp;
  }
  final int? sendMsgDiamondsPrice =
      jsonConvert.convert<int>(json['sendMsgDiamondsPrice']);
  if (sendMsgDiamondsPrice != null) {
    configData.sendMsgDiamondsPrice = sendMsgDiamondsPrice;
  }
  final String? appStoreWriteLink =
      jsonConvert.convert<String>(json['appStoreWriteLink']);
  if (appStoreWriteLink != null) {
    configData.appStoreWriteLink = appStoreWriteLink;
  }
  final int? freeMessageCount =
      jsonConvert.convert<int>(json['free_message_count']);
  if (freeMessageCount != null) {
    configData.freeMessageCount = freeMessageCount;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    configData.email = email;
  }
  final String? promotionTime =
      jsonConvert.convert<String>(json['promotionTime']);
  if (promotionTime != null) {
    configData.promotionTime = promotionTime;
  }
  final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
  if (whatsapp != null) {
    configData.whatsapp = whatsapp;
  }
  final String? agoraAppId = jsonConvert.convert<String>(json['agoraAppId']);
  if (agoraAppId != null) {
    configData.agoraAppId = agoraAppId;
  }
  final int? chargePrice = jsonConvert.convert<int>(json['chargePrice']);
  if (chargePrice != null) {
    configData.chargePrice = chargePrice;
  }
  final bool? stopFbPurchase =
      jsonConvert.convert<bool>(json['stopFbPurchase']);
  if (stopFbPurchase != null) {
    configData.stopFbPurchase = stopFbPurchase;
  }
  final bool? stopLogan = jsonConvert.convert<bool>(json['stopLogan']);
  if (stopLogan != null) {
    configData.stopLogan = stopLogan;
  }
  final String? scale = jsonConvert.convert<String>(json['scale']);
  if (scale != null) {
    configData.scale = scale;
  }
  final String? payScale = jsonConvert.convert<String>(json['payScale']);
  if (payScale != null) {
    configData.payScale = payScale;
  }
  final String? adjust = jsonConvert.convert<String>(json['adjust']);
  if (adjust != null) {
    configData.adjust = adjust;
  }
  final String? publicKey = jsonConvert.convert<String>(json['publicKey']);
  if (publicKey != null) {
    configData.publicKey = publicKey;
  }
  final String? leveldetailurl =
      jsonConvert.convert<String>(json['leveldetailurl']);
  if (leveldetailurl != null) {
    configData.leveldetailurl = leveldetailurl;
  }
  final String? discountvideourl =
      jsonConvert.convert<String>(json['discountvideourl']);
  if (discountvideourl != null) {
    configData.discountvideourl = discountvideourl;
  }
  final String? appUpdate = jsonConvert.convert<String>(json['appUpdate']);
  if (appUpdate != null) {
    configData.appUpdate = appUpdate;
  }
  final int? vipDailyDiamonds =
      jsonConvert.convert<int>(json['vipDailyDiamonds']);
  if (vipDailyDiamonds != null) {
    configData.vipDailyDiamonds = vipDailyDiamonds;
  }
  final bool? openTestFbEvent =
      jsonConvert.convert<bool>(json['openTestFbEvent']);
  if (openTestFbEvent != null) {
    configData.openTestFbEvent = openTestFbEvent;
  }
  final bool? openFbLogin = jsonConvert.convert<bool>(json['openFbLogin']);
  if (openFbLogin != null) {
    configData.openFbLogin = openFbLogin;
  }
  final bool? stopTranslate = jsonConvert.convert<bool>(json['stopTranslate']);
  if (stopTranslate != null) {
    configData.stopTranslate = stopTranslate;
  }
  final String? qrData = jsonConvert.convert<String>(json['qrData']);
  if (qrData != null) {
    configData.qrData = qrData;
  }
  final String? transferInfo =
      jsonConvert.convert<String>(json['transferInfo']);
  if (transferInfo != null) {
    configData.transferInfo = transferInfo;
  }
  final String? pddDialogDisplay =
      jsonConvert.convert<String>(json['pddDialogDisplay']);
  if (pddDialogDisplay != null) {
    configData.pddDialogDisplay = pddDialogDisplay;
  }
  return configData;
}

Map<String, dynamic> $ConfigDataToJson(ConfigData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['aiHelp'] = entity.aiHelp;
  data['sendMsgDiamondsPrice'] = entity.sendMsgDiamondsPrice;
  data['appStoreWriteLink'] = entity.appStoreWriteLink;
  data['free_message_count'] = entity.freeMessageCount;
  data['email'] = entity.email;
  data['promotionTime'] = entity.promotionTime;
  data['whatsapp'] = entity.whatsapp;
  data['agoraAppId'] = entity.agoraAppId;
  data['chargePrice'] = entity.chargePrice;
  data['stopFbPurchase'] = entity.stopFbPurchase;
  data['stopLogan'] = entity.stopLogan;
  data['scale'] = entity.scale;
  data['payScale'] = entity.payScale;
  data['adjust'] = entity.adjust;
  data['publicKey'] = entity.publicKey;
  data['leveldetailurl'] = entity.leveldetailurl;
  data['discountvideourl'] = entity.discountvideourl;
  data['appUpdate'] = entity.appUpdate;
  data['vipDailyDiamonds'] = entity.vipDailyDiamonds;
  data['openTestFbEvent'] = entity.openTestFbEvent;
  data['openFbLogin'] = entity.openFbLogin;
  data['stopTranslate'] = entity.stopTranslate;
  data['qrData'] = entity.qrData;
  data['transferInfo'] = entity.transferInfo;
  data['pddDialogDisplay'] = entity.pddDialogDisplay;
  return data;
}

extension ConfigDataExtension on ConfigData {
  ConfigData copyWith({
    String? aiHelp,
    int? sendMsgDiamondsPrice,
    String? appStoreWriteLink,
    int? freeMessageCount,
    String? email,
    String? promotionTime,
    String? whatsapp,
    String? agoraAppId,
    int? chargePrice,
    bool? stopFbPurchase,
    bool? stopLogan,
    String? scale,
    String? payScale,
    String? adjust,
    String? publicKey,
    String? leveldetailurl,
    String? discountvideourl,
    String? appUpdate,
    int? vipDailyDiamonds,
    bool? openTestFbEvent,
    bool? openFbLogin,
    bool? stopTranslate,
    String? qrData,
    String? transferInfo,
    String? pddDialogDisplay,
  }) {
    return ConfigData()
      ..aiHelp = aiHelp ?? this.aiHelp
      ..sendMsgDiamondsPrice = sendMsgDiamondsPrice ?? this.sendMsgDiamondsPrice
      ..appStoreWriteLink = appStoreWriteLink ?? this.appStoreWriteLink
      ..freeMessageCount = freeMessageCount ?? this.freeMessageCount
      ..email = email ?? this.email
      ..promotionTime = promotionTime ?? this.promotionTime
      ..whatsapp = whatsapp ?? this.whatsapp
      ..agoraAppId = agoraAppId ?? this.agoraAppId
      ..chargePrice = chargePrice ?? this.chargePrice
      ..stopFbPurchase = stopFbPurchase ?? this.stopFbPurchase
      ..stopLogan = stopLogan ?? this.stopLogan
      ..scale = scale ?? this.scale
      ..payScale = payScale ?? this.payScale
      ..adjust = adjust ?? this.adjust
      ..publicKey = publicKey ?? this.publicKey
      ..leveldetailurl = leveldetailurl ?? this.leveldetailurl
      ..discountvideourl = discountvideourl ?? this.discountvideourl
      ..appUpdate = appUpdate ?? this.appUpdate
      ..vipDailyDiamonds = vipDailyDiamonds ?? this.vipDailyDiamonds
      ..openTestFbEvent = openTestFbEvent ?? this.openTestFbEvent
      ..openFbLogin = openFbLogin ?? this.openFbLogin
      ..stopTranslate = stopTranslate ?? this.stopTranslate
      ..qrData = qrData ?? this.qrData
      ..transferInfo = transferInfo ?? this.transferInfo
      ..pddDialogDisplay = pddDialogDisplay ?? this.pddDialogDisplay;
  }
}

AppUpdate $AppUpdateFromJson(Map<String, dynamic> json) {
  final AppUpdate appUpdate = AppUpdate();
  final bool? isShow = jsonConvert.convert<bool>(json['isShow']);
  if (isShow != null) {
    appUpdate.isShow = isShow;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    appUpdate.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    appUpdate.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    appUpdate.content = content;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    appUpdate.url = url;
  }
  return appUpdate;
}

Map<String, dynamic> $AppUpdateToJson(AppUpdate entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['isShow'] = entity.isShow;
  data['type'] = entity.type;
  data['title'] = entity.title;
  data['content'] = entity.content;
  data['url'] = entity.url;
  return data;
}

extension AppUpdateExtension on AppUpdate {
  AppUpdate copyWith({
    bool? isShow,
    int? type,
    String? title,
    String? content,
    String? url,
  }) {
    return AppUpdate()
      ..isShow = isShow ?? this.isShow
      ..type = type ?? this.type
      ..title = title ?? this.title
      ..content = content ?? this.content
      ..url = url ?? this.url;
  }
}

PayScale $PayScaleFromJson(Map<String, dynamic> json) {
  final PayScale payScale = PayScale();
  final double? adjustScale = jsonConvert.convert<double>(json['adjustScale']);
  if (adjustScale != null) {
    payScale.adjustScale = adjustScale;
  }
  final double? facebookScale =
      jsonConvert.convert<double>(json['facebookScale']);
  if (facebookScale != null) {
    payScale.facebookScale = facebookScale;
  }
  final double? defaultScale =
      jsonConvert.convert<double>(json['defaultScale']);
  if (defaultScale != null) {
    payScale.defaultScale = defaultScale;
  }
  return payScale;
}

Map<String, dynamic> $PayScaleToJson(PayScale entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['adjustScale'] = entity.adjustScale;
  data['facebookScale'] = entity.facebookScale;
  data['defaultScale'] = entity.defaultScale;
  return data;
}

extension PayScaleExtension on PayScale {
  PayScale copyWith({
    double? adjustScale,
    double? facebookScale,
    double? defaultScale,
  }) {
    return PayScale()
      ..adjustScale = adjustScale ?? this.adjustScale
      ..facebookScale = facebookScale ?? this.facebookScale
      ..defaultScale = defaultScale ?? this.defaultScale;
  }
}
