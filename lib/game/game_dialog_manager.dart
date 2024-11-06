import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_bind_google.dart';
import 'package:nyako/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:nyako/dialogs/pay_select_area/sheet_select_area.dart';
import 'package:nyako/dialogs/pay_vip/sheet/vip_list_sheet.dart';
import 'package:nyako/dialogs/recharge/sheet_recharge_success.dart';
import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/charge/charge_fail.dart';
import 'package:nyako/pages/charge/charge_quick_dialog.dart';
import 'package:nyako/pages/some/web_dialog.dart';
import 'package:nyako/pages/widget/bottom_arrow_widget.dart';
import 'package:nyako/routes/a_routes.dart';

class GameDialogManager {
  ///充值成功
  static openRechargeSuccess(
      {required int drawCount,
      required String diamonds,
      required bool isVipOrder,
      bool isBot = true}) {
    if (isVipOrder) {
      String content1 = Tr.app_lucky_title1.tr;
      String content2 = Tr.app_lucky_title2.tr;
      BotToast.showCustomNotification(
        toastBuilder: (cancelFunc) {
          return ChargeSuccessBg(
              child: Container(
            width: double.maxFinite,
            height: 80,
            padding: const EdgeInsetsDirectional.only(
                start: 12, end: 12, top: 5, bottom: 5),
            margin:
                const EdgeInsetsDirectional.only(start: 15, end: 15, top: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFABFFCE),
                  Color(0xFF8AFFFD),
                ]),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        //color: Colors.green,
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: Image.asset(
                          Assets.iconKingBig,
                          width: 32,
                          height: 32,
                          matchTextDirection: true,
                        ),
                      ),
                      PositionedDirectional(
                          top: 0,
                          child: Image.asset(
                            Assets.iconVipS,
                            width: 42,
                            height: 28,
                          ))
                    ],
                  ),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          margin: const EdgeInsetsDirectional.only(top: 3),
                          child: AutoSizeText.rich(
                            softWrap: true,
                            maxLines: 4,
                            maxFontSize: 13,
                            minFontSize: 6,
                            TextSpan(
                              text: content1,
                              style: TextStyle(
                                  color: const Color(0xFF9341FF),
                                  fontFamily: AppConstants.fontsRegular,
                                  fontSize: 12),
                              children: [
                                TextSpan(
                                    text: " $drawCount ",
                                    style: TextStyle(
                                        fontFamily: AppConstants.fontsRegular,
                                        color: const Color(0xFF9341FF),
                                        fontSize: 12)),
                                TextSpan(
                                    text: content2,
                                    style: TextStyle(
                                        fontFamily: AppConstants.fontsRegular,
                                        color: const Color(0xFF9341FF),
                                        fontSize: 12))
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
                    Assets.iconNextB,
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
    } else {
      showSheetRechargeSuccess(
          drawCount: drawCount, diamonds: diamonds, isVipOrder: isVipOrder);
    }
  }

  ///充值失败
  static showRechargeFail({String? state, Function? call}) {
    showChargeFailDialog(state: state);

    /* BotToast.showAnimationWidget(
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
    );*/
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
