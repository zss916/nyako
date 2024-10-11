import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager {
  static Future<void> getSingleFile({required String url}) async {
    var file = await DefaultCacheManager().getSingleFile(url);
  }
}
