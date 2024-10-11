import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/services/storage_service.dart';

class ProductCache {
  static final icons = [
    Assets.imgDiamond1,
    Assets.imgDiamond2,
    Assets.imgDiamond3,
    Assets.imgDiamond4,
    Assets.imgDiamond5,
    Assets.imgDiamond6,
    Assets.imgDiamond7,
    Assets.imgDiamond8
  ];

  static List<PayQuickCommodite> save(List<PayQuickCommodite> data) {
    for (int i = 0; i < data.length; i++) {
      if (i >= 7) {
        data[i].diamondIcon = icons[7];
      } else {
        data[i].diamondIcon = icons[i];
      }
    }
    StorageService.to.saveProductList(data);
    return data;
  }

  static List<PayQuickCommodite> find() {
    return StorageService.to.getProductList();
  }

  static Future<List<PayQuickCommodite>> load() async {
    List<PayQuickCommodite> data = find();
    if (data.isEmpty) {
      List<PayQuickCommodite> list = await DiamondAPI.loadDiamond();
      return list;
    } else {
      return data;
    }
  }

  ///匹配
  static Future<List<PayQuickCommodite>> matchDiamond(
      List<PayQuickCommodite> list) async {
    List<PayQuickCommodite> data = await ProductCache.load();
    if (data.isNotEmpty) {
      for (var match in data) {
        for (var value in list) {
          if (value.productId == match.productId) {
            value.diamondIcon = match.diamondIcon;
          }
        }
      }
    }
    return list;
  }
}
