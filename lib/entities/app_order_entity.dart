import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';

import '../generated/json/app_order_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class OrderBean {
  OrderBean();

  factory OrderBean.fromJson(Map<String, dynamic> json) =>
      $OrderBeanFromJson(json);

  Map<String, dynamic> toJson() => $OrderBeanToJson(this);

  int? userId;
  int? linkId;
  int? afterChange;
  int? id;
  int? beforeChange;
  int? depletionType;
  int? updatedAt;
  int? createdAt;
  int? anchorId;
  int? type;
  int? diamonds;
}

@JsonSerializable()
class OrderData {
  OrderData();

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      $OrderDataFromJson(json);

  Map<String, dynamic> toJson() => $OrderDataToJson(this);

  int? currencyFee;
  int? paidAt;
  String? currencyCode;
  String? orderNo;
  String? channelName;
  String? tradeNo;
  int? orderStatus;
  int? createdAt;
  int? updatedAt;
  int? diamonds;
  int? vipDays;

  int get showDiamond => diamonds ?? 0;

  String get createdAtTime => formatDate(
      DateTime.fromMillisecondsSinceEpoch(createdAt ?? 0),
      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);

  String get showTitleStr => titleStr();

  String titleStr() {
    String titleStr = "--";
    switch (orderStatus) {
      case 0:
        {
          titleStr = Tr.app_obligation.tr;
        }
        break;
      case 1:
        {
          titleStr = Tr.app_order_completion.tr;
        }
        break;
      case 2:
        {
          titleStr = Tr.app_order_failed.tr;
        }
        break;
      case 3:
        {
          titleStr = Tr.app_order_status_failure.tr;
        }
        break;
    }
    return titleStr;
  }

  Color get showTxtColor => txtColor();

  Color txtColor() {
    Color txtColor = Colors.transparent;
    switch (orderStatus) {
      case 0:
        {
          txtColor = const Color(0xFFF447FF);
        }
        break;
      case 1:
        {
          txtColor = const Color(0xFF3BC2FF);
        }
        break;
      case 2:
        {
          txtColor = Colors.red;
        }
        break;
      case 3:
        {
          txtColor = const Color(0xFFFF5A3D);
        }
        break;
    }
    return txtColor;
  }
}

@JsonSerializable()
class CostBean {
  CostBean();

  factory CostBean.fromJson(Map<String, dynamic> json) =>
      $CostBeanFromJson(json);

  Map<String, dynamic> toJson() => $CostBeanToJson(this);

  int? userId;
  int? linkId;
  int? afterChange;
  int? id;
  int? beforeChange;
  int? depletionType;
  int? updatedAt;
  int? createdAt;
  int? anchorId;
  int? type;
  int? diamonds;
  String? inviterNickname;
  int? inviteeRepeat; //被邀请人是否重复注册，0.不重复，1.重复

  String consumptioContent() {
    String costType = "";
    switch (depletionType) {
      case 0:
        {
          costType = Tr.app_other_expense.tr;
        }
        break;
      case 1:
        {
          costType = Tr.app_video_consumption.tr;
        }
        break;
      case 2:
        {
          costType = Tr.app_audio_consumer.tr;
        }
        break;
      case 3:
        {
          costType = Tr.app_present_consumption.tr;
        }
        break;
      case 4:
        {
          costType = Tr.app_message_deduction.tr;
        }
        break;
      case 5:
        {
          costType = Tr.app_sign_in_to_give.tr;
        }
        break;
      case 6:
        {
          costType = "punish";
        }
        break;
      case 7:
        {
          costType = "settlement";
        }
        break;
      case 8:
        {
          costType = "Refund";
        }
        break;
      case 9:
        {
          costType = Tr.app_get_vip_diamonds.tr;
        }
        break;
      case 10:
        {
          costType = Tr.app_registration_reward.trArgs([inviterNickname ?? ""]);
        }
        break;
      case 11:
        {
          costType = Tr.app_diamond_increase.tr;
        }
        break;
      case 12:
        {
          costType = Tr.app_recharge.tr;
        }
        break;
      case 13:
        {
          costType = Tr.app_subscription.tr;
        }
        break;
      case 14:
        {
          costType = Tr.app_lottery.tr;
        }
        break;
      case 15:
        {
          costType = Tr.app_diamond_increase.tr;
        }
        break;
      case 16:
        {
          costType = "Award";
        }
        break;
      case 17:
        {
          costType = "CompleteInfo";
        }
        break;
      case 18:
        {
          //广告奖励
          costType = Tr.app_cost_ad_reward.tr;
        }
        break;
      case 19:
        {
          costType = Tr.app_invite_rewards.tr;
        }
        break;

      case 21: // 购买幸运泡泡扣费
        {
          costType = Tr.app_buy_bubble_cost.tr;
        }
        break;
      case 22: // 森林舞会下注扣费
        {
          costType = Tr.app_forest_buy_cost.tr;
        }
        break;
      case 23: // 森林舞会中奖奖励
        {
          costType = Tr.app_forest_reward.tr;
        }
        break;
      case 24: // 幸运数字下注扣费
        {
          costType = Tr.app_luck_num_chip_cost.tr;
        }
        break;
      case 25: // 幸运数字中奖奖励
        {
          costType = Tr.app_luck_num_reward.tr;
        }
        break;
      case 26: // 赛⻋下注扣费
        {
          costType = Tr.app_trace_chip_cost.tr;
        }
        break;

      case 27: // 赛⻋中奖奖励
        {
          costType = Tr.app_trace_reward.tr;
        }
        break;

      case 29:
        {
          costType = Tr.appOrderSignReward.tr;
        }
      default:
        costType = "--";
        break;
    }
    return costType;
  }
}
