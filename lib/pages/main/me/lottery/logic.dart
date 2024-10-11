part of 'index.dart';

class LotteryLogic extends GetxController {
  late List<DrawData> draw = [];
  var num = 0.obs;

  ///剩余
  bool isClick = true;
  var drawNum = 0.obs;

  // var count = 0.obs;
  // late Worker worker;

  @override
  void onInit() {
    super.onInit();
    /*worker = debounce(
      count,
      (value) {
        // debugPrint("====>>>> ${value}");
        // if( value > 20 ) worker.dispose();
      },
      time: 1.seconds,
    );*/
  }

  @override
  void dispose() {
    super.dispose();
    //worker.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    drawNum.value = (Get.arguments[0] ?? 0);
    draw.clear();
    loadUser();
    loadLottery();
  }

  loadUser() async {
    final data = await ProfileAPI.info(showLoading: false);
    num.value = data.rechargeDrawCount ?? 0;
  }

  loadLottery() {
    AppLoading.show(dismissOnTap: false);
    Http.instance
        .post<List<DrawData>>(NetPath.getDrawConfig)
        .whenComplete(() => AppLoading.dismiss())
        .then((value) {
      for (int i = 0; i < value.length; i++) {
        value[i].color = handColor(i);
        value[i].content = value[i].getContent();
      }
      for (var element in value) {
        element.getContent();
      }
      draw.addAll(value);
      Future.wait([...draw.map((e) => e.handImg(isDefault: true)).toList()])
          .whenComplete(() {
        AppLoading.dismiss();
        update();
      });
    });
  }

  Color handColor(int i) =>
      (i % 2 == 0) ? const Color(0xFF7D33E3) : const Color(0xFF8C39DA);

  toDraw(Function callBack) {
    if (num.value <= 0) {
      ChargeDialogManager.showChargeDialog(ChargePath.home_draw_recharge,
          showFreeDiamondPage: true, showBalanceText: false);
    }
    if (num.value > 0 && isClick) {
      isClick = false;
      Http.instance
          .post<DrawData>(NetPath.rechargeDraw, showLoading: true,
              errCallback: (e) {
            isClick = true;
          })
          .whenComplete(() => AppLoading.dismiss())
          .then((value) {
            int index = draw
                .indexWhere((element) => element.configId == value.configId);
            if (index != -1) {
              callBack.call(index, value);
            }
            if (num.value > 0) {
              num.value -= 1;
            }
            isClick = true;
          });
    }
  }

  ///获取本地图片
  Future<ui.Image> getAssetImage(String asset, {width, height}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  ///获取网络图片 返回ui.Image
  Future<ui.Image> getNetImage(String url, {width, height}) async {
    try {
      ByteData data = await NetworkAssetBundle(Uri.parse(url)).load(url);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: width, targetHeight: height);
      ui.FrameInfo fi = await codec.getNextFrame();
      return fi.image;
    } catch (e) {
      return getAssetImage(Assets.imgAppLogo, width: 30, height: 30);
    }
  }
}
