import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:language/app_language_ar.dart';
import 'package:language/app_language_en.dart';
import 'package:language/app_language_es.dart';
import 'package:language/app_language_hi.dart';
import 'package:language/app_language_ind.dart';
import 'package:language/app_language_pt.dart';
import 'package:language/app_language_th.dart';
import 'package:language/app_language_tr.dart';
import 'package:language/app_language_vi.dart';

class AppTrans extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en": language_en,
      "ar": language_ar,
      "es": language_es,
      "hi": language_hi,
      "id": language_ind,
      "pt": language_pt,
      "tr": language_tr,
      "th": language_th,
      "vi": language_vi,
    };
  }
}
