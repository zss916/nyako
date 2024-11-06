import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/agora/rtm/rtm.dart';
import 'package:nyako/entities/app_info_entity.dart';
import 'package:nyako/entities/app_sign_card_entity.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/app_info_service.dart';
import 'package:nyako/services/event_bus_bean.dart';
import 'package:nyako/services/storage_service.dart';
import 'package:nyako/socket/app_socket_manager.dart';

import '../entities/app_config_entity.dart';
import '../entities/app_leval_entity.dart';
import '../entities/app_login_entity.dart';
import '../generated/json/base/json_convert_content.dart';
import '../socket/socket_entity.dart';

class UserInfo extends GetxService {
  static UserInfo get to => Get.find();
  static const userLoginData = 'userLoginData';
  String? authorization;
  ConfigData? config;

  LoginToken? token;
  String? enterTheSystem;
  LoginUser? userLogin;
  InfoDetail? _myDetail;

  String? get qr => config?.qrData;

  ///用户uid
  String get uid => _myDetail?.userId ?? "";

  ///vip每天获取的钻石
  String get vipDailyDiamonds => (config?.vipDailyDiamonds ?? 0).toString();

  ///用户是否是VIP
  bool get isUserVip => _myDetail?.isVip == 1;

  ///VIP 到期时间
  int get endTime => _myDetail?.vipEndTime ?? 0;

  ///用户头像
  String get userPortrait => _myDetail?.portrait ?? "";

  ///用户头像
  String get nickName => _myDetail?.nickname ?? "--";

  ///username
  String get username => _myDetail?.username ?? "0";

  ///用户VIP
  int get userVip => _myDetail?.isVip ?? 0;

  ///createdAt
  int get created => _myDetail?.created ?? 0;

  ///是否有authorization
  bool get hasAuthorization => authorization != null;

  ///是否有token
  bool get hasToken => token != null;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  setLogOutState() => _isLogin = false;

  ///设置登录成功
  setLoginState() => _isLogin = true;

  bool get isAppRelease => _myDetail?.isAppRelease ?? false;

  bool get isRenewVip => _myDetail?.isShowVipRenew() ?? false;

  List<LevalBean>? levalList;
  List<String>? sensitiveList;

  /// 当前正在和谁发消息
  String? chattingWithHer;

  RxInt msgUnreadNum = 0.obs;
  int rechargeClickCount = 1; // 快捷充值免费领钻石逻辑  弹出两次快捷充值弹窗，点击关闭按钮弹出免费领钻石弹窗

  ///用户聊天卡
  AppLiveSignCard? myMsgCard;

  ///是否使用聊天卡
  bool get isUseMsgCard => (myMsgCard != null &&
      (myMsgCard?.getRemainTimes() ?? 0) > 0 &&
      myMsgCard?.propStatus == 1);

  ///获取聊天卡的数量
  int getChatCardNum() => (myMsgCard == null) ? 0 : 1;

  ///签到头像
  AppLiveSignCard? signAvatar;

  ///是否有签到头像
  bool hasSignFrame = false;

  String? get transferInfo => config?.transferInfo;

  bool get isTransferApp => (config?.transferInfo != null);

  updateMessageUnRead(int num) =>
      StorageService.to.eventBus.fire(EventUnRead(num));

  ///获取聊天卡
  Future<void> getMsgCard() async {
    List<AppLiveSignCard> data = await CommonAPI.loadSignAvatar();
    List<AppLiveSignCard> msgCards = data
        .where((element) =>
            element.propType == 5 &&
            (element.propStatus == 1) &&
            (element.getRemainTimes() > 0))
        .toList();
    msgCards.sort((a, b) => a.getRemainTimes().compareTo(b.getRemainTimes()));
    if (msgCards.isNotEmpty) {
      myMsgCard = msgCards.last;
    }
  }

