part of 'index.dart';

class RechargeLogic extends GetxController {
  late List<PayQuickCommodite> payList = [];
  PayQuickCommodite? discountProduct;

  var remainDiamonds = 0.obs;
  Timer? _timer;

  late List<Widget> animations = [];
  late List<DrawUserEntity> data = [];
  late int startIndex = 0;
  DiamondCardBean? diamondCard;
  int get propDuration => diamondCard?.propDuration ?? 0;

  AreaData? area;

  String icon(int index) => index > 7 ? Assets.imgDiamond8 : icons[index];

  final icons = [
    Assets.imgDiamond1,
    Assets.imgDiamond2,
    Assets.imgDiamond3,
    Assets.imgDiamond4,
    Assets.imgDiamond5,
    Assets.imgDiamond6,
    Assets.imgDiamond7,
    Assets.imgDiamond8
  ];

  @override
  void onInit() {
    super.onInit();
    timeCancel();
    AppConstants.isCreatePayOrder = false;
  }

  @override
  void onReady() {
    super.onReady();
    loadCacheData();
    loadData();
    loadPayList();
    getDrawUser();
    Billing.fixNoEndPurchase();
    getActiveConfig();
  }

  ///加载缓存数据
  void loadCacheData() {
    List<PayQuickCommodite> data = ProductCache.find();
    if (data.isNotEmpty) {
      payList.clear();
      payList.addAll(data);
      update();
    }
  }

  @override
  void onClose() {
    timeCancel();
    super.onClose();
  }

  loadData() async {
    final info = await ProfileAPI.info(showLoading: false);
    remainDiamonds.value = info.userBalance?.remainDiamonds ?? 0;
    //LoginCache.update(diamondCount: (info.rechargeDrawCount ?? 0).toString());
  }

  pushOrderList() => ARoutes.toOrderList();

  getDrawUser() {
    Http.instance.post<List<DrawUserEntity>>(NetPath.getDrawUser).then((value) {
      //debugPrint("data====>>> ${value}");
      List<DrawUserEntity> arr =
          value.map((e) => e..content = e.getContent()).toList();
      data.addAll(arr);
      startAnimation();
    });
  }

  loadPayList() {
    Http.instance.post<PayQuickData>(
      '${NetPath.getCompositeProduct2}2',
      showLoading: true,
      errCallback: (err) {
        AppLoading.toast(err.message);
      },
    ).then((value) {
      List<PayQuickCommodite> normalProducts = value.normalProducts ?? [];
      List<PayQuickCommodite> list = ProductCache.save(normalProducts);

      /*PayQuickCommodite? discountProduct = value.discountProduct;
      if (discountProduct != null) {
        //payList.add(discountProduct);
      }*/

      area = value.area;
      discountProduct = value.discountProduct;
      payList.clear();
      payList.addAll(list);
      if (payList.isNotEmpty) {
        payList.first.isSelect = true;
      }
      update();
      Billing.tryCorrectGooglePrice(payList, fun: () {
        update();
      });
      if (normalProducts.isNotEmpty) {
        diamondCard = normalProducts[0].diamondCard;
      }
      update(["addRechargeCard"]);
    }).catchError((error) {
      AppLoading.toast(error.message);
    });
  }

  void timeCancel() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void startAnimation() {
    animations.add(RechargeDrawAnimation(data[startIndex], key: UniqueKey()));
    update();
    _timer = Timer.periodic(const Duration(seconds: 9), (timer) {
      animations = [];
      startIndex++;
      if (data.length <= startIndex) {
        startIndex = 0;
      }
      animations.add(RechargeDrawAnimation(
        data[startIndex],
        key: UniqueKey(),
      ));
      update();
    });
  }

  createPay(PayQuickCommodite data) {
    if (data.ppp!.length == 1) {
      ///直接购买
      Billing.createQPay(
        data.ppp!.first,
      );
    } else {
      ///不同渠道购买
      continueQPayChannel(data, area: area);
    }
  }

  ///活动
  bool isOpenActivity = false;
  String activityTitle = "";
  String activityContent = "";

  getActiveConfig() {
    ActivityAPI.getActiveConfig().then((data) {
      isOpenActivity = data.status == 1;
      activityTitle = data.title;
      activityContent = data.content;
      update();
    });
  }
}
