import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/agora/rtm_msg_entity.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/charge/charge_success.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/cache/login_cache.dart';
import 'package:oliapro/widget/gift/app_gift_data_helper.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../entities/app_info_entity.dart';
import '../routes/app_pages.dart';
import '../services/app_info_service.dart';
import '../services/event_bus_bean.dart';
import '../services/storage_service.dart';
import '../services/user_info.dart';
import 'socket_entity.dart';

class AppSocketManager extends GetxService {
  static AppSocketManager get to => Get.find<AppSocketManager>();
  IOWebSocketChannel? channel;
  Timer? _timer;
  bool _connected = false;

  static bool get isiInitialized => AppSocketManager.to.initialized;

  Future<AppSocketManager> init() async {
    if (AppConstants.isFakeMode) {
      // AppLog.debug('isFakeMode 不初始化');
      return this;
    }
    Map<String, dynamic> headers = {};
    AppInfoService appInfo = AppInfoService.to;
    String userAgent =
        "${appInfo.channel},${appInfo.version},${appInfo.deviceModel},${appInfo.appSystemVersionKey},${appInfo.channelName},${appInfo.buildNumber}";
    headers["User-Agent"] = userAgent;
    // 这个socket框架自己往user-agent里面放东西，所以用了其他的字段放我们的
    headers["flutter-user-agent"] = userAgent;
    headers["user-id"] = UserInfo.to.userLogin?.userId ?? "";
    headers["user-language"] = Get.deviceLocale?.languageCode ?? "en";
    headers["device-id"] = appInfo.deviceIdentifier;
    //AppLog.debug("socket connecting");
    channel = IOWebSocketChannel.connect(NetPath.getSocketBaseUrl(),
        headers: headers, pingInterval: const Duration(seconds: 20));
    _connected = true;
    channel?.stream.listen((message) {
      // AppLog.debug(message);
      _handleMessage(message);
    }, onDone: () {
      // 发现在网络问题后，会走到这里
      // 有时网络问题，到了onDone。有时却onDone，onError一起调！！
      // AppLog.debug("socket connect onDone");
      _connected = false;
      reConnect();
    }, onError: (err) {
      // AppLog.debug("socket connect onError !!");
      _connected = false;
    }, cancelOnError: false);

    _timer = Timer.periodic(const Duration(milliseconds: 30000), (timer) async {
      if (AppPages.isAppBackground) return;
      if (_connected) {
        sendHeartbeat();
      } else {
        reConnect();
      }
    });
    return this;
  }

  void reConnect() {
    if (AppPages.isAppBackground) return;
    breakenSocket();
    _timer?.cancel();
    Future.delayed(const Duration(seconds: 2), () {
      if (UserInfo.to.myDetail == null) return;
      init();
    });
  }

  void sendHeartbeat() {
    //AppLog.debug('socket ------------> sendHeartbeat');
    Map heartbeat = {"optType": "heartbeat"};
    String heartbeatText = const JsonEncoder().convert(heartbeat);
    channel?.sink.add(heartbeatText);
  }

  //通知服务器用户进行了录屏操作 服务器下发logout操作并进行惩罚
  void sendScreenshots(String channelId) {
    Map heartbeat = {"optType": "screenshotPunish", "data": channelId};
    String heartbeatText = const JsonEncoder().convert(heartbeat);
    channel?.sink.add(heartbeatText);
  }

  //每次打开登录页面就会销毁当前链接 打开首页又会重新创建新的链接
  void breakenSocket() {
    if (isiInitialized) {
      channel?.sink.close(status.normalClosure);
      _timer?.cancel();
      //AppLog.debug('socket ------------> breakenSocket');
    }
  }

