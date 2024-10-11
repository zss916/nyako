import 'package:get/get.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../entities/app_order_entity.dart';

class OrderListLogic extends GetxController {
  late List<OrderData> dataList = [];
  var _page = 0;
  final _pageSize = 10;
  late int chooseIndex = 0;

  bool enablePullUp = true;

  final RefreshController refreshCtr = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  void onClose() {
    refreshCtr.dispose();
    super.onClose();
  }

  void onRefresh({int index = 0}) async {
    chooseIndex = index;
    _page = 0;
    enablePullUp = true;
    await getList();
    refreshCtr.refreshCompleted();
  }

  void toRefresh() {
    onRefresh(index: chooseIndex);
  }

  void onLoading() async {
    await getList();
    refreshCtr.loadComplete();
  }

  Future getList() async {
    _page++;
    await Http.instance.post<List<OrderData>>(NetPath.orderListApi, data: {
      "page": _page,
      "pageSize": _pageSize,
      // -1所有 0.待支付订单，1.完成订单，2.失败订单
      "orderType": chooseIndex - 1,
    }, errCallback: (err) {
      AppLoading.toast(err.message);
      if (_page == 1) {
        refreshCtr.refreshCompleted();
      } else {
        refreshCtr.loadComplete();
      }
    }, showLoading: true).then((value) {
      if (_page == 1) {
        dataList.clear();
        dataList.addAll(value);
        update();
      } else {
        dataList.addAll(value);
        update();
      }
    }).catchError((err) {
      if (err == 0) {
        if (_page == 1) {
          dataList.clear();
        }
        update();
      }
    });
  }

  pushOrderDetail(OrderData data) {
    ARoutes.toOrderDetail(data);
  }
}
