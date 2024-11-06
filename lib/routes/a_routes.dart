import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/dialogs/sheet_transfer_app.dart';
import 'package:nyako/entities/app_aiv_entity.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/entities/app_host_match_limit_entity.dart';
import 'package:nyako/entities/app_moment_entity.dart';
import 'package:nyako/entities/app_order_entity.dart';
import 'package:nyako/pages/call/aiv/widget/aiv_video_controller.dart';
import 'package:nyako/pages/some/web_page.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/observer/route_extend.dart';
import 'package:nyako/utils/app_permission_handler.dart';

class ARoutes {
  static bool get isRechargeDialog =>
      Get.currentRoute.startsWith(AppPages.homeQuickRechargeDialog);

  ///当前页面是否是动态详情
  static bool get isMomentDetail =>
      Get.currentRoute.startsWith(AppPages.momentDetail);

  ///当前页面是否是被叫页面
  static bool get isBeCall => Get.currentRoute.startsWith(AppPages.callCome);

  ///当前页面是否是Main页面
  static bool get isMainPage => Get.currentRoute.startsWith(AppPages.main);

  ///当前页面是否是登录页面
  static bool get isLoginPage => Get.currentRoute.startsWith(AppPages.login);

  ///当前页面是否是充值页面
  static bool get isRecharge => Get.currentRoute.startsWith(AppPages.recharge);

  ///当前页面是否是聊天页面
  static bool get isChat => Get.currentRoute.startsWith(AppPages.chatPage);

  ///当前页面是否是匹配结果dialog
  static bool get isMatchResult => AppConstants.isMatching;

  ///当前页面是否是VIP dialog
  static bool get isVIPDialog => AppConstants.isVIPPay;

  ///当前页面是否是渠道支付
  static bool get isChannelPay => AppConstants.isChannelPay;

  ///当前页面是否是渠道支付
  static bool get isQuickPay => AppConstants.isQuickPay;

  ///当前页面是否是抽奖页面
  static bool get isLottery => Get.currentRoute.startsWith(AppPages.lottery);

  ///当前页面是否是结算页面
  static bool get isSettlement => Get.currentRoute.startsWith(AppPages.callEnd);

  ///当前页面是否是呼叫页面
  static bool get isCalling => Get.currentRoute.startsWith(AppPages.call);

  ///当前页面是否是主播视频页面
  static bool get isAnchorVideo =>
      Get.currentRoute.startsWith(AppPages.anchorVideos);

  ///当前页面是否是主播详情
  static bool get isAnchorDetails =>
      Get.currentRoute.startsWith(AppPages.anchorDetails);

  ///当前页面是否是举报(用于视频通话)
  static bool get isReport => Get.currentRoute.startsWith(AppPages.report);

  ///当前页面是否是视屏通话页面
  static bool get isAivPage => Get.currentRoute.startsWith(AppPages.aivPage);

  ///splash
  static offSplash() => Get.offNamed(AppPages.initial);

  ///web
  static toWeb(String url, bool fullScreen) => WebPage.startMe(url);

  ///隐私协议
  static toPolicy() => WebPage.startMe(AppConstants.privacyPolicy);

  ///条款协议
  static toAgreement() => WebPage.startMe(AppConstants.agreement);

  ///举报
  static toReport(
      {String? uid,
      String? channelID,
      String? index,
      String? type,
      String? mid}) {
    Map<String, String> map = {};
    if (uid != null) {
      map['upid'] = uid;
    }
    if (channelID != null) {
      map['channelid'] = channelID;
    }
    if (index != null) {
      map['index'] = index;
    }
    if (type != null) {
      map['type'] = type;
    }
    if (mid != null) {
      map['mid'] = mid;
    }
    if (uid == null) {
      Get.toNamed(AppPages.report);
    } else {
      Get.toNamed(AppPages.report, parameters: map);
    }
  }

  ///用户编辑
  static toUserEdit() => Get.toNamed(AppPages.edit);

  ///用户编辑
  static toSetting() => Get.toNamed(AppPages.setting);

  ///拉黑
  static toBlack() => Get.toNamed(AppPages.blackList);

  ///关于
  static toAbout() => Get.toNamed(AppPages.aboutUs);

  ///删除账号
  static toDeleteAccount() => Get.toNamed(AppPages.deleteAccount);

  ///修改密码
  static toChangePsd() => Get.toNamed(AppPages.changePassword);

  ///分享
  static toShare() => Get.toNamed(AppPages.share);

  ///充值vip
  static toRechargeVip() => Get.toNamed(AppPages.toVip);

  static offAndToShare() => Get.offAndToNamed(AppPages.share);

  ///用户动态
  static toUserDynamic() => Get.toNamed(AppPages.myMoment);

  ///发布动态
  static toPublicDynamic() => Get.toNamed(AppPages.public);

  ///充值
  static toRecharge() => Get.toNamed(AppPages.recharge);

  ///道具列表
  static toPropList() => Get.toNamed(AppPages.prop);

  ///订单列表
  static toOrderList() => Get.toNamed(AppPages.orderTab);

  ///聊天记录
  static toChatRecord() => Get.toNamed(AppPages.callList);

  ///账户登录
  static toAccountLogin() => Get.toNamed(AppPages.accountLogin);

  ///缓存账户登录
  static toCacheAccountLogin() => Get.toNamed(AppPages.accountCache);

  ///抽奖
  static toLottery({int num = 0}) =>
      Get.toNamed(AppPages.lottery, arguments: [num]);

  ///主页
  static offAndToMain() => Get.offAndToNamed(AppPages.main);

