part of 'index.dart';

class VipLogic extends GetxController {
  late List<PayQuickCommodite> data = [];

  PayQuickCommodite? discountVip;

  AreaData? area;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
    getVip();
  }

  loadData() {
    data.clear();
    Http.instance.post<PayQuickData>(
      '${NetPath.getCompositeProduct2}3',
      showLoading: false,
      errCallback: (err) {
        AppLoading.toast(err.message);
      },
    ).then((value) {
      List<PayQuickCommodite> list = value.vipProducts ?? [];
      if (list.isNotEmpty) {
        list[0].isSelect = true;
      }
      data.addAll(list);
      discountVip = value.discountVip;
      area = value.area;
      update();
    });
  }

  getVip() async {
    final info = await ProfileAPI.info(showLoading: false);
    UserInfo.to.setMyDetail = info;
    update();
  }
}
