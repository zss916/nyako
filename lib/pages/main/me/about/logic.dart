part of 'index.dart';

class AboutLogic extends GetxController {
  List<Map<String, String>> listData = [
    {'title': Tr.app_login_privacy_policy.tr, 'type': 'privacy'},
    {'title': Tr.app_login_terms_service.tr, 'type': 'service'},
  ];

  toPolicy() {
    ARoutes.toPolicy();
  }

  toAgreement() {
    ARoutes.toAgreement();
  }
}
