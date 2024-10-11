import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_bind_google.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/dialogs/pay_select_area/sheet_select_area.dart';
import 'package:oliapro/dialogs/pay_vip/sheet/vip_list_sheet.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/charge/charge_fail.dart';
import 'package:oliapro/pages/charge/charge_quick_dialog.dart';
import 'package:oliapro/pages/some/web_dialog.dart';
import 'package:oliapro/pages/widget/bottom_arrow_widget.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/music/recharge_success_manager.dart';

class GameDialogManager {
  ///充值成功
  static openRechargeSuccess(
      {required int drawCount,
      required String diamonds,
      required bool isVipOrder,
      bool isBot = true}) {
    String content1 = Tr.app_lucky_title1.tr;
    String content2 = Tr.app_lucky_title2.tr;
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) {
        return ChargeSuccessBg(Container(
          width: double.maxFinite,
          height: 80,
          padding: const EdgeInsetsDirectional.only(
              start: 12, end: 12, top: 5, bottom: 5),
          margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(stops: [
                0.2,
                1
              ], colors: [
                Color(0xFF8940FF),
                Color(0xFFD34BFD),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    isVipOrder ? Assets.imgKing : Assets.imgRechargeOk,
                    width: 45,
                    height: 45,
                    matchTextDirection: true,
                  ),
                  if (!isVipOrder)
                    Text(
                      "+$diamonds",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Tr.app_recharge_successful.tr,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: const EdgeInsetsDirectional.only(top: 3),
                        child: AutoSizeText.rich(
                          softWrap: true,
                          maxLines: 4,
                          maxFontSize: 12,
                          minFontSize: 6,
                          TextSpan(
                            text: content1,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            children: [
                              TextSpan(
                                  text: " $drawCount ",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              TextSpan(text: content2)
                            ],
                          ),
                        )),
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  cancelFunc.call();
                  ARoutes.toLottery(num: drawCount);
                },
                child: Image.asset(
                  Assets.imgToRightArrow,
                  width: 30,
                  height: 30,
                  matchTextDirection: true,
                ),
              )
            ],
          ),
        ));
      },
      onClose: () {
        ///在游戏和视频中不用弹出
        if ((!ARoutes.isCalling) && (!ARoutes.isAivPage)) {
          Future.delayed(const Duration(seconds: 1), () {
            BindGoogle.show();
          });
        }
      },
      dismissDirections: const [DismissDirection.up],
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 5),
      onlyOne: false,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }

  ///充值失败
  static showRechargeFail({String? state, Function? call}) {
    BotToast.showAnimationWidget(
      toastBuilder: (cancelFunc) {
        return ChargeFail(
          state: state,
          call: call,
          isBot: true,
          cancelFunc: cancelFunc,
        );
      },
      onClose: () {},
      backgroundColor: const Color(0xBF000000),
      animationDuration: const Duration(seconds: 0),
      animationReverseDuration: const Duration(seconds: 0),
      wrapToastAnimation: (controller, cancel, child) => SafeArea(child: child),
      groupKey: "toRechargeFailBot",
      onlyOne: false,
      crossPage: true,
      clickClose: false,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }

  ///打开第三方支付
  static openWeb(String url) => showWebDialog(url);

  ///打开VIP充值弹窗
  static openVipDialog(int index, String? path, List<PayQuickCommodite> list) {
    BotToast.showAnimationWidget(
      toastBuilder: (cancelFunc) {
        return BottomArrowWidget(
          child: VipListSheet(
              data: list,
              path: path ?? ChargePath.android_recharge_center,
              selectIndex: index),
          onBack: () => cancelFunc.call(),
        );
      },
      onClose: () {},
      backgroundColor: const Color(0x7F000000),
      animationDuration: const Duration(seconds: 0),
      animationReverseDuration: const Duration(seconds: 0),
      wrapToastAnimation: (controller, cancel, child) => SafeArea(child: child),
      groupKey: "toVipDialogBot",
      onlyOne: false,
      crossPage: true,
      clickClose: false,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }

  ///选择地区
  static openCountrySelect(List<AreaData> data, Function(AreaData?) func) {
    BotToast.showAnimationWidget(
      toastBuilder: (cancelFunc) {
        return BottomArrowWidget(
          child: MSelectArea(
            data: data,
            func: func,
            isBot: true,
            cancelFunc: cancelFunc,
          ),
          onBack: () => cancelFunc.call(),
        );
      },
      onClose: () {},
      backgroundColor: const Color(0x7F000000),
      animationDuration: const Duration(seconds: 0),
      animationReverseDuration: const Duration(seconds: 0),
      wrapToastAnimation: (controller, cancel, child) => SafeArea(child: child),
      groupKey: "showSelectAreaBot",
      onlyOne: false,
      crossPage: true,
      clickClose: true,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }

  ///渠道支付
  static continuePayChannel(PayQuickCommodite commodite,
      {String? path = ChargePath.android_recharge_center,
      bool isVip = false,
      String? upid}) {
    BotToast.showAnimationWidget(
      toastBuilder: (cancelFunc) {
        return BottomArrowWidget(
          child: PayChannel(
              commodite, path ?? ChargePath.android_recharge_center, isVip,
              upid: upid),
          onBack: () => cancelFunc.call(),
        );
      },
      onClose: () {},
      backgroundColor: const Color(0x7F000000),
      animationDuration: const Duration(seconds: 0),
      animationReverseDuration: const Duration(seconds: 0),
      wrapToastAnimation: (controller, cancel, child) => SafeArea(child: child),
      groupKey: "continueQPayChannelBot",
      onlyOne: false,
      crossPage: true,
      clickClose: true,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }

  static bool isShowingChargeDialog = false;

  ///充值弹窗
  static openChargeDialog(String createPath,
      {String? upid, Function? closeCallBack, int type = 0}) {
    isShowingChargeDialog = true;
    BotToast.showAnimationWidget(
      toastBuilder: (cancelFunc) {
        return ChargeQuickDialog(
          createPath: createPath,
          upId: upid,
          isBot: true,
          closeCallBack: closeCallBack,
          hasDiscountProduct: true,
          closeBtnCallBack: () {
            cancelFunc.call();
          },
        );
      },
      onClose: () {
        isShowingChargeDialog = false;
      },
      backgroundColor: const Color(0x7F000000),
      animationDuration: const Duration(seconds: 0),
      animationReverseDuration: const Duration(seconds: 0),
      wrapToastAnimation: (controller, cancel, child) => SafeArea(
          child: Center(
        child: child,
      )),
      groupKey: "playRecharge",
      onlyOne: false,
      crossPage: true,
      clickClose: false,
      allowClick: false,
      backButtonBehavior: BackButtonBehavior.close,
    );
  }
}

class ChargeSuccessBg extends StatefulWidget {
  final Widget child;
  const ChargeSuccessBg(this.child, {super.key});

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
