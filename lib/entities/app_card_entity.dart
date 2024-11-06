import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';

import '../generated/json/app_card_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class CardBean {
  CardBean();

  factory CardBean.fromJson(Map<String, dynamic> json) =>
      $CardBeanFromJson(json);

  Map<String, dynamic> toJson() => $CardBeanToJson(this);

  int? userId; // 用户id
  int? propType; // 1.通话体验卡，2.钻石加成卡,3.礼物卡
  int? propDuration; // 体验卡时长/钻石加成/礼物id
  int? propNum; // 道具数量
  String? icon; // 礼物图标
  String? name; //礼物名称
  String? animEffectUrl; //

  bool get isPropCard => propType == 1;

  String get num => " x$propNum";

  String get title => propType == 1
      ? Tr.app_vido_tx.tr
      : Tr.app_prop_add_title.trArgs(["$propDuration"]);

  String get content => propType == 1
      ? Tr.app_vido_info.trArgs(["${(propDuration ?? 1500) ~/ 1000.0}"])
      : Tr.app_prop_add_content.trArgs(["$propDuration"]);

  String get showIcon => icon ?? '';

  String get showName => name ?? "--";
}
