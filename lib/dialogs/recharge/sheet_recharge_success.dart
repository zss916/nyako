import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_bind_google.dart';
import 'package:nyako/dialogs/recharge/widget/next_pay.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/utils/music/recharge_success_manager.dart';

void showSheetRechargeSuccess(
    {required int drawCount,
    required String diamonds,
    required bool isVipOrder}) {
  Get.bottomSheet(
      SheetRechargeSuccess(
          drawCount: drawCount, diamonds: diamonds, isVipOrder: isVipOrder),
      isScrollControlled: true,
      settings: const RouteSettings(name: AppPages.rechargeSuccessSheet));
}

class SheetRechargeSuccess extends StatelessWidget {
  final int drawCount;
  final String diamonds;
  final bool isVipOrder;

  SheetRechargeSuccess(
      {Key? key,
      required this.drawCount,
      required this.diamonds,
      required this.isVipOrder})
      : super(key: key);

  final String content1 = Tr.app_lucky_title1.tr;
  final String content2 = Tr.app_lucky_title2.tr;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) {
            ///在游戏和视频中不用弹出
            if ((!ARoutes.isCalling) && (!ARoutes.isAivPage)) {
              Future.delayed(const Duration(seconds: 1), () {
                BindGoogle.show();
              });
            }
          }
        },
        child: ChargeSuccessBg(
            child: BottomArrowWidget(
                onBack: () => Get.back(),
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(24),
                          topEnd: Radius.circular(24))),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(bottom: 10),
                        child: Image.asset(
                          Assets.iconRechargeSuccessIcon,
                          width: 123,
                          height: 102,
                          matchTextDirection: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            diamonds,
                            style: const TextStyle(
                                color: Color(0xFF9341FF),
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            Assets.iconDiamond,
                            width: 30,
                            height: 30,
                            matchTextDirection: true,
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 12, bottom: 6),
                        width: double.maxFinite,
                        child: Text(
                          Tr.app_recharge_successful.tr,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsetsDirectional.only(top: 0),
                          child: AutoSizeText.rich(
                            softWrap: true,
                            maxLines: 4,
                            maxFontSize: 15,
                            minFontSize: 10,
                            TextSpan(
                              text: content1,
                              style: const TextStyle(
                                  color: Color(0xFF9B989D), fontSize: 15),
                              children: [
                                TextSpan(
                                    text: " $drawCount ",
                                    style: const TextStyle(
                                        color: Color(0xFF9B989D),
                                        fontSize: 15)),
                                TextSpan(
                                    text: content2,
                                    style: const TextStyle(
                                        color: Color(0xFF9B989D), fontSize: 15))
                              ],
                            ),
                          )),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              top: 30, start: 15, end: 15, bottom: 10),
                          alignment: AlignmentDirectional.center,
                          width: double.maxFinite,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x669341FF),
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 5.0),
                                ),
                              ],
                              color: const Color(0xFF9341FF),
                              borderRadius:
                                  BorderRadiusDirectional.circular(50)),
                          child: Text(
                            Tr.appToRecharge.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Get.back();
                            ARoutes.toLottery(num: drawCount);
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              Tr.app_to_lucky_draw.tr,
                              style: const TextStyle(
                                  color: Color(0xFF9341FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      if (!AppConstants.isFakeMode) const NextPay()
                    ],
                  ),
                ))));
  }
}

class ChargeSuccessBg extends StatefulWidget {
  final Widget child;
  const ChargeSuccessBg({super.key, required this.child});

  @override
  State<ChargeSuccessBg> createState() => _ChargeSuccessBgState();
}

class _ChargeSuccessBgState extends State<ChargeSuccessBg> {
  @override
  void initState() {
    super.initState();
    RechargeSuccessManager.instance.start();
  }

  @override
  void dispose() {
    super.dispose();
    RechargeSuccessManager.instance.stop();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
