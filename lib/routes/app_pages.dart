import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/anchor_detail/contribute_list/index.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/moment_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/more_moment_list/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/media/index.dart';
import 'package:oliapro/pages/call/aiv/index.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/pages/call/connect/index.dart';
import 'package:oliapro/pages/call/end/index.dart';
import 'package:oliapro/pages/call/local/index.dart';
import 'package:oliapro/pages/call/remote/index.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/pages/init/account/cache/index.dart';
import 'package:oliapro/pages/init/account/login/index.dart';
import 'package:oliapro/pages/init/login/index.dart';
import 'package:oliapro/pages/init/splash/index.dart';
import 'package:oliapro/pages/main/home/follow/index.dart';
import 'package:oliapro/pages/main/main/index.dart';
import 'package:oliapro/pages/main/match/matching/index.dart';
import 'package:oliapro/pages/main/me/about/index.dart';
import 'package:oliapro/pages/main/me/blacklist/index.dart';
import 'package:oliapro/pages/main/me/calllist/index.dart';
import 'package:oliapro/pages/main/me/cardlist/index.dart';
import 'package:oliapro/pages/main/me/change_password/index.dart';
import 'package:oliapro/pages/main/me/delete_account/index.dart';
import 'package:oliapro/pages/main/me/info/index.dart';
import 'package:oliapro/pages/main/me/invite_code/index.dart';
import 'package:oliapro/pages/main/me/lottery/index.dart';
import 'package:oliapro/pages/main/me/moment_list/index.dart';
import 'package:oliapro/pages/main/me/orderlist/order_detail/binding.dart';
import 'package:oliapro/pages/main/me/orderlist/order_detail/view.dart';
import 'package:oliapro/pages/main/me/orderlist/tab/order_tab.dart';
import 'package:oliapro/pages/main/me/orderlist/tab/order_tab_binding.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';
import 'package:oliapro/pages/main/me/reward_details/index.dart';
import 'package:oliapro/pages/main/me/share/index.dart';
import 'package:oliapro/pages/main/me/to_vip/index.dart';
import 'package:oliapro/pages/main/public/index.dart';
import 'package:oliapro/pages/report/index.dart';
import 'package:oliapro/pages/some/web_page.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/cache/login_cache.dart';

import '../pages/main/me/setting/index.dart';
import 'app_observers.dart';

class AppPages {
  // 这个字段决定app现在是否在后台
  static bool isAppBackground = false;

  static final RouteObserver<Route> observer = AppRouteObservers();
  static List<String> history = [];
  static const initial = '/splash';
  static const login = '/sign_in';
  static const accountLogin = '/account/login';
  static const accountCache = '/account/cache';
  static const main = '/main';
  static const chatPage = '/chatPage';
  static const callCome = '/callCome';
  static const callOut = '/callOut';
  static const call = '/call';
  static const callEnd = '/callEnd';
  static const aicPage = '/aicPage';
  static const edit = '/edit';
  static const setting = '/setting';
  static const aboutUs = '/aboutUs';
  static const toVip = '/toVip';
  static const blackList = '/blackList';
  static const test = '/test';
  static const callList = '/callList';
  static const matchingPage = '/matchingPage';
  static const webPage = '/webPage';
  static const prop = '/prop';
  static const orderTab = '/orderTab';
  static const orderDetail = '/orderDetail';
  static const matchBubble = '/matchBubble';
  static const anchorVideos = '/anchorVideos';
  static const createMoment = '/createMoment';
  static const myMoment = '/myMoment';
  static const moreMoment = '/moreMoment';
  static const momentDetail = '/moreMomentDetail';
  static const medias = '/medias';
  static const aivPage = '/aivPage';
  static const game = '/game';
  static const report = '/report';
  static const recharge = '/recharge';
  static const lottery = '/lottery';
  static const share = '/share';
  static const inviteCode = '/inviteCode';
  static const public = '/public';
  static const anchorDetails = '/anchorDetails';
  static const rewardDetails = '/rewardDetails';
  static const changePassword = '/changePassword';
  static const follow = '/follow';
  static const contributeList = '/contributeList';
  static const connectFailed = '/connectFailed';
  static const deleteAccount = '/deleteAccount';
  static const matching = '/matching';