  ///登录
  static offAndToLogin() => Get.offAndToNamed(AppPages.login);

  ///贡献榜单
  static toContributeList(
          {required String anchorId, required HostDetail host}) =>
      Get.toNamed(AppPages.contributeList,
          arguments: {'herId': anchorId, "host": host});

  ///主播更多动态
  static toMoreMoment({required String anchorId}) =>
      Get.toNamed(AppPages.moreMoment, arguments: {'herId': anchorId});

  ///主播视频
  static toAnchorVide(HostDetail mo) =>
      Get.toNamed(AppPages.anchorVideos, arguments: mo);

  ///动态详情
  static toMomentDetail({required MomentDetail data, int index = 0}) =>
      Get.toNamed(AppPages.momentDetail,
          arguments: {'momentDetail': data, 'index': index});

  ///链接失败
  static toConnectFailed({required String anchorPortrait}) =>
      Get.toNamed(AppPages.connectFailed, arguments: {
        'anchorPortrait': anchorPortrait,
      });

  ///奖励明细
  static toRewardDetails({bool type = true}) =>
      Get.toNamed(AppPages.rewardDetails, arguments: [type]);

  ///(视频/图片)资源
  static toMedias({bool type = true}) => Get.toNamed(AppPages.medias);

  ///账户注册
  static toFollow() => Get.toNamed(AppPages.follow);

  ///邀请码
  static toInviteCode(String? inviteCode, bool diff) {
    Get.toNamed(AppPages.inviteCode, arguments: [inviteCode, diff]);
  }

  ///呼叫
  static toCalling({String? anchorId, String? portrait}) {
    if (anchorId == null) return;
    Map<String, dynamic> map = {};
    map['herId'] = anchorId;
    map['portrait'] = portrait;
    Get.toNamed(AppPages.callOut, arguments: map);
  }

  static toMatching({HostMatchLimitEntityAnchor? anchor}) =>
      Get.toNamed(AppPages.matching, arguments: anchor);

  ///订单详情
  static toOrderDetail(OrderData data) =>
      Get.toNamed(AppPages.orderDetail, arguments: [data]);

  ///聊天页面
  static toChat(String uid) => Get.toNamed(AppPages.chatPage, arguments: uid);

  ///主播详情
  static toAnchorDetail(String? anchorId) {
    if (anchorId != null) {
      Get.toNamed(AppPages.anchorDetails, arguments: [int.parse(anchorId)]);
    }
  }

  ///结算页面
  static toSettlement(
      {required String herId,
      required String channelId,
      required String portrait,
      required int endType,
      required int callType,
      required int callTime,
      HostDetail? detail,
      bool? useCard,
      bool? callHadShowCount20,
      int? giftValue}) {
    Map<String, dynamic> map = {};
    map['herId'] = herId;
    map['channelId'] = channelId;
    map['portrait'] = portrait;
    map['endType'] = endType;
    map['callType'] = callType;
    map['callTime'] = callTime;
    map['detail'] = detail;
    map['useCard'] = useCard;
    map['callHadShowCount20'] = callHadShowCount20;
    map['giftValue'] = giftValue;
    Get.toNamed(AppPages.callEnd, arguments: map);
  }

  static Future<T?>? toChatPage<T>(String herId,
      {HostDetail? detail,
      bool closeSelf = false,
      String openGiftDialog = "false"}) {
    if (closeSelf) {
      return Get.offNamed(AppPages.chatPage,
          arguments: detail ?? herId,
          parameters: {"openGiftDialog": openGiftDialog, "tag": herId});
    } else {
      return Get.toNamed(AppPages.chatPage,
          arguments: detail ?? herId,
          parameters: {"openGiftDialog": openGiftDialog, "tag": herId});
    }
  }

  static toLocalCall(String herId, String? portrait, {bool closeSelf = false}) {
    //获取到权限再去拨打页面
    AppPermissionHandler.checkCallPermission().then((value) {
      if (!value) return;
      Map<String, dynamic> map = {};
      map['herId'] = herId;
      map['portrait'] = portrait;
      if (closeSelf) {
        Get.offNamed(AppPages.callOut, arguments: map);
      } else {
        Get.toNamed(AppPages.callOut, arguments: map);
      }
    });
  }

  static toAivPage(String herId, int isCard, AivBean aiv,
      {AivVideoController? aivVideoController}) {
    Map<String, dynamic> map = {};
    map['herId'] = herId;
    map['isCard'] = isCard;
    map['aiv'] = aiv;
    // map['aivVideoController'] = aivVideoController;
    Get.offAndToNamed(AppPages.aivPage, arguments: map);
  }

  static removeB() => Get.removeName("ARoutes.mine");

  static removeAllA() => Get.removeAllName("ARoutes.mine");

  static bool isRewardDiamondDialog() =>
      Get.containName(AppPages.rewardDiamondDialog);

  static bool isRewardCouponDialog() =>
      Get.containName(AppPages.rewardCouponDialog);

  static bool isRewardTimeDialog() =>
      Get.containName(AppPages.rewardTimeDialog);

  static bool isShowReward() => (isRewardDiamondDialog() ||
      isRewardCouponDialog() ||
      isRewardTimeDialog());

  static openTransferAppDialog() => showTransferAppSheet();
  static closeTransferAppDialog() => Get.removeName(AppPages.transferAppSheet);

  static bool get isVipPage => Get.currentRoute.contains(AppPages.toVip);
  static bool get isLogoutDialog =>
      Get.currentRoute.contains(AppPages.logoutDialog);

  static removeConnectFailed() => Get.removeAllName(AppPages.connectFailed);
}