  ///触发获取签到头像(可用的)
  Future<void> getSignFrame() async {
    List<AppLiveSignCard> data = await CommonAPI.loadSignAvatar();
    List<AppLiveSignCard> signAvatars = data
        .where((element) =>
            element.propType == 6 &&
            element.propStatus == 1 &&
            element.getRemainTimes() > 0)
        .toList();
    hasSignFrame = signAvatars.isNotEmpty;

    ///按照时间排序
    signAvatars
        .sort((a, b) => a.getRemainTimes().compareTo(b.getRemainTimes()));
    if (signAvatars.isNotEmpty) {
      signAvatar = signAvatars.last;
    }
  }

  Future<UserInfo> init() async {
    String? str = StorageService.to.prefs.getString(userLoginData);
    if (str != null && str.isNotEmpty) {
      try {
        Login login = JsonConvert.fromJsonAsT<Login>(jsonDecode(str))!;
        setLoginData(login);
      } catch (e) {
        print(e);
      }
    }
    return this;
  }

  /// 获取用户信息内容
  String getAppUserInfo({int? aiType}) {
    var json = UserInfo.to.myDetail!.toJson();
    json['aiType'] = aiType ?? -1;
    String sendUserInfo = const JsonEncoder().convert(json);
    return sendUserInfo;
  }

  InfoDetail? get myDetail => _myDetail;

  set setMyDetail(InfoDetail value) {
    _myDetail = value;
  }

  int getLastShowLevel() {
    if (myDetail == null) {
      return 100;
    }
    return StorageService.to.prefs.getInt('${myDetail?.userId ?? ''}level') ??
        1;
  }

  void saveLastLevel(int level) {
    StorageService.to.prefs.setInt('${myDetail?.userId ?? ''}level', level);
  }

  void setVisitorPsdDialog(bool show) {
    StorageService.to.prefs
        .setBool('${myDetail?.userId ?? ''}visitor_dialog_show', show);
  }

  bool getVisitorPsdDialog() {
    return StorageService.to.prefs
            .getBool('${myDetail?.userId ?? ''}visitor_dialog_show') ??
        false;
  }

  ///记录登录次数
  void addLoginCount() {
    int num = getLoginCount() + 1;
    // debugPrint("count: => q$num,${'${myDetail?.userId ?? ''}login_count'}");
    StorageService.to.prefs.setInt('${myDetail?.userId ?? ''}login_count', num);
  }

  int getLoginCount() {
    return StorageService.to.prefs
            .getInt('${myDetail?.userId ?? ''}login_count') ??
        0;
  }

  ///是否显示合规
  bool get isShowCompliance => (getLoginCount() <= 3);

  // 收到socket余额变动消息
  void handleBalanceChange(SocketBalance entity) {
    // AppLog.debug('handleBalanceChange $entity');
    _myDetail?.userBalance?.remainDiamonds = entity.diamonds;
    _myDetail?.userBalance?.expLevel = entity.expLevel;
  }

  // 消耗体验卡后减去数量
  void subtractCard() {
    //  AppLog.debug('subtractCard ');
    var myCard = _myDetail?.callCardCount ?? 0;
    myCard -= 1;
    if (myCard < 0) return;
    _myDetail?.callCardCount = myCard;
  }

  // 登录后设置这个登录信息
  void setLoginData(Login theLogin) {
    token = theLogin.token;
    enterTheSystem = theLogin.enterTheSystem;
    userLogin = theLogin.user;
    authorization = token?.authorization;
    String str = jsonEncode(theLogin.toJson());
    StorageService.to.prefs.setString(userLoginData, str);
  }

  String? getLevelUrl() {
    if (config?.leveldetailurl == null || myDetail == null) {
      return null;
    }
    return '${config?.leveldetailurl}?areaCode=${myDetail?.areaCode ?? '1'}'
        '&expe=${myDetail?.userBalance?.expLevel ?? 0}'
        '&appName=${AppInfoService.to.channelName}';
  }

  LevalBean? getMyLevel() {
    if (levalList == null || levalList!.isEmpty || myDetail == null) {
      return null;
    }
    var myExp = myDetail!.userBalance?.expLevel ?? 0;
    LevalBean? bean;
    for (var element in levalList!) {
      if (myExp >= (element.howExp ?? 0)) {
        bean = element;
      }
    }
    return bean;
  }