  static final List<GetPage> routes = [
    GetPage(
      name: matching,
      page: () => const MatchingPage(),
      binding: MatchingBinding(),
    ),

    GetPage(
      name: contributeList,
      page: () => const ContributeListPage(),
      binding: ContributeListBinding(),
    ),

    GetPage(
      name: deleteAccount,
      page: () => const DeleteAccountPage(),
      binding: DeleteAccountBinding(),
    ),

    GetPage(
      name: connectFailed,
      page: () => const ConnectFailedPage(),
      binding: FailBinding(),
    ),

    GetPage(
      name: medias,
      page: () => const MediasPage(),
      binding: MediasBinding(),
    ),

    GetPage(
      name: momentDetail,
      page: () => const MomentDetailPage(),
      binding: MomentDetailBinding(),
    ),

    GetPage(
      name: moreMoment,
      page: () => const MoreDynamicPage(),
      binding: MoreDynamicBinding(),
    ),

    GetPage(
      name: follow,
      page: () => const FollowPage(),
      binding: FollowBinding(),
    ),

    GetPage(
      name: accountLogin,
      page: () => const AccountLoginPage(),
      binding: AccountLoginBinding(),
    ),

    GetPage(
      name: accountCache,
      page: () => const AccountCachePage(),
      binding: AccountCacheBinding(),
    ),

    GetPage(
      name: report,
      page: () => const ReportPage(),
      binding: ReportBinding(),
    ),

    GetPage(
      name: toVip,
      page: () => const ToVipPage(),
      binding: ToVipBinding(),
    ),

    GetPage(
      name: setting,
      page: () => const SetPage(),
      binding: SetBinding(),
    ),

    GetPage(
      name: aboutUs,
      page: () => const AboutPage(),
      binding: AboutBinding(),
    ),

    GetPage(
      name: lottery,
      page: () => const LotteryPage(),
      binding: LotteryBinding(),
    ),

    GetPage(
      name: webPage,
      page: () => WebPage(),
    ),

    GetPage(
      name: blackList,
      page: () => const BlackPage(),
      binding: BlackBinding(),
    ),

    GetPage(
      name: edit,
      page: () => const EditPage(),
      binding: EditBinding(),
    ),

    GetPage(
      name: recharge,
      page: () => const RechargePage(),
      binding: RechargeBinding(),
    ),

    GetPage(
      name: prop,
      page: () => const PropPage(),
      binding: PropBinding(),
    ),

    GetPage(
      name: myMoment,
      page: () => const DynamicPage(),
      binding: DynamicBinding(),
    ),

    GetPage(
      name: callList,
      page: () => const ChatRecordPage(),
      binding: RecordBinding(),
    ),

    GetPage(
      name: share,
      page: () => const SharePage(),
      binding: ShareBinding(),
    ),

    GetPage(
      name: inviteCode,
      page: () => const InviteCodePage(),
      binding: InviteCodeBinding(),
    ),

    GetPage(
      name: public,
      page: () => const PublicPage(),
      binding: PublicBinding(),
    ),

    GetPage(
      name: anchorDetails,
      page: () => const AnchorDetailPage(),
      binding: AnchorDetailBinding(),
    ),

    GetPage(
      name: callCome,
      page: () => const RemotePage(),
      binding: RemoteBinding(),
    ),

    GetPage(
      name: callOut,
      page: () => const LocalPage(),
      binding: LocalBinding(),
    ),

    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: call,
      page: () => const CallPage(),
      binding: CallBinding(),
    ),

    GetPage(
      name: rewardDetails,
      page: () => const RewardDetailsPage(),
      binding: RewardDetailsBinding(),
    ),

    // 免登陆
    GetPage(
        name: initial,
        page: () => const SplashPage(),
        binding: SplashBinding()),

    GetPage(
      name: changePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),

    ///==========================================================================

    GetPage(
      name: chatPage,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),

