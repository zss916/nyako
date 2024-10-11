import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/reward_dialog/reward_coupon_dialog.dart';
import 'package:oliapro/dialogs/reward_dialog/reward_time_dialog.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/pages/call/remote/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_check_calling_util.dart';

import 'reward_diamond_dialog.dart';

//拼多多砍一刀
class Pdd {
  //充值框显示次数
  static const _sp_topupbox_show_quantity = 'sp_topupbox_show_quantity';

  //支付弹框显示次数
  static const _sp_paymentbox_show_quantity = 'sp_paymentbox_show_quantity';

  //5分钟计时器
  static Timer? _timer_five_minutes;

  //90秒计时器
  static Timer? _timer_90_seconds;

  static bool _checkPayChannel = false;

  //是否启用流程  isEnableUser 是否启用新用户判断
  static bool _isEnable(int type, {bool isEnableUser = true}) {
    var pddDialogIsShowList = UserInfo.to.config?.pddDialogDisplay?.split(",");
    var pddDialogIsShow = "";
    if (pddDialogIsShowList != null && pddDialogIsShowList.length > type) {
      pddDialogIsShow = pddDialogIsShowList[type];
    }

    if (pddDialogIsShow == "1" || !isEnableUser) {
      return _isEnableForDiamonds() && _isEnableForUI(type);
    } else {
      //当前需要判断是否新用户
      if (UserInfo.to.myDetail?.isNewUser == 1) {
        //当前钻石余额
        return _isEnableForDiamonds() && _isEnableForUI(type);
      } else {
        //不是新用户，直接不启用流程
        return false;
      }
    }
  }

