import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/reward_dialog/reward_coupon_dialog.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/pages/call/remote/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_check_calling_util.dart';

import 'reward_diamond_dialog.dart';
import 'reward_time_dialog.dart';

//拼多多砍一刀
class Pdd2 {
  //充值框显示次数
  static const _sp_topupbox_show_quantity = 'sp_topupbox_show_quantity';

  //支付弹框显示次数
  static const _sp_paymentbox_show_quantity = 'sp_paymentbox_show_quantity';

  //第三个弹框的计时器
  static Timer? _timer_pdd3_minutes;

  //主播界面停留秒数计时器
  static Timer? _timer_aib_seconds;

  //获取对应的配置pddDialogDisplay
  // 第一个参数：是否开启中奖商品1 0 代表关闭 1代表开启
  // 第二个参数：是否开启中奖商品2 0代表关闭 1代表开启
  // 第三个参数：是否开启中奖商品3 0 代表关闭 1代表开启
  // 第四个参数：是否开启再主播界面的倒计时aib 0 代表关闭 1代表开启 （以前版本需要，做兼容处理）
  // 第五个参数：商品弹窗弹出几次，出现中奖商品1
  // 第六个参数：支付渠道弹窗出现几次，出现中奖商品2
  // 第七个参数：每循环多少秒，出现中奖商品3
  // 第八个参数：主播界面停留多少秒出现aib
  //type： 0 第一个中奖商品是否显示  1 第二个中奖商品是否显示  2 第三个中奖商品是否显示
  static String getPddDialogDisplayConfig(int type) {
    var pddDialogIsShowList = UserInfo.to.config?.pddDialogDisplay?.split(",");
    var pddDialogIsShow = "";
    if (pddDialogIsShowList != null && pddDialogIsShowList.length > type) {
      pddDialogIsShow = pddDialogIsShowList[type];
    }
    return pddDialogIsShow;
  }

  //获取对应type类型拿到的配置
  //0 商品弹窗弹出几次，出现中奖商品1
  //1 支付渠道弹窗出现几次，出现中奖商品2
  //2 每循环多少秒，出现中奖商品
  //3 主播界面停留多少秒出现aib
  static String getPddDialogConfigForType(int type) {
    var configValue = "";
    switch (type) {
      case 0:
        configValue = getPddDialogDisplayConfig(4);
        break;
      case 1:
        configValue = getPddDialogDisplayConfig(5);
        break;
      case 2:
        configValue = getPddDialogDisplayConfig(6);
        break;
      case 3:
        configValue = getPddDialogDisplayConfig(7);
        break;
      default:
        configValue = "";
        break;
    }
    return configValue;
  }

