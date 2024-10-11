import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';
import 'package:oliapro/pages/main/me/recharge/widget/activity/build_draw.dart';
import 'package:oliapro/pages/main/me/recharge/widget/activity/build_next_pay_activity.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_diamond_add_card_anima.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_diamond_card.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_discount_product.dart';
import 'package:oliapro/pages/main/me/recharge/widget/refresh_indicator.dart';

class RechargeBody extends StatefulWidget {
  final RechargeLogic logic;

  const RechargeBody(this.logic, {super.key});

  @override
  State<RechargeBody> createState() => _RechargeBodyState();
}

class _RechargeBodyState extends State<RechargeBody> with RouteAware {
  @override
  void didPopNext() {
    super.didPopNext();
    widget.logic.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Refresh(
      isRefresh: false,
      logic: widget.logic,
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(
                start: 0,
                top: 0,
                end: 0,
                child: Container(
                  width: Get.width,
                  height: 270.h,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          colors: [
                        Color(0xFF551FB2),
                        Color(0xFF7D269A),
                      ])),
                )),
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  PositionedDirectional(
                      top: 0,
                      start: 0,
                      end: 0,
                      child: BuildDiamondCard(widget.logic)),
                  PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      end: 0,
                      top: 120,
                      child: Column(
                        children: [
                          buildAddCardTip(),
                          Expanded(
                              child: Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Color(0xFF993DE4),
                                borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(20),
                                    topEnd: Radius.circular(20))),
                            child: buildContent(),
                          ))
                        ],
                      ))
                ],
              ),
            ),
            RepaintBoundary(
              child: GetBuilder<RechargeLogic>(
                assignId: true,
                init: RechargeLogic(),
                builder: (logic) {
                  return SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      children: [
                        ...logic.animations,
                      ],
                    ),
                  );
                },
              ),
            ),
            buildDiamondAddAnima()
          ],
        ),
      ),
    );
  }

  Widget buildAddCardTip() {
    return GetBuilder<RechargeLogic>(
        id: "addRechargeCard",
        init: RechargeLogic(),
        builder: (logic) {
          return logic.propDuration == 0
              ? const SizedBox(
                  height: 20,
                )
              : Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color(0x1FFFF890),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  margin: const EdgeInsetsDirectional.only(
                      start: 15, end: 15, top: 15, bottom: 12),
                  alignment: AlignmentDirectional.bottomCenter,
                  padding: const EdgeInsetsDirectional.only(
                      top: 8, start: 10, end: 10, bottom: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.imgSmallAddCard,
                        width: 30,
                        height: 20,
                        matchTextDirection: true,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                          child: Container(
                        margin:
                            const EdgeInsetsDirectional.only(start: 4, end: 4),
                        child: Text(
                          Tr.app_add_card_tip
                              .trArgs(["${logic.propDuration}%"]),
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Color(0xFFFFF890),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ))
                    ],
                  ),
                );
        });
  }

  Widget buildContent() {
    return GetBuilder<RechargeLogic>(
      assignId: true,
      init: RechargeLogic(),
      builder: (logic) {
        return Column(
          children: [
            if (!AppConstants.isFakeMode)
              GetBuilder<RechargeLogic>(
                  init: RechargeLogic(),
                  builder: (logic) {
                    return logic.isOpenActivity
                        ? SizedBox(
                            width: double.maxFinite,
                            height: 110,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return index == 0
                                    ? const BuildDraw()
                                    : BuildNextPayActivity(
                                        logic: logic,
                                      );
                              },
                              itemCount: 2,
                              autoplay: true,
                              autoplayDelay: 5600,
                              duration: 1200,
                            ),
                          )
                        : const BuildDraw();
                  }),
            if (!AppConstants.isFakeMode)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 5),
                color: const Color(0xFFC073FF),
                width: double.maxFinite,
                height: 6,
              ),
            Expanded(
                child: CustomScrollView(
              slivers: [
                if (logic.discountProduct != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 15, start: 15, end: 15),
                      child: BuildDiscountProduct(
                        data: logic.discountProduct ?? PayQuickCommodite(),
                        logic: logic,
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 12, start: 12, end: 12, bottom: 30),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                      childAspectRatio: 113 / 185,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final payItem = logic.payList[index];
                        return InkWell(
                          onTap: () => logic.createPay(payItem),
                          child: buildItem(payItem, index),
                        );
                      },
                      childCount: logic.payList.length,
                    ),
                  ),
                ),
              ],
            )),
          ],
        );
      },
    );
  }

  Widget buildItem(PayQuickCommodite data, int index) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFE554FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: const Color(0xFF6F09AA))),
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsetsDirectional.only(
                top: 10, start: 5, end: 5, bottom: 5),
            width: double.maxFinite,
            child: Text(
              "${data.value ?? "--"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppConstants.fontsBold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //widget.logic.icon(index),
              Image.asset(
                data.diamondIcon ?? Assets.imgBigDiamond,
                width: 95,
                height: 95,
                matchTextDirection: true,
              ),
              if (data.showBonus != 0)
                PositionedDirectional(
                    top: 0,
                    start: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              matchTextDirection: true,
                              image: ExactAssetImage(
                                  Assets.imgRechargeDiamondAddBg))),
                      child: Transform.rotate(
                        angle: -25 * pi / 180,
                        child: AutoSizeText(
                          '${Tr.appSend.tr}${data.showBonus}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: 14,
                          minFontSize: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xFFFFFF1A),
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 14),
                        ),
                      ),
                    )),
            ],
          )),
          Container(
            width: double.maxFinite,
            alignment: AlignmentDirectional.center,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(20))),
            child: AutoSizeText(
              data.showPrice,
              maxFontSize: 16,
              minFontSize: 8,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xFFF447FF),
                  fontFamily: AppConstants.fontsBold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDiamondAddAnima() {
    return GetBuilder<RechargeLogic>(
        id: "addRechargeCard",
        init: RechargeLogic(),
        builder: (logic) {
          return logic.propDuration == 0
              ? const SizedBox.shrink()
              : BuildDiamondAddCardAnima(num: logic.propDuration);
        });
  }
}
