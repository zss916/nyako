part of 'index.dart';

abstract class DiamondAPI {
  ///缓存普通商品
  static Future<List<PayQuickCommodite>> loadDiamond() async {
    PayQuickData data = await Http.instance.post<PayQuickData>(
      '${NetPath.getCompositeProduct2}2',
    );
    List<PayQuickCommodite> normalProducts = data.normalProducts ?? [];
    List<PayQuickCommodite> list = ProductCache.save(normalProducts);
    return list;
  }
}
