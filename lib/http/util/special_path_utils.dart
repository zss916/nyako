import 'package:oliapro/http/index.dart';

class PathUtils {
  /// 是否是特殊接口
  static bool isSpecial(String path) {
    bool isGetLanguage = path == NetPath.getTransationsApi;
    bool isGetLanguageV2 = path == NetPath.getTransationsV2Api;
    bool isGetConfig = path == NetPath.configApi;
    bool isGetConfigV2 = path == NetPath.configApiV2;
    bool isSpecial =
        isGetConfig || isGetLanguage || isGetLanguageV2 || isGetConfigV2;
    return isSpecial;
  }

  static bool isConfigV2(String path) {
    bool isGetConfigV2 = path == NetPath.configApiV2;
    return isGetConfigV2;
  }
}
