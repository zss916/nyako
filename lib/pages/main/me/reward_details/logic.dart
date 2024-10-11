part of 'index.dart';

class RewardDetailsLogic extends GetxController implements ILoadService {
  late RefreshController refreshCtrl;
  int currentMonth = int.parse(formatDate(DateTime.now(), [mm]));
  int lastMonth = 0;
  int lLastMonth = 0;
  int selectMonth = 0;
  int page = 1;
  List<BalanceListData> balanceList = [];
  int selectOrderType = -1;
  int type = 0;

  ///切换月份
  changeMonth(int selected) {
    selectMonth = selected;
    update();
    refreshData();
  }

  ///输出月份多语言
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

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  @override
  void refreshAndLoadCtl(bool isRefresh) {
    isRefresh ? refreshCtrl.refreshCompleted() : refreshCtrl.loadComplete();
  }

  @override
  void refreshData() {
    balanceList.clear();
    _loadData(page = 1);
  }

  @override
  loadMoreData() {
    _loadData(++page);
  }

  _loadData(int page) {
    var monthStr = formatDate(
        DateTime.now(), [yyyy, '.', selectMonth.toString(), '.', "01"]);
    Http.instance
        .post<List<BalanceListData>>(NetPath.getBalanceDetails + monthStr,
            data: {
              'page': 1,
              'pageSize': 10,
              'depletionTypes': Get.arguments[0] == true ? [10, 19] : [19]
            },
            showLoading: true, errCallback: (error) {
      refreshAndLoadCtl(page == 1);
    }).then((value) {
      balanceList.addAll(value);
      refreshAndLoadCtl(page == 1);
      update();
    });
  }
}