  //屏蔽一些在某些界面下的弹框
  // 不触发中奖弹窗的场景：
  // 用户在视频通话过程中不触发
  // 用户在VIP中心页面，VIP弹窗页面不触发用户在充值中心页面时不触发
  // 用户在充值中心页面时不触发
  // 用户在匹配过程中不触发
  static bool _isEnableForUI(int type) {
    if (type == 2) {
      if (AppCheckCallingUtil.checkCalling() ||
          ARoutes.isVipPage ||
          ARoutes.isVIPDialog ||
          ARoutes.isRecharge ||
          AppConstants.isMatch) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  //通过钻石判断是否启用
  static bool _isEnableForDiamonds() {
    //当前钻石余额
    int myDiamonds = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    //当前通话需要的最少的钻石数量
    int price = UserInfo.to.config?.chargePrice ?? 60;
    //判断当前用户的钻石是否小于1分钟通话钻石数量
    return (myDiamonds < price);
  }

  //通过钻石判断是否可以打电话
  static bool _isEnableForAnchorDiamonds(int chargePrice) {
    //当前钻石余额
    int myDiamonds = UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
    //当前通话需要的最少的钻石数量
    return (myDiamonds < chargePrice);
  }

  //打开充值弹框调用--->充值弹框次数+1,(首页，)
  static void topUpBoxShow() {
    debugPrint('CheckPdd--- openTopUpBoxShow');
    if (_isEnable(0)) {
      var newUpboxShowQuantity = (StorageService.to.prefs.getInt(
                  _sp_topupbox_show_quantity +
                      (UserInfo.to.userLogin?.userId ?? "")) ??
              0) +
          1;
      StorageService.to.prefs.setInt(
          _sp_topupbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          newUpboxShowQuantity);
      debugPrint(
          'CheckPdd--- openTopUpBoxShow -- newUpboxShowQuantity=$newUpboxShowQuantity');
    } else {
      //进行初始化
      StorageService.to.prefs.setInt(
          _sp_topupbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          0);
    }
  }

  //点击了渠道进行支付，这个情况下，关闭充值弹框之前减去1次
  static Future<bool> paymentBoxGoPay() {
    _checkPayChannel = true;
    if (_isEnable(1)) {
      var newPaymentBoxShowQuantity =
          (StorageService.to.prefs.getInt(_sp_paymentbox_show_quantity) ?? 0) -
              1;
      return StorageService.to.prefs
          .setInt(_sp_paymentbox_show_quantity, newPaymentBoxShowQuantity);
    } else {
      return StorageService.to.prefs.setInt(_sp_paymentbox_show_quantity, 0);
    }
  }

  //关闭充值弹框调用--->检查当前是否满足弹框(用户每弹出5次充值弹窗，第三次关闭弹窗时弹出该窗口，弹出中奖商品)
  static void topUpBoxClose() {
    debugPrint('CheckPdd--- topUpBoxClose');
    if (_isEnable(0)) {
      //debugPrint('CheckPdd--- topUpBoxClose_isEnable ${_isEnable()}');
      //是否显示中奖
      var isShowPrize = ((StorageService.to.prefs.getInt(
                      _sp_topupbox_show_quantity +
                          (UserInfo.to.userLogin?.userId ?? "")) ??
                  0) %
              5) ==
          0;
      // debugPrint('CheckPdd--- topUpBoxClose -- isShowPrize=$isShowPrize');
      if (isShowPrize) {
        //调用接口
        // debugPrint("CheckPdd---showRewardDiamondDialog");
        showRewardDiamondDialog();
      }
    }
  }

  //打开支付弹框调用--->支付弹框次数+1,
  static void paymentBoxShow() {
    //debugPrint('CheckPdd--- paymentBoxShow');
    if (_isEnable(1)) {
      var newPaymentBoxShowQuantity = (StorageService.to.prefs.getInt(
                  _sp_paymentbox_show_quantity +
                      (UserInfo.to.userLogin?.userId ?? "")) ??
              0) +
          1;
      StorageService.to.prefs.setInt(
          _sp_paymentbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          newPaymentBoxShowQuantity);
      // debugPrint('CheckPdd--- paymentBoxShow -- newPaymentBoxShowQuantity=$newPaymentBoxShowQuantity');
    } else {
      //进行初始化
      StorageService.to.prefs.setInt(
          _sp_paymentbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          0);
    }
  }

  //关闭充值弹框调用--->检查当前是否满足弹框(用户每调起支付窗口3次支付，第二次关闭弹出中奖商品2)
  static void paymentBoxClose() {
    //debugPrint('CheckPdd--- paymentBoxClose');
    if (_checkPayChannel) {
      _checkPayChannel = false;
      return;
    }
    if (_isEnable(1)) {
      //是否显示中奖
      var isShowPrize = ((StorageService.to.prefs.getInt(
                      _sp_paymentbox_show_quantity +
                          (UserInfo.to.userLogin?.userId ?? "")) ??
                  0) %
              3) ==
          0;
      //debugPrint('CheckPdd--- paymentBoxClose -- isShowPrize=$isShowPrize');
      if (isShowPrize) {
        showRewardCouponDialog();
      }
    }
  }

  //app进入首页的时候调用一次，每次余额变动调用一次---->(用户在app停留时间每6分钟，弹出中奖商品3)
  static void userBalanceChangeStart() {
    //  debugPrint('CheckPdd--- userBalanceChangeStart -- ${_isEnable()}');
    //取消之前的倒计时
    _timer_five_minutes?.cancel();
    if (_isEnable(2)) {
      //每5分钟调用一次
      _timer_five_minutes =
          Timer.periodic(const Duration(seconds: 360), (Timer timer) {
        //再次检查一下
        if (_isEnable(2)) {
          //弹出奖品3
          //调用接口
          showRewardTimeDialog();
        } else {
          _timer_five_minutes?.cancel();
        }
      });
    }
  }

  static void userBalanceChangeStop() {
    //debugPrint('CheckPdd--- userBalanceChangeStop -- ${_isEnable()}');
    //取消之前的倒计时
    _timer_five_minutes?.cancel();
  }

  //用户在一个主播页面停留超过90秒，弹出主播 aib，点击接听后充值  (不用判断是否是新用户)
  static openAnchorDetail(Function() getHostDetail) {
    // debugPrint('CheckPdd--- openAnchorDetail -_isEnable- ${_isEnable(isEnableUser: false)}');
    _timer_90_seconds?.cancel();
    _timer_90_seconds = null;

    if (_isEnable(3, isEnableUser: false)) {
      //每90秒调用一次
      _timer_90_seconds =
          Timer.periodic(const Duration(seconds: 90), (Timer timer) async {
        //再次检查一下，判断当前是否可以进行aib呼叫 并且没有正在通话,判断是否在当前界面
        //判断当前是否有体验卡  1 有体验卡，判断主播状态 2。 没有体验卡 判断余额，
        if ((UserInfo.to.myDetail?.callCardCount ?? 0) > 0) {
          // debugPrint('CheckPdd--- openAnchorDetail - start');
          HostDetail? hostDetail = await getHostDetail();
          if (hostDetail == null) {
            _timer_90_seconds?.cancel();
            return;
          }
          // debugPrint('CheckPdd--- openAnchorDetail - callCardCount>0');
          if (hostDetail.isShowOnline &&
              AppCheckCallingUtil.checkCanAib() &&
              !AppCheckCallingUtil.checkCalling() &&
              Get.currentRoute == AppPages.anchorDetails) {
            //debugPrint('CheckPdd--- openAnchorDetail -- start');
            RemoteLogic.startMeAib(hostDetail.userId!, json.encode(hostDetail));
          } else {
            // debugPrint('CheckPdd--- openAnchorDetail -- cancel');
            _timer_90_seconds?.cancel();
          }
        } else if (_isEnable(3, isEnableUser: false) &&
            AppCheckCallingUtil.checkCanAib() &&
            !AppCheckCallingUtil.checkCalling() &&
            Get.currentRoute == AppPages.anchorDetails) {
          HostDetail? hostDetail = await getHostDetail();
          //  debugPrint('CheckPdd--- openAnchorDetail - start');
          if (hostDetail == null) {
            _timer_90_seconds?.cancel();
            return;
          }
          //再次通过当前主播的钻石进行对比,看是否可以启用
          if (_isEnableForAnchorDiamonds(hostDetail.charge ?? 60)) {
            RemoteLogic.startMeAib(hostDetail.userId!, json.encode(hostDetail));
          } else {
            _timer_90_seconds?.cancel();
          }
        } else {
          // debugPrint('CheckPdd--- openAnchorDetail -- cancel');
          _timer_90_seconds?.cancel();
        }
      });
    }
  }

  //关闭详情
  static void closeAnchorDetail() {
    // debugPrint('CheckPdd--- closeAnchorDetail -- ${_isEnable()}');
    _timer_90_seconds?.cancel();
    _timer_90_seconds = null;
  }
}
