part of 'index.dart';

///主播api
abstract class AnchorAPI {
  static Future<HostDetail> loadAnchorDetail({required String anchorId}) async {
    return await Http.instance.post<HostDetail>(NetPath.upDetailApi + anchorId,
        errCallback: (err) {
      AppLoading.toast(err.message);
    });
  }

  static Future<List<AreaData>> loadAreas() async {
    var data = await Http.instance.post<UpListData>(
        NetPath.upListApi + StorageService.to.getAreaCode().toString(),
        data: {
          "page": 1,
          "pageSize": 1,
          "isShowResource": 1,
        },
        showLoading: true, errCallback: (err) {
      AppLoading.toast(err.message);
    }).whenComplete(() => AppLoading.dismiss());
    return data.getArea();
  }
}
