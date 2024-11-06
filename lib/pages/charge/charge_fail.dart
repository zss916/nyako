import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/sheet_service.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/charge/billing.dart';
import 'package:nyako/routes/app_pages.dart';

void showChargeFailDialog({String? state}) {
  Get.dialog(
      ChargeFail(
        state: state,
      ),
      routeSettings: const RouteSettings(name: AppPages.rechargeFailDialog));
}

class ChargeFail extends StatelessWidget {
  final String? state;
  final Function? call;
  final bool? isBot;
  final CancelFunc? cancelFunc;

  ChargeFail({super.key, this.state, this.call, this.isBot, this.cancelFunc});

  final String content = Tr.app_restart_pay.tr;
  final String title = Tr.app_recharge_fail.tr;
  final String btn1 = Tr.app_restart_pay.tr;
  final String btn2 = Tr.app_mine_customer_service.tr;
  final String content2 = Tr.app_order_status_failure.tr;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(35),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 315,
            height: 344,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(30))),
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 30, bottom: 20),
                  child: Image.asset(
                    Assets.iconWarming,
                    matchTextDirection: true,
                    width: 60,
                    height: 60,
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 16, bottom: 20, left: 10, right: 10),
                  child: AutoSizeText(
                    content2,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    maxFontSize: 15,
                    minFontSize: 13,
                    style: const TextStyle(
                        color: Color(0xFF9B989D),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Billing.payCallBack(type: Billing.type, code: 3006);
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 52,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color(0xFF9341FF),
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(30))),
                    child: Text(
                      btn1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showServiceSheet();
                    Billing.payCallBack(type: Billing.type, code: 3007);
                  },
                  child: Container(
                    width: double.maxFinite,
                    //height: 52,
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 15, vertical: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                        color: Colors.transparent,
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(30))),
                    child: Text(
                      btn2,
                      style: const TextStyle(
                          color: Color(0xFF9B989D),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* PositionedDirectional(
              top: 10,
              end: 10,
              child: GestureDetector(
                onTap: () {
                  if (cancelFunc != null) {
                    cancelFunc?.call();
                  } else {
                    Get.back();
                  }
                  Billing.payCallBack(type: Billing.type, code: 3008);
                },
                child: Image.asset(
                  Assets.imgCloseDialog,
                  width: 30,
                  height: 30,
                ),
              ))*/
        ],
      ),
    );
  }
}
