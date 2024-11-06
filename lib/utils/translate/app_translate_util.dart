import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/translate/translate_http_util.dart';

class AppTranslateUtil {
  Future<List<String>> translate(
    String content, {
    TranslateHttpDoneCallback? doneCallback,
  }) async {
    return TranslateHttpUtil().post(
        data: content,
        language: convertLanguageFromAreaCode(
            UserInfo.to.myDetail?.areaCode, UserInfo.to.myDetail?.country),
        doneCallback: doneCallback);
  }

  String convertLanguageFromAreaCode(int? areaCode, int? countryCode) {
    // 越南语和菲律宾语单独处理，不根据手机语言直接返回对应的地区语言
    if (countryCode == 704) {
      // 越南
      return 'vi';
    } else if (countryCode == 608) {
      // 菲律宾语
      return 'tl';
    }
    return Get.deviceLocale?.languageCode ?? 'en';
    // String language = 'en';
    // switch (areaCode ?? -1) {
    //   case 1:
    //     // 印尼
    //     language = 'in';
    //     break;
    //   case 2:
    //     // 中东
    //     language = 'ar';
    //     break;
    //   case 3:
    //     // 印度
    //     language = 'hi';
    //     break;
    //   case 4:
    //     break;
    //   case 5:
    //     break;
    //   case 6:
    //     // 土语
    //     language = 'tr';
    //     break;
    //   case 7:
    //     // 美区
    //     language = 'en';
    //     break;
    //   case 8:
    //     // 西语
    //     language = 'es';
    //     break;
    //   case 9:
    //     // 葡语
    //     language = 'pt';
    //     break;
    //   case 10:
    //     break;
    //   case 11:
    //     // 泰语
    //     language = 'th';
    //     break;
    // }
    // return language;
  }

  // 是否配置了翻译功能
  bool translateConfig() {
    // return false;
    // print("VisalUserInfo.to.config?.stopTranslate===${VisalUserInfo.to.config?.stopTranslate}");
    if (AppConstants.isFakeMode == false &&
        UserInfo.to.config?.stopTranslate != true) {
      return true;
    }
    return false;
  }

  // 判断是否有翻译功能
  Future<bool> hasTranslateFunction(String content) async {
    if (translateConfig() && content.isNotEmpty) {
      List<String> value = await TranslateHttpUtil().post(
        data: content,
        language: 'en',
      );
      if (value.isNotEmpty && value.length > 1) {
        String languageCode = value[1];
        // if (languageCode.isNotEmpty && languageCode != Get.deviceLocale?.languageCode) {
        if (languageCode.isNotEmpty &&
            languageCode !=
                convertLanguageFromAreaCode(UserInfo.to.myDetail?.areaCode,
                    UserInfo.to.myDetail?.country)) {
          return true;
        }
      }
    }
    return false;
  }
}
