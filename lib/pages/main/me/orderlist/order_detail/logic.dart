import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_order_entity.dart';
import 'package:nyako/utils/aihelp/ai_help.dart';
import 'package:nyako/utils/app_loading.dart';

class OrderDetailLogic extends GetxController {
  OrderData data = Get.arguments[0];

  copyId() {
    Clipboard.setData(ClipboardData(text: data.orderNo ?? '--'));
    AppLoading.toast(Tr.app_base_success.tr);
  }

  contactCs() {
    AiHelp.instance.enterOrderAIHelp(data.orderNo ?? "");
  }
}
