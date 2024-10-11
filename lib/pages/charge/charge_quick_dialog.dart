import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/gen_a/A.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/pages/widget/circular_progress.dart';
import 'package:oliapro/services/event_bus_bean.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_some_extension.dart';
import 'package:oliapro/widget/scale_transform.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

import '../../common/language_key.dart';
import '../../entities/app_charge_quick_entity.dart';
import 'charge_dialog_manager.dart';
import 'charge_quick_controller.dart';

class ChargeQuickDialog extends StatefulWidget {
  final String createPath;
  final bool hasDiscountProduct;
  final String? upId;
  final Function? closeCallBack;
  final Function? closeBtnCallBack; // 点击关闭按钮的回调
  final bool? isBot;

  const ChargeQuickDialog(
      {super.key,
      required this.createPath,
      required this.upId,
      required this.closeCallBack,
      required this.hasDiscountProduct,
      required this.closeBtnCallBack,
      this.isBot});

  @override
  State<ChargeQuickDialog> createState() => _ChargeQuickDialogState();
}

class _ChargeQuickDialogState extends State<ChargeQuickDialog> {
  late final StreamSubscription<String> sub;

  @override
  void dispose() {
    if (widget.isBot != true) {
      widget.closeCallBack?.call();
    }
    sub.cancel();
    AppConstants.isQuickPay = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    AppConstants.isQuickPay = true;
    sub = StorageService.to.eventBus.on<String>().listen((event) {
      if (event == eventBusRefreshMe) {
        safeFind<ChargeQuickController>()?.loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChargeQuickController>(
        init: ChargeQuickController()
          ..upId = widget.upId
          ..createPath = widget.createPath,
        initState: (state) {
          ChargeDialogManager.isShowingChargeDialog = true;
          BgmControl.setRechargeVolume(false);
        },
        dispose: (state) {
          ChargeDialogManager.isShowingChargeDialog = false;
          BgmControl.setRechargeVolume(true);
        },
        builder: (controller) {
          return controller.normalProducts == null
              ? const CircularProgress()
              : _buildHomePayWidget(
                  controller,
                  createPath: widget.createPath,
                );
        });
  }

  Widget _buildHomePayWidget(ChargeQuickController logic,
      {String? createPath}) {
    return ScaleTransform(
      child: newContent(logic, createPath: createPath),
    );
  }

  Widget newContent(ChargeQuickController logic, {String? createPath}) {
    return Column(
      children: [
        const Spacer(),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              alignment: AlignmentDirectional.topCenter,
              width: double.maxFinite,
              margin: EdgeInsetsDirectional.only(
                  start: 30.h, end: 30.h, bottom: 0.h),
              child: Image.asset(
                Assets.imgDialogHomeRechargeTopBg,
                matchTextDirection: true,
                width: 315,
                height: 130,
              ),
            ),
            Container(
              width: double.maxFinite,
              color: Colors.transparent,
              margin: EdgeInsetsDirectional.only(
                  start: 30.h, end: 30.h, top: 125.h),
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 13, end: 12, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        matchTextDirection: true,
                        centerSlice: Rect.fromLTRB(30, 20, 310, 280),
                        image: ExactAssetImage(Assets.imgDialogHomeRechargeBg),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    vipHelp(path: createPath ?? ""),
                    showVipProduct(logic, createPath: createPath),
                    showCommonProduct(logic, createPath: createPath),
                    bottomWidget(),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(end: 26.w),
              child: cancel(),
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }

  ///取消
  Widget cancel() {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: GestureDetector(
        onTap: () {
          if (widget.isBot != true) {
            Get.back();
          }
          widget.closeBtnCallBack?.call();
        },
        child: Image.asset(
          Assets.imgCloseDialog,
          matchTextDirection: true,
          width: 35,
          height: 35,
        ),
      ),
    );
  }

  ///vip help
  Widget vipHelp({required String path}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => sheetToVip(
          path: path, upid: widget.upId, isBot: widget.isBot ?? false),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 3),
                  child: Image.asset(
                    Assets.imgQuestionHelp,
                    matchTextDirection: true,
                    height: 16,
                    width: 16,
                  ),
                ),
                Text(
                  Tr.app_benefit.trArgs(["VIP"]),
                  style: const TextStyle(
                      color: Color(0xFF7F422B),
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///限时VIP商品
  Widget limitedTimeVIPProduct(PayQuickCommodite discountVip,
      {String? createPath, AreaData? area}) {
    return vipItem(discountVip, showDiscount: false, createPath: createPath);
  }

  ///普通VIP商品
  Widget commonVIPProducts(List<PayQuickCommodite> vipProducts,
      {String? createPath, AreaData? area}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vipProducts.length,
        itemBuilder: (BuildContext context, int index) {
          PayQuickCommodite item = vipProducts[index];
          return vipItem(item, createPath: createPath, area: area)
              .onVipItemLabel(index: index);
        });
  }

  Widget vipItem(PayQuickCommodite item,
      {bool showDiscount = true, String? createPath, AreaData? area}) {
    //debugPrint("vipItem====>>>  ${item.discount == null}");
    ///是否显示加成卡
    bool showAdd = (item.diamondCard != null &&
        ((item.diamondCard?.propDuration ?? 0) != 0));
    return GestureDetector(
      onTap: () => toQuickVIPPayChannel(item,
          createPath: createPath,
          upid: widget.upId,
          isBot: widget.isBot ?? false,
          area: area),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5, horizontal: 5),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: const Color(0xFF2A221B),
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Row(
              children: [
                Image.asset(
                  Assets.imgKing,
                  matchTextDirection: true,
                  width: 42,
                  height: 42,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsetsDirectional.only(start: 8, end: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            Tr.app_str_day
                                .trArgs([(item.vipDays ?? 0).toString()]),
                            textAlign: TextAlign.start,
                            maxFontSize: 14,
                            minFontSize: 6,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          if (showAdd)
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 0),
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  color: const Color(0x1FFF711E),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    Assets.imgAddCardIcon,
                                    matchTextDirection: true,
                                    width: 16,
                                    height: 17,
                                  ),
                                  Text(
                                    "+${item.diamondCard?.propDuration ?? 0}%",
                                    style: TextStyle(
                                        color: const Color(0xFFFF711E),
                                        fontFamily: AppConstants.fontsRegular,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.showValue != 0)
                              Container(
                                padding: const EdgeInsetsDirectional.only(
                                    end: 5, top: 2, bottom: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "${Tr.appSend.tr}${item.showValue}",
                                      style: TextStyle(
                                          color: const Color(0xFFFFF890),
                                          fontSize: 12,
                                          fontFamily: AppConstants.fontsRegular,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 2),
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        matchTextDirection: true,
                                        height: 14,
                                        width: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (showAdd)
                              Container(
                                //color: Colors.black12,
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 4, vertical: 2),
                                margin:
                                    const EdgeInsetsDirectional.only(start: 3),
                                child: Row(
                                  children: [
                                    Text(
                                      "+${item.diamondCard?.increaseDiamonds ?? 0}",
                                      style: TextStyle(
                                          color: const Color(0xFFF84D22),
                                          fontFamily: AppConstants.fontsBold,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 1),
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        matchTextDirection: true,
                                        height: 14,
                                        width: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 8, end: 8, top: 8, bottom: 8),
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minWidth: 60),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFF9801),
                        Color(0xFFFF4E2D),
                      ]),
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  child: AutoSizeText(
                    item.showPrice,
                    maxLines: 1,
                    minFontSize: 7,
                    maxFontSize: 14,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          if (item.showDiscount != 0 && showDiscount)
            PositionedDirectional(
                top: 3,
                start: 3,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 7, right: 7, top: 3, bottom: 3),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFFFF902A),
                        Color(0xFFFF3D27),
                      ]),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          bottomEnd: Radius.circular(10))),
                  child: Text(
                    Tr.app_off.trArgs([(item.showDiscount).toString()]),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConstants.fontsRegular,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                )),
        ],
      ),
    );
  }

  ///折扣商品
  Widget discountProduct(PayQuickCommodite discountProduct,
      {String? createPath, AreaData? area}) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsetsDirectional.only(bottom: 0),
      child: commonItem(discountProduct,
          showDiscount: true, createPath: createPath, area: area),
      /* child: LimitTime(
        duration: (discountProduct.discountDuration),
        discount: (discountProduct.discount),
        child: commonItem(discountProduct,
            showDiscount: (discountProduct.discountDuration == null),
            createPath: createPath),
      ),*/
    );
  }

  ///普通商品
  Widget commonProducts(List<PayQuickCommodite> commonProducts,
      {String? createPath, AreaData? area}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: commonProducts.length,
        itemBuilder: (BuildContext context, int index) {
          PayQuickCommodite item = commonProducts[index];
          return commonItem(item,
                  showDiscount: false,
                  createPath: createPath,
                  area: area,
                  icon: item.diamondIcon ?? Assets.imgBigDiamond)
              .onDiamondItemLabel(index: index);
        });
  }

  Widget commonItem(PayQuickCommodite item,
      {bool showDiscount = true,
      String? createPath,
      AreaData? area,
      String icon = Assets.imgBigDiamond}) {
    ///是否显示加成卡
    //item.dis
    bool showAdd = (item.diamondCard != null &&
        ((item.diamondCard?.propDuration ?? 0) != 0));
    //debugPrint("discount===>>> ${item.discount}");
    return GestureDetector(
      onTap: () => toQuickPayChannel(item,
          createPath: createPath,
          upid: widget.upId,
          isBot: widget.isBot ?? false,
          area: area),
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 55),
            margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5, horizontal: 5),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFFFFF9E8),
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  matchTextDirection: true,
                  width: 45,
                  height: 45,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsetsDirectional.only(start: 8, end: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            "${item.value ?? '--'}",
                            textAlign: TextAlign.center,
                            maxFontSize: 18,
                            minFontSize: 10,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          if (showAdd)
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 3),
                              padding: const EdgeInsetsDirectional.all(2),
                              decoration: BoxDecoration(
                                  color: const Color(0x26FD8E4E),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    Assets.imgHomeDiamondAdd,
                                    matchTextDirection: true,
                                    width: 22,
                                    height: 15,
                                  ),
                                  Text(
                                    " +${item.diamondCard?.propDuration ?? 0}%",
                                    style: TextStyle(
                                        color: const Color(0xFFFD8E4E),
                                        fontFamily: AppConstants.fontsRegular,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.showBonus != 0)
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(end: 4),
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 0, vertical: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "${Tr.appSend.tr}${item.bonus ?? 0}",
                                      style: TextStyle(
                                          color: const Color(0xFF8239FF),
                                          fontSize: 12,
                                          fontFamily: AppConstants.fontsRegular,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 1),
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        matchTextDirection: true,
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (showAdd)
                              Container(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 0, vertical: 2),
                                decoration: BoxDecoration(
                                    //color: const Color(0x80FFEBAA),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30)),
                                margin:
                                    const EdgeInsetsDirectional.only(start: 0),
                                child: Row(
                                  children: [
                                    Text(
                                      "+${item.diamondCard?.increaseDiamonds ?? 0}",
                                      style: TextStyle(
                                          color: const Color(0xFFF84D22),
                                          fontSize: 12,
                                          fontFamily: AppConstants.fontsRegular,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 1),
                                      child: Image.asset(
                                        Assets.imgDiamond,
                                        matchTextDirection: true,
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 8, end: 8, top: 8, bottom: 8),
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minWidth: 60, maxWidth: 85),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFAC53FB), Color(0xFF7934F0)]),
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: AutoSizeText(
                    item.showPrice,
                    maxLines: 1,
                    minFontSize: 7,
                    maxFontSize: 14,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          if (item.discount != null && item.discount != 0 && showDiscount)
            PositionedDirectional(
                top: 3,
                start: 3,
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 7, end: 7, top: 3, bottom: 3),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFFFF902A),
                        Color(0xFFFF3D27),
                      ]),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          bottomEnd: Radius.circular(10))),
                  child: Text(
                    Tr.app_off.trArgs([(item.discount ?? 0).toString()]),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConstants.fontsRegular,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                )),
        ],
      ),
    );
  }

  Widget bottomWidget() {
    // debugPrint("bottomWidget====>>>>> ${UserInfo.to.vipDailyDiamonds} ");
    return Container(
        //color: Colors.blueAccent,
        margin: const EdgeInsetsDirectional.only(top: 3, bottom: 7),
        constraints: BoxConstraints(maxWidth: 270.w),
        child: AutoSizeText(
          Tr.appEveryDayReward.tr,
          softWrap: true,
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 12,
          minFontSize: 8,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ));
  }

  /// vip 商品显示
  Widget showVipProduct(ChargeQuickController logic, {String? createPath}) {
    List<PayQuickCommodite> vipList = logic.vipProducts ?? [];
    if (logic.discountVip != null && (logic.vipProducts ?? []).isNotEmpty) {
      vipList = vipList.sublist(0, 1);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (logic.discountVip != null)
          limitedTimeVIPProduct(logic.discountVip ?? PayQuickCommodite(),
              createPath: createPath, area: logic.payQuickData?.area),
        if (logic.vipProducts != null)
          commonVIPProducts(vipList,
              createPath: createPath, area: logic.payQuickData?.area),
      ],
    );
  }

  /// 非VIP 商品显示
  Widget showCommonProduct(ChargeQuickController logic, {String? createPath}) {
    List<PayQuickCommodite> commonList = logic.normalProducts ?? [];
    if (logic.discountProduct != null &&
        (logic.normalProducts ?? []).length > 2) {
      commonList = commonList.sublist(0, 2);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (logic.discountProduct != null)
          discountProduct(logic.discountProduct ?? PayQuickCommodite(),
              createPath: createPath, area: logic.payQuickData?.area),
        if (logic.normalProducts != null)
          commonProducts(commonList,
              createPath: createPath, area: logic.payQuickData?.area),
      ],
    );
  }

  Widget old(ChargeQuickController logic, {String? createPath}) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsetsDirectional.only(
                start: 30, end: 30, bottom: 0, top: 0),
            decoration: BoxDecoration(
                //color: Colors.blue,
                image: DecorationImage(
              matchTextDirection: true,
              image: (Get.isEn || Get.isTh)
                  ? AssetImage(A.assets_image_rechage_quick_bg)
                  : const AssetImage(Assets.imgHomeRechargeDialogBg),
              //image: AssetImage(Assets.imgHomeRechargeDialogBg),
              // image: AssetImage(A.assets_image_rechage_quick_bg),
              //image: AssetImage(Assets.imgHomeR2),
              //315X400
              centerSlice: const Rect.fromLTRB(30, 250, 310, 350),
            )),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 13, end: 12, bottom: 5, top: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 75 + 35,
                      ),
                      vipHelp(path: createPath ?? ""),
                      showVipProduct(logic, createPath: createPath),
                      showCommonProduct(logic, createPath: createPath),
                      bottomWidget(),
                    ],
                  ),
                ),
                PositionedDirectional(top: 0, end: 0, child: cancel())
              ],
            ),
          ),
        ],
      );
}
