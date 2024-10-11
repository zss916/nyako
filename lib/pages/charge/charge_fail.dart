import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/charge/billing.dart';

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
            width: 305,
            height: 367,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Color(0xFF201436),
                      Color(0xFF0C0C32),
                    ]),
                borderRadius: BorderRadiusDirectional.all(Radius.circular(30))),
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 30, bottom: 20),
                  child: Image.asset(
                    Assets.imgFail,
                    matchTextDirection: true,
                    width: 84,
                    height: 84,
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 20, left: 10, right: 10),
                  child: AutoSizeText(
                    content2,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    maxFontSize: 15,
                    minFontSize: 13,
                    style: const TextStyle(
                        color: Color(0xFFC3A0FF),
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (cancelFunc != null) {
                      cancelFunc?.call();
                    } else {
                      Get.back();
                    }
                    call?.call();
                    Billing.payCallBack(type: Billing.type, code: 3006);
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 52,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: AppColors.btnGradient,
                        borderRadius: const BorderRadiusDirectional.all(
                            Radius.circular(30))),
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
                    if (cancelFunc != null) {
                      cancelFunc?.call();
                    } else {
                      Get.back();
                    }
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
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
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
              ))
        ],
      ),
    );
  }
}
