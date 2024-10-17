import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';

class PopScopeWidget extends StatelessWidget {
  final Widget child;

  const PopScopeWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!AppConstants.isFakeMode)
        ? PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, _) {
              //debugPrint("onPopInvoked ==> $didPop");
              if (didPop == false) {
                if (AppConstants.isCreatePayOrder == false) {
                  AppConstants.isCreatePayOrder = true;
                  ChargeDialogManager.showChargeDialog(
                      ChargePath.android_recharge_center);
                } else {
                  Get.back();
                }
              }
            },
            child: child)
        : child;
  }
}
