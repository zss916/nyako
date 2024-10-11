
/// 刷新接口
abstract class ILoadService  {
  void refreshData();
  void loadMoreData();
  void refreshAndLoadCtl(bool isRefresh);
}