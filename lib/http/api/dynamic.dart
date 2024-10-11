part of 'index.dart';

abstract class DynamicAPI {
  ///获取我的动态
  static Future<List<LinkContent>> loadMyDynamic({required String uid}) async {
    return await Http.instance
        .post<List<LinkContent>>('${NetPath.getLinkContent}$uid/-1');
  }

  ///删除我的动态
  static Future<void> deleteMyDynamic(String dynamicId) async {
    return await Http.instance
        .post<void>(NetPath.delContent + dynamicId, showLoading: true)
        .whenComplete(() => AppLoading.dismiss());
  }
}
