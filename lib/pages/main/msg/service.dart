/// 刷新接口
abstract class IFollowLoadService {
  void refreshFollowData();
  void loadMoreFollowData();
  void refreshAndLoadFollowCtl(bool isRefresh);
}
