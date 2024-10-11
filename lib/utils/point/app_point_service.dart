import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/http/api/index.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/point/point_db.dart';

class AppPointService extends GetxService {
  static AppPointService get to => Get.find();

  Timer? _timer;

  int now = 0;

  Future<AppPointService> init() async {
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    if (!AppConstants.isFakeMode) {
      _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
        if (UserInfo.to.hasAuthorization) {
          //debugPrint("point ===> init");
          now = DateTime.now().millisecondsSinceEpoch;
          List<Map<String, dynamic>> list = PointDB.instance
              .getAll(now)
              .map<Map<String, dynamic>>((e) => e.toJson())
              .toList();
          if (list.isNotEmpty) {
            PointAPI.toPoint(data: jsonEncode(list)).then((value) {
              PointDB.instance.cleanAll(now);
            });
          }
        }
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
