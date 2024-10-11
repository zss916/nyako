import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/json/app_recharge_active_config_entity.g.dart';

import '../../generated/json/base/json_field.dart';

@JsonSerializable()
class AppRechargeActiveConfigEntity {
  int? createdAt;
  int? updatedAt;
  int? id;
  int? areaCode; //地区码
  String? activityName; //活动名称
  String? appChannelList; //应用渠道
  int? timeLimit; //复购时限,小时
  int? sendDiamond; //赠送钻石数
  String? userLimit; //参加活动用户限制,vip-仅vip,all-所有用户
  int? rewardLimit; //奖励次数上限
  int? status; //是否启用,1-启用,0-禁用

  AppRechargeActiveConfigEntity();
  factory AppRechargeActiveConfigEntity.fromJson(Map<String, dynamic> json) =>
      $AppRechargeActiveConfigEntityFromJson(json);

  Map<String, dynamic> toJson() => $AppRechargeActiveConfigEntityToJson(this);

  String get title => Tr.appNextPayTitle.trArgs(["${timeLimit ?? 0}"]);

  String get content => Tr.appNextPayContent.trArgs([
        userLimit == "all"
            ? Tr.appNextPayTitleTip1.tr
            : Tr.appNextPayTitleTip2.tr,
        "${timeLimit ?? 0}",
        "${sendDiamond ?? 0}",
        "${rewardLimit ?? 0}",
        "${(rewardLimit ?? 0) + 1}",
      ]);
}
