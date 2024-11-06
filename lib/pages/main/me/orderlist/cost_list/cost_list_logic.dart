import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nyako/http/index.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../common/language_key.dart';
import '../../../../../entities/app_order_entity.dart';

class CostListLogic extends GetxController {
  List<CostBean> dataList = [];
  var _page = 0;
  final _pageSize = 10;
  int currentMonthInt = 1;
  int lastMoth = 1;
  int lastlastMoth = 1;
  String currentMonthFormat = '';
  String lastMonthFormat = '';
  String lastLastMonthFormat = '';
  int choosedIndex = 0;

  final RefreshController refreshCtr = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    var formater = DateFormat('yyyy-MM-01');
    var timeNow = DateTime.now();
    DateTime lastMonthDate;
    DateTime lastLastMonthDate;
    currentMonthFormat = formater.format(timeNow);
    currentMonthInt = timeNow.month;

    lastMoth = currentMonthInt - 1;
    if (lastMoth <= 0) {
      lastMoth = 12 + lastMoth;
      lastMonthDate = DateTime(timeNow.year - 1, lastMoth);
    } else {
      lastMonthDate = DateTime(timeNow.year, lastMoth);
    }
    lastMoth = lastMonthDate.month;
    lastMonthFormat = formater.format(lastMonthDate);

    lastlastMoth = currentMonthInt - 2;
    if (lastlastMoth <= 0) {
      lastlastMoth = 12 + lastlastMoth;
      lastLastMonthDate = DateTime(timeNow.year - 1, lastlastMoth);
    } else {
      lastLastMonthDate = DateTime(timeNow.year, lastlastMoth);
    }
    lastlastMoth = lastLastMonthDate.month;
    lastLastMonthFormat = formater.format(lastLastMonthDate);
  }

  //TO DO 月份国际化
  String getMonth(int month) {
    String m = "";
    switch (month) {
      case 1:
        m = Tr.app_month_1.tr;
        break;
      case 2:
        m = Tr.app_month_2.tr;
        break;
      case 3:
        m = Tr.app_month_3.tr;
        break;
      case 4:
        m = Tr.app_month_4.tr;
        break;
      case 5:
        m = Tr.app_month_5.tr;
        break;
      case 6:
        m = Tr.app_month_6.tr;
        break;
      case 7:
        m = Tr.app_month_7.tr;
        break;
      case 8:
        m = Tr.app_month_8.tr;
        break;
      case 9:
        m = Tr.app_month_9.tr;
        break;
      case 10:
        m = Tr.app_month_10.tr;
        break;
      case 11:
        m = Tr.app_month_11.tr;
        break;
      case 12:
        m = Tr.app_month_12.tr;
        break;
    }
    return m;
  }

  String choosedMonth() {
    switch (choosedIndex) {
      case 0:
        return currentMonthFormat;
      case 1:
        return lastMonthFormat;
      case 2:
        return lastLastMonthFormat;
      default:
        return currentMonthFormat;
    }
  }

  @override
  void onReady() {
    super.onReady();
    onRefresh();
  }

  void onRefresh({int index = -1}) async {
    if (index != -1) {
      this.choosedIndex = index;
    }
    _page = 0;
    await getList();
    refreshCtr.refreshCompleted();
  }

  void onLoading() async {
    await getList();
    refreshCtr.loadComplete();
  }

  Future getList() async {
    _page++;
    await Http.instance
        .post<List<CostBean>>(NetPath.costListApi + choosedMonth(), data: {
      "page": _page,
      "pageSize": _pageSize,
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
    });
  }
}
