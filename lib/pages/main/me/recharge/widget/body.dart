import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';
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
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  BuildDiamondCard(widget.logic),
                  buildTip(),
                  Expanded(
                      child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: buildContent(),
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
            buildDiamondAddAnima(),
          ],
        ),
      ),
    );
  }

  Widget buildTip() {
    return Container(
      //color: Colors.green,
      width: double.maxFinite,
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Text(
        Tr.app_lucky_draw_tip.tr,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Color(0xFF9B989D),
            fontSize: 13,
            fontWeight: FontWeight.w400),
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
                              color: Colors.black,
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
                        ? BuildNextPayActivity(
                            logic: logic,
                          )
                        : const SizedBox.shrink();
                  }),
            Expanded(
                child: CustomScrollView(
              slivers: [
                if (logic.discountProduct != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 20, end: 20),
                      child: BuildDiscountProduct(
                        data: logic.discountProduct ?? PayQuickCommodite(),
                        logic: logic,
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 12, start: 20, end: 20, bottom: 30),
                  sliver: SliverList.separated(
                    itemCount: logic.payList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final payItem = logic.payList[index];
                      return InkWell(
                        onTap: () => logic.createPay(payItem),
                        child: buildItem(payItem, index),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 1, color: Color(0xFFEEEEEE));
                    },
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
    bool showAdd = (data.diamondCard != null &&
        ((data.diamondCard?.propDuration ?? 0) != 0));
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          //color: Colors.green.withOpacity(0.3),
          width: double.maxFinite,
          height: 80,
          child: Row(
            children: [
              Container(
                //color: Colors.blue,
                margin: const EdgeInsetsDirectional.only(end: 10),
                child: Image.asset(
                  data.diamondIcon ?? Assets.iconBigDiamond,
                  width: 32,
                  height: 32,
                  matchTextDirection: true,
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.value ?? "--"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstants.fontsBold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      if (data.showBonus != 0)
                        Row(
                          children: [
                            Text(
                              '${Tr.appSend.tr}${data.showBonus}',
                              style: const TextStyle(
                                  color: Color(0xFF9341FF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                            Image.asset(
                              Assets.iconDiamond,
                              width: 14,
                              height: 14,
                              matchTextDirection: true,
                            )
                          ],
                        ),
                      if (showAdd)
                        Container(
                          padding: const EdgeInsetsDirectional.only(start: 5),
                          decoration: BoxDecoration(
                              //color: const Color(0x80FFEBAA),
                              borderRadius:
                                  BorderRadiusDirectional.circular(30)),
                          margin: const EdgeInsetsDirectional.only(start: 0),
                          child: Row(
                            children: [
                              Text(
                                "+${data.diamondCard?.increaseDiamonds ?? 0}",
                                style: const TextStyle(
                                    color: Color(0xFFFF5112),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(start: 1),
                                child: Image.asset(
                                  Assets.iconDiamond,
                                  matchTextDirection: true,
                                  height: 14,
                                  width: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              )),
              Container(
                alignment: AlignmentDirectional.center,
                height: 30,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFF9341FF),
                    borderRadius: BorderRadiusDirectional.circular(30)),
                child: AutoSizeText(
                  data.showPrice,
                  maxFontSize: 15,
                  minFontSize: 8,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        if (showAdd)
          PositionedDirectional(
              top: 0,
              start: 0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 0),
                padding: const EdgeInsetsDirectional.only(
                    start: 6, end: 6, top: 2, bottom: 2),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFFF8929),
                      Color(0xFFFF5112),
                    ]),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(6),
                      bottomStart: Radius.zero,
                      topEnd: Radius.circular(6),
                      bottomEnd: Radius.circular(6),
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " +${data.diamondCard?.propDuration ?? 0}%",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ))
      ],
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