  //是否启用流程 type 当前第几个窗口
  static bool _isEnable(int type) {
    var pddDialogIsShow = "";
    if (type < 0) {
      pddDialogIsShow = "1";
    } else {
      //取对应弹框位置的配置
      pddDialogIsShow = getPddDialogDisplayConfig(type);
    }
    //KateLiveLog.debug("_isEnable-----pddDialogDisplay:type=$type pddDialogIsShow=$pddDialogIsShow");
    //配置一直显示或者没有启用新用户判断，则一直会按照逻辑显示
    if (pddDialogIsShow == "1") {
      return _isEnableForDiamonds() && _isEnableForUI(type);
    } else {
      return false;
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
    // debugPrint('CheckPdd--- openTopUpBoxShow');
    if (_isEnable(0)) {
      var newUpboxShowQuantity = (StorageService.to.prefs.getInt(
                  _sp_topupbox_show_quantity +
                      (UserInfo.to.userLogin?.userId ?? "")) ??
              0) +
          1;
      StorageService.to.prefs.setInt(
          _sp_topupbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          newUpboxShowQuantity);
      //debugPrint('CheckPdd--- openTopUpBoxShow -- newUpboxShowQuantity=$newUpboxShowQuantity');
    } else {
      //进行初始化
      StorageService.to.prefs.setInt(
          _sp_topupbox_show_quantity + (UserInfo.to.userLogin?.userId ?? ""),
          0);
    }
  }

  // 点击了渠道进行支付，这个情况下，关闭充值弹框后不用弹出中奖商品
  static bool _stopPdd2 = false;

  //点击了渠道进行支付，这个情况下，关闭充值弹框之前减去1次
  static Future<bool> paymentBoxGoPay() {
    _stopPdd2 = true;
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
    //debugPrint('CheckPdd--- topUpBoxClose ${_isEnable(0)}');
    if (_isEnable(0)) {
      //debugPrint('CheckPdd--- topUpBoxClose_isEnable ${_isEnable(0)}');

      var frequency = 5;
      try {
        frequency = int.parse(getPddDialogConfigForType(0));
      } catch (e) {
        frequency = 5;
      }

      //是否显示中奖
      var isShowPrize = ((StorageService.to.prefs.getInt(
                      _sp_topupbox_show_quantity +
                          (UserInfo.to.userLogin?.userId ?? "")) ??
                  0) %
              frequency) ==
          0;
      //debugPrint('CheckPdd--- topUpBoxClose -- isShowPrize=$isShowPrize');
      if (isShowPrize) {
        //调用接口
        //  debugPrint("CheckPdd---showRewardDiamondDialog");
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
    if (_stopPdd2) {
      _stopPdd2 = false;
      return;
    }
    if (_isEnable(1)) {
      //是否显示中奖 默认循环3次弹出中奖
      var frequency = 3;
      try {
        frequency = int.parse(getPddDialogConfigForType(1));
      } catch (e) {
        frequency = 3;
      }

      //是否显示中奖
      var isShowPrize = ((StorageService.to.prefs.getInt(
                      _sp_paymentbox_show_quantity +
                          (UserInfo.to.userLogin?.userId ?? "")) ??
                  0) %
              frequency) ==
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
    _timer_pdd3_minutes?.cancel();
    if (_isEnable(2)) {
      //获取第三个弹框的配置，停留多少秒出现中奖商品，默认360秒
      var seconds = 360;
      try {
        seconds = int.parse(getPddDialogConfigForType(2));
      } catch (e) {
        seconds = 360;
      }

      //每5分钟调用一次
      _timer_pdd3_minutes =
          Timer.periodic(Duration(seconds: seconds), (Timer timer) {
        //再次检查一下
        if (_isEnable(2)) {
          //弹出奖品3
          //调用接口
          showRewardTimeDialog();
        } else {
          // _timer_pdd3_minutes?.cancel();
        }
      });
    }
  }

  static void userBalanceChangeStop() {
    //debugPrint('CheckPdd--- userBalanceChangeStop -- ${_isEnable()}');
    //取消之前的倒计时
    _timer_pdd3_minutes?.cancel();
  }

  //用户在一个主播页面停留超过90秒，弹出主播 aib，点击接听后充值  (不用判断是否是新用户)
  static openAnchorDetail(Function() getHostDetail) {
    // debugPrint('CheckPdd--- openAnchorDetail -_isEnable- ${_isEnable(isEnableUser: false)}');
    _timer_aib_seconds?.cancel();
    _timer_aib_seconds = null;

    if (_isEnable(3)) {
      var seconds = 90;
      try {
        seconds = int.parse(getPddDialogConfigForType(3));
      } catch (e) {
        seconds = 90;
      }
      //每90秒调用一次
      _timer_aib_seconds =
          Timer.periodic(Duration(seconds: seconds), (Timer timer) async {
        //再次检查一下，判断当前是否可以进行aib呼叫 并且没有正在通话,判断是否在当前界面
        //判断当前是否有体验卡  1 有体验卡，判断主播状态 2。 没有体验卡 判断余额，
        if ((UserInfo.to.myDetail?.callCardCount ?? 0) > 0) {
          // debugPrint('CheckPdd--- openAnchorDetail - start');
          HostDetail? hostDetail = await getHostDetail();
          if (hostDetail == null) {
            _timer_aib_seconds?.cancel();
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
            _timer_aib_seconds?.cancel();
          }
        } else if (_isEnable(3) &&
            AppCheckCallingUtil.checkCanAib() &&
            !AppCheckCallingUtil.checkCalling() &&
            Get.currentRoute == AppPages.anchorDetails) {
          HostDetail? hostDetail = await getHostDetail();
          //  debugPrint('CheckPdd--- openAnchorDetail - start');
          if (hostDetail == null) {
            _timer_aib_seconds?.cancel();
            return;
          }
          //再次通过当前主播的钻石进行对比,看是否可以启用
          if (_isEnableForAnchorDiamonds(hostDetail.charge ?? 60)) {
            RemoteLogic.startMeAib(hostDetail.userId!, json.encode(hostDetail));
          } else {
            _timer_aib_seconds?.cancel();
          }
        } else {
          // debugPrint('CheckPdd--- openAnchorDetail -- cancel');
          _timer_aib_seconds?.cancel();
        }
      });
    }
  }

  static void closeAnchorDetail() {
    //KateLiveLog.debug('KateLiveCheckPdd--- closeAnchorDetail -- ${_isEnable(3)}');
    _timer_aib_seconds?.cancel();
    _timer_aib_seconds = null;
  }
}
