import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/http/api/index.dart';
import 'package:nyako/services/storage_service.dart';

class ProductCache {
  static final icons = [
    Assets.iconDiamond,
    Assets.iconDiamond2,
    Assets.iconDiamond3,
    Assets.iconDiamond4,
    Assets.iconDiamond5,
    Assets.iconDiamond6,
    Assets.iconDiamond7,
    Assets.iconDiamond7
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
