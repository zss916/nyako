import 'dart:async';

import 'package:get/get.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/charge/billing.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:oliapro/utils/cache/product_cache.dart';

import '../../entities/app_charge_quick_entity.dart';
import '../../entities/app_info_entity.dart';
import '../../services/user_info.dart';

class ChargeQuickController extends GetxController {
  static const idMoreList = 'idMoreList';
  bool googleOnly = true;
  PayQuickCommodite? choosedCommodite;

  PayQuickData? payQuickData;

  ///所有商品
  PayQuickCommodite? discountVip;

  ///限时VIP(1)
  List<PayQuickCommodite>? vipProducts;

  ///VIP 商品(2)
  PayQuickCommodite? discountProduct;

  ///折扣商品(3)
  List<PayQuickCommodite>? normalProducts;

  ///普通商品(4)

  DiamondCardBean? diamondCard;

  ///加成卡
  int get propDuration => diamondCard?.propDuration ?? 0;

  int left_time_inter = 0;
  var showMore = false;
  var createPath = '';
  String? upId;
  InfoDetail? myDetail;

  final googlePayType = 1;
  final applePayType = 2;

  // 缓存这个数据，2分钟内且没有点击支付用缓存，否则重新加载数据
  static const cacheTime = 2 * 60 * 1000;
  static int lastLoadTime = 0;
  static bool clickPay = false;
  late final StreamSubscription<String> vipSub;

  @override
  void onInit() {
    super.onInit();
    myDetail = UserInfo.to.myDetail;
    vipSub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == vipRefresh) {
        loadData();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    //AppTimeService.to.startCountDown = true;
    loadData();
  }

  @override
  void onClose() {
    vipSub.cancel();
    super.onClose();
  }

  void loadData() {
    Http.instance.post<PayQuickData>(
      '${NetPath.getCompositeProduct2}4',
      errCallback: (err) {
        AppLoading.toast(err.message);
      },
    ).then((value) {
      setData(value);
      clickPay = false;
      lastLoadTime = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Future<void> setData(PayQuickData newData) async {
    await ProductCache.matchDiamond(newData.normalProducts ?? []);
    payQuickData = newData;
    discountVip = newData.discountVip;
    vipProducts = newData.vipProducts;
    discountProduct = newData.discountProduct;
    normalProducts = newData.normalProducts;
    if (newData.normalProducts != null) {
      diamondCard = (newData.normalProducts ?? []).first.diamondCard;
    }
    update();
    _tryCorrectGooglePrice();
  }

  // 修正一下Google渠道的显示价格
  void _tryCorrectGooglePrice() {
    List<PayQuickCommodite> allList = [];

    if (discountVip != null) {
      allList.add(discountVip!);
    }

    if (vipProducts != null) {
      allList.addAll(vipProducts!);
    }

    if (normalProducts != null) {
      allList.addAll(normalProducts!);
    }
    if (discountProduct != null) {
      allList.add(discountProduct!);
    }

    for (var comm in allList) {
      if (comm.ppp != null) {
        for (var channel in comm.ppp!) {
          if (channel.ppType == googlePayType) {
            Billing.correctQuickGooglePrice(channel).then((value) {
              // 正在选择渠道的时候刷新页面
              if (value && choosedCommodite != null) {
                update();
              }
            });
            continue;
          }
        }
      }
    }
  }

  // 选择了一个商品，如果只有一个渠道直接支付，否则弹出渠道列表
  void chooseCommdite(PayQuickCommodite choosedCommodite,
      {String? createPath}) {
    this.choosedCommodite = choosedCommodite;
    doCharge(choosedCommodite, createPath: createPath);
  }

  // 支付
  void doCharge(PayQuickCommodite channel, {String? createPath}) {
    clickPay = true;
    createPay(channel, createPath: createPath);
  }

  createPay(PayQuickCommodite data, {String? createPath}) {
    // debugPrint("createPay ==== ${upId}");
    if (data.ppp!.length == 1) {
      ///直接购买
      Billing.createQPay(data.ppp!.first, upid: upId, createPath: createPath);
    } else {
      ///不同渠道购买
      continueQPayChannel(data, createPath: createPath, upid: upId);
    }
  }
}