  LevalBean? getLevel(int? exp) {
    if (levalList == null || levalList!.isEmpty || exp == null) {
      return null;
    }
    // var myExp = myDetail!.userBalance?.expLevel ?? 0;
    LevalBean? bean;
    for (var element in levalList!) {
      if (exp >= (element.howExp ?? 0)) {
        bean = element;
      }
    }
    return bean;
  }

  bool getIsHadCharge() {
    if (myDetail == null) {
      return false;
    }
    if ((myDetail?.userBalance?.totalRecharge ?? 0) > 0) {
      return true;
    }
    return StorageService.to.prefs
            .getBool('${myDetail?.userId ?? ''}hadCharge') ??
        false;
  }

  void saveHadCharge() {
    StorageService.to.prefs.setBool('${myDetail?.userId ?? ''}hadCharge', true);
  }

  void setVisitorPassword(String password) {
    StorageService.to.prefs.setString('visitor_password', password);
  }

  String getVisitorPassword() {
    return StorageService.to.prefs.getString('visitor_password') ?? '';
  }

  void setVisitorAccount(String account) {
    StorageService.to.prefs.setString('visitor_account', account);
  }

  String getVisitorAccount() {
    return StorageService.to.prefs.getString('visitor_account') ?? '';
  }

  void clear() {
    authorization = null;
    // config = null;
    token = null;
    enterTheSystem = null;
    userLogin = null;
    _myDetail = null;
    chattingWithHer = null;
    StorageService.to.prefs.setString(userLoginData, "");
  }

  void clearVisitor() {
    UserInfo.to.setVisitorAccount("");
    UserInfo.to.setVisitorPassword("");
  }

  Future<InfoDetail?> profile() async {
    if (!hasToken) return null;
    final info = await ProfileAPI.info();
    UserInfo.to.setMyDetail = info;
    _isLogin = true;
    return info;
  }

  ///登录确认
  bool check = false;

  void setCheck(bool check) {
    StorageService.to.prefs
        .setBool('${myDetail?.userId ?? ''}_login_check', check);
  }

  bool getCheck() {
    check = StorageService.to.prefs
            .getBool('${myDetail?.userId ?? ''}_login_check') ??
        false;
    return check;
  }

  ///重新登录(页面失效)
  void reLogin() {
    debugPrint("logout=>reLogin");
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    Get.offAllNamed(AppPages.initial);
  }

  ///重新账号登录
  void reAccountLogin() {
    debugPrint("logout=>reAccountLogin");
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    AccountAPI.logOut();
    Get.offAllNamed(AppPages.initial, arguments: true);
  }

  ///网络失效，退出登录
  void netLogOut() {
    debugPrint("logout=>netLogOut");
    //AccountAPI.logOut();
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    Get.offAllNamed(AppPages.initial);
  }

  ///socket 失效，退出登录
  void socketLogOut() {
    debugPrint("logout=>socketLogOut");
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    AccountAPI.logOut();
    Get.offAllNamed(AppPages.initial);
  }

  ///手动退出登录
  void toSetLogOut() {
    debugPrint("logout=>toSetLogOut");
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    AccountAPI.logOut();
    Get.offAllNamed(AppPages.initial);
  }

  ///删号退出登录
  void toDeleteLogOut() {
    debugPrint("logout=>toDeleteLogOut");
    UserInfo.to.setLogOutState();
    UserInfo.to.clear();
    Rtm.instance.closeIM();
    AppSocketManager.to.breakenSocket();
    AccountAPI.logOut();
    Get.offAllNamed(AppPages.initial);
  }

  int getAvatarType() {
    return StorageService.to.prefs
            .getInt('${myDetail?.userId ?? ''}_avatar_flame') ??
        0;
  }

  void setAvatarType(int type) {
    StorageService.to.prefs
        .setInt('${myDetail?.userId ?? ''}_avatar_flame', type);
  }

  ///测试
  var rtmConnect = false.obs;
  final rtmMsgs = RxList<String>([]);

  var localCall = "".obs;

  var remoteCall = "".obs;

  var rtcConnect = {}.obs;
  var rtcEnd = "".obs;
  final rtc = RxList<Map<String, dynamic>>([]);
}
