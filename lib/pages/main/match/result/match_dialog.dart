import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_host_match_limit_entity.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/pages/main/match/result/match_fail.dart';
import 'package:oliapro/pages/main/match/result/match_success.dart';

void showMatch(HostMatchLimitEntityAnchor anchor,
    {Function? onRestart, MatchLogic? logic}) {
  // debugPrint("anchor==> ${anchor.toJson()}");
  Get.dialog(
      anchor.userId == null
          ? const MatchFail()
          : MatchSuccess(
              anchor,
              onRestart: onRestart,
              logic: logic,
            ),
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      routeSettings: const RouteSettings(name: "match result dialog"));
}
