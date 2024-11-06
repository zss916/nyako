import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';

import '../generated/json/app_balance_list_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class BalanceListEntity {
  BalanceListEntity();

  factory BalanceListEntity.fromJson(Map<String, dynamic> json) =>
      $BalanceListEntityFromJson(json);

  Map<String, dynamic> toJson() => $BalanceListEntityToJson(this);

  int? code;
  String? message;
  List<BalanceListData>? data;
  dynamic? page;
}

@JsonSerializable()
class BalanceListData {
  BalanceListData();

  factory BalanceListData.fromJson(Map<String, dynamic> json) =>
      $BalanceListDataFromJson(json);

  Map<String, dynamic> toJson() => $BalanceListDataToJson(this);

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
  int? inviteeRepeat; //被邀请人是否重复注册，0.不重复，1.重复
  String? inviterNickname; // 邀请人昵称

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
      default:
        costType = "--";
        break;
    }
    return costType;
  }
}