    GetPage(
      name: callEnd,
      page: () => const EndPage(),
      binding: EndBinding(),
    ),

    GetPage(
      name: aivPage,
      page: () => const AivPage(),
      binding: AivBinding(),
    ),

    GetPage(
      name: orderTab,
      page: () => const OrderTab(),
      binding: OrderTabBinding(),
    ),

    GetPage(
      name: orderDetail,
      page: () => const OrderDetailPage(),
      binding: OrderDetailBinding(),
    ),

    // GetPage(
    //   name: anchorVideos,
    //   page: () => const AnchorVideosPage(),
    // ),
  ];

  /*static void logout() {
    // debugPrint('logout()');
    UserInfo.to.clear();
    UserInfo.to.setLogOut();
    //Get.offAllNamed(login);
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    AccountAPI.logOut();
    Get.offAllNamed(initial);
  }*/

  static toDeleteAccount() async {
    await LoginCache.cleanAll();
    UserInfo.to.clearVisitor();
    UserInfo.to.toDeleteLogOut();
  }

  static void closeDialog() {
    /// 关闭弹窗
    if (Get.isOverlaysOpen) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!Get.isDialogOpen! && !Get.isBottomSheetOpen!);
      });
    }
  }

  static const rewardCouponDialog = 'reward_coupon_dialog';
  static const rewardDiamondDialog = 'reward_diamond_dialog';
  static const rewardTimeDialog = 'reward_time_dialog';

  static const transferAppSheet = 'transfer_app_sheet';

  static const logoutDialog = 'logout_dialog';

  static const giftBottomSheet = 'gift bottomSheet';

  static const cancelCallConnectingDialog = 'cancel_call_connecting_dialog';
  static const cancelAivConnectingDialog = 'cancel_aiv_connecting_dialog';

  static const selectAreaDialog = 'select_area_dialog';

  static const reportSheet = 'report sheet';

  static const drawResultDialog = 'draw_result_dialog';

  static const aiHelpSheet = 'ai_help_sheet';

  static const rechargeChannelSheet = 'recharge channel sheet';

  static const vipRechargeSheet = 'vip_recharge_sheet';

  static const setPassWordSheet = 'set_pass_word_sheet';

  static const selectAreaSheet = 'select_area_sheet';

  static const toInviteSheet = 'to_invite_sheet';

  static const chatMoreSheet = 'chat_more_sheet';

  static const editIntroSheet = 'edit_intro_sheet';

  static const editNameSheet = 'edit_name_sheet';

  static const msgMoreSheet = 'msg_more_sheet';

  static const searchSheet = 'search_sheet';
  static const selectGenderSheet = 'select_gender_sheet';
  static const hostOptionSheet = 'host_option_sheet';
  static const bindGoogleDialog = 'bind google dialog';

  static const selectSexDialog = 'select_sex_dialog';

  static const changePsdDialog = 'change_password_dialog';

  static const saveAccountDialog = 'save account png dialog';

  static const blackDialog = 'to_black_dialog';

  static const toComplianceDialog = 'to_compliance_dialog';

  static const hangUpCallDialog = 'hang_up_call_dialog';

  static const closeRemoteDialog = 'close_remote_dialog';

  static const deleteAccountDialog = 'delete_account_dialog';

  static const freeDiamondDialog = 'free_diamond_dialog';

  static const loginAgreeDialog = 'login_agree_dialog';
  static const rtmConfirmDialog = 'rtm_confirm_dialog';
  static const newUserDialog = 'new_user_dialog';
  static const warmTipDialog = 'warm_tip_dialog';

  static const signDialog = 'sign_dialog';

  static const vipOnlineDialog = 'vip_online_dialog';

  static const signRewardDialog = 'sign_reward_dialog';
  static const freeDiamondTipDialog = 'free_diamond_tip_dialog';

  static const googleRateSheet = 'google_rate_sheet';

  static const vipGetDialog = 'vip_get_dialog';

  static const appUpdateDialog = 'app_update_dialog';

  static const homeQuickRechargeDialog = 'home quick recharge dialog';
}
