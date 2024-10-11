part of 'index.dart';

abstract class RewardProductAPI {
  static Future<PayQuickCommodite> getDrawProduct(
      {required int select, bool isCache = false}) async {
    PayQuickCommodite data = await Http.instance
        .post<PayQuickCommodite>("${NetPath.getDrawProduct}$select");
    if (isCache) {
      File cacheFile =
          await DefaultCacheManager().getSingleFile(data.drawImageIcon ?? "");
      data.cacheDrawImageIcon = cacheFile.path;
    }
    return data;
  }
}
