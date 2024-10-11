import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/http/index.dart';

import '../../common/app_constants.dart';
import '../../entities/app_gift_entity.dart';
import '../../generated/json/base/json_convert_content.dart';
import '../../services/storage_service.dart';
import '../app_cache_manager.dart';

class GiftDataHelper {
  static Future<List<GiftEntity>?> getGifts() async {
    List<GiftEntity>? listStore;
    String? giftsJson = StorageService.to.prefs
        .getString("${Get.locale?.languageCode}_${AppConstants.giftsJson}");
    if (giftsJson != null && giftsJson.isNotEmpty) {
      listStore =
          jsonConvert.convertListNotNull<GiftEntity>(json.decode(giftsJson));
      // print("listStore===${listStore!.length}");
    }
    if (listStore != null && listStore.isNotEmpty) {
      return listStore;
    }

    var list = await Http.instance
        .post<List<GiftEntity>>(NetPath.giftAllListApi, showLoading: true)
        .then((value) {
      if (value.isNotEmpty) {
        StorageService.to.prefs.setString(
            "${Get.locale?.languageCode}_${AppConstants.giftsJson}",
            json.encode(value));
      }
    });
    return list;
  }

  static checkGiftDownload() {
    getGifts().then((value) {
      if (value == null || value.isEmpty) return;
      for (var gift in value) {
        if ((gift.animEffectUrl ?? "").trim().isNotEmpty) {
          GiftCacheManager.instance.getSingleFile(gift.animEffectUrl ?? '');
        }
      }
    });
  }
}