  void _handleMessage(String msg) {
    /// data字符窜有我们定义的消息
    SocketEntity entity = SocketEntity.fromJson(json.decode(msg));
    if (entity.optType == 'heartbeat') {
      return;
    }
    if (entity.optType == 'logout') {
      UserInfo.to.socketLogOut();
      return;
    }
    // 主播上线了
    if (entity.optType == 'anchorOnline') {
      return;
    }
    if (entity.data == null || entity.data!.isEmpty) {
      return;
    }
    var data = json.decode(entity.data!);
    switch (entity.optType) {
      // 主播状态
      case SocketHostState.typeCode:
        {
          SocketHostState entity = SocketHostState.fromJson(data);
          StorageService.to.eventBus.fire(entity);
        }
        break;
      // 余额变动
      /// 只要有余额变动就会发这个，rtm的27消息也一样
      case SocketBalance.typeCode:
        {
          SocketBalance entity = SocketBalance.fromJson(data);
          // print("SocketBalance====${entity}");
          var myDiamonds =
              UserInfo.to.myDetail?.userBalance?.remainDiamonds ?? 0;
          var changeState = -1;
          var newDiamonds = entity.diamonds;
          var price = UserInfo.to.config?.chargePrice ?? 60;
          // 我的钻石从60以上掉到60以下的情况
          if (myDiamonds >= price && newDiamonds < price) {
            // Http.instance.post(NetPath.initRobotApi);
            changeState = 1;
          } else if (myDiamonds < price && newDiamonds >= price) {
            // 我的钻石从60以下升高到到60以上的情况
            changeState = 0;
          }
          // 更新缓存信息
          UserInfo.to.handleBalanceChange(entity);

          if (changeState > -1) {
            StorageService.to.eventBus
                .fire(EventCanCallStateChange(changeState));
          }
          // 通知监听者
          for (var listener in _balanceListener) {
            listener.call(entity);
          }

          if (entity.diamonds > 0) {
            GiftDataHelper.checkGiftDownload();
          }
          AppEventBus.eventBus.fire(BalanceEvent(entity.diamonds));
          LoginCache.update(diamondCount: entity.diamonds.toString());
          StorageService.to.eventBus.fire(eventBusRefreshMe);
          StorageService.to.eventBus.fire(vipRefresh);
          PddUtil.instance.socketBalanceChange();
        }
        break;
      //
      case 'beginCall':
        {
          RTMMsgBeginCall entity = RTMMsgBeginCall.fromJson(data);
          StorageService.to.eventBus.fire(entity);
        }
        break;
      //
      case 'orderResult':
        {
          var jsonMap = json.decode(entity.data!);
          if (jsonMap['orderStatus'] == 1) {
            showRechargeSuccess(
                drawCount: jsonMap['drawCount'],
                diamonds: (jsonMap['diamonds']).toString(),
                isVipOrder: (jsonMap['productType'] == 3),
                isBot: true);
            // productType 1.普通商品，2.折扣商品，3.vip商品
            if (jsonMap['productType'] == 3) {
              UserInfo.to.myDetail?.isVip = 1;
              StorageService.to.eventBus.fire("vipRefresh");
              getUserInfo();
            }
            // 更新缓存信息
            UserInfo.to.saveHadCharge();
          }
        }
        break;
      case 'cardCountChanged':
        {
          // var jsonMap = json.decode(entity.data!);
          // print("cardCountChanged====${jsonMap}");
          var jsonMap = json.decode(entity.data!);
          // 体验卡数量变动
          if (jsonMap['callCardCount'] is int) {
            int newCardCount = jsonMap['callCardCount'];
            UserInfo.to.myDetail?.callCardCount = newCardCount;
            StorageService.to.eventBus.fire(EventCanCallStateChange(4));
            StorageService.to.eventBus.fire(eventBusRefreshMe);
          }
        }
        break;
    }
  }

  void getUserInfo() {
    Http.instance
        .post<InfoDetail>(NetPath.userInfoApi, errCallback: (err) {})
        .then((value) {
      UserInfo.to.setMyDetail = value;
      StorageService.to.eventBus.fire(eventBusRefreshMe);
    });
  }

  final List<AppCallback<SocketBalance>> _balanceListener = [];

  void addBalanceListener(AppCallback<SocketBalance> callback) {
    if (!_balanceListener.contains(callback)) {
      _balanceListener.add(callback);
    }
  }

  void removeBalanceListener(AppCallback<SocketBalance> callback) {
    _balanceListener.remove(callback);
  }
}
