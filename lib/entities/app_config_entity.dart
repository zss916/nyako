// @JsonSerializable()
// class YuliaCblConfigEntity {
//
// 	YuliaCblConfigEntity();
//
// 	factory YuliaCblConfigEntity.fromJson(Map<String, dynamic> json) => $YuliaCblConfigEntityFromJson(json);
//
// 	Map<String, dynamic> toJson() => $YuliaCblConfigEntityToJson(this);
//
//   int? code;
//   String? message;
//   CblConfigData? data;
//   dynamic? page;
// }

import '../generated/json/app_config_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class ConfigData {
  ConfigData();

  factory ConfigData.fromJson(Map<String, dynamic> json) =>
      $ConfigDataFromJson(json);

  Map<String, dynamic> toJson() => $ConfigDataToJson(this);

  String? aiHelp;
  int? sendMsgDiamondsPrice;
  String? appStoreWriteLink;
  @JSONField(name: "free_message_count")
  int? freeMessageCount;
  String? email;
  String? promotionTime;
  String? whatsapp;
  String? agoraAppId;
  int? chargePrice;
  // 1的时候支付数据不上报fb
  bool? stopFbPurchase;
  // 停止logan上报
  bool? stopLogan;
  String? scale;
  String? payScale;
  String? adjust;
  String? publicKey;
  String? leveldetailurl;
  String? discountvideourl;
  String? appUpdate;
  int? vipDailyDiamonds;
  @Deprecated("弃用")
  bool? openTestFbEvent; //打开测试fb 上传事件

  bool? openFbLogin;
  bool? stopTranslate; // true 停止翻译功能
  String? qrData; // 二维码

  String? transferInfo;

  //中奖商品弹框是否一直显示  逗号分开  0,1,1  0新用户显示，1一直显示
  String? pddDialogDisplay;
}

//  {"isShow":false,"content":" 因为... ","url":"https://baidu.com ","title":" 产品变更","type":2}
@JsonSerializable()
class AppUpdate {
  AppUpdate();

  factory AppUpdate.fromJson(Map<String, dynamic> json) =>
      $AppUpdateFromJson(json);

  Map<String, dynamic> toJson() => $AppUpdateToJson(this);
  bool? isShow;
  // 1 google, 2 url
  int? type;
  String? title;
  String? content;
  String? url;
}

@JsonSerializable()
class PayScale {
  PayScale();

  factory PayScale.fromJson(Map<String, dynamic> json) =>
      $PayScaleFromJson(json);

  Map<String, dynamic> toJson() => $PayScaleToJson(this);
  double? adjustScale;
  double? facebookScale;
  double? defaultScale;
}
