import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_diamond_card.dart';
import 'package:oliapro/pages/main/me/recharge/widget/build_discount_product.dart';

class RechargeBody2 extends StatefulWidget {
  final RechargeLogic logic;

  const RechargeBody2(this.logic, {super.key});

  @override
  State<RechargeBody2> createState() => _RechargeBodyState();
}

class _RechargeBodyState extends State<RechargeBody2> with RouteAware {
  @override
  void didPopNext() {
    super.didPopNext();
    widget.logic.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              start: 0,
              top: 0,
              end: 0,
              child: Image.asset(
                Assets.imgRecharheTopBg,
                matchTextDirection: true,
                fit: BoxFit.fitWidth,
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
                    top: 170,
                    child: Column(
                      children: [
                        buildTip(),
                        Expanded(
                            child: Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.black,
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
        ],
      ),
    );
  }

  Widget buildAddCardTip() {
    return GetBuilder<RechargeLogic>(
        id: "addRechargeCard",
        init: RechargeLogic(),
        builder: (logic) {
          return logic.propDuration == 0
              ? const SizedBox.shrink()
              : Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color(0x4DFFF890),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  margin: const EdgeInsetsDirectional.only(
                      start: 15, end: 15, top: 15),
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

  Widget buildTip() {
    return Container(
      //color: Colors.green,
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
      child: Text(
        Tr.app_lucky_draw_tip.tr,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Color(0xFFC3A0FF),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildContent() {
    return GetBuilder<RechargeLogic>(
      assignId: true,
      init: RechargeLogic(),
      builder: (logic) {
        return Column(
          children: [
            buildAddCardTip(),
            if (logic.discountProduct != null)
              Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 15, start: 15, end: 15),
                child: BuildDiscountProduct(
                  data: logic.discountProduct!,
                  logic: logic,
                ),
              ),
            Expanded(
                child: GridView.builder(
                    padding: const EdgeInsetsDirectional.only(
                        top: 20, start: 5, end: 5, bottom: 30),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 165 / 155,
                    ),
                    itemCount: logic.payList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final payItem = logic.payList[index];
                      return InkWell(
                        onTap: () => logic.createPay(payItem),
                        child: buildItem(payItem, index),
                      );
                    }))
          ],
        );
      },
    );
  }

  Widget buildItem(PayQuickCommodite data, int index) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin: const EdgeInsetsDirectional.only(bottom: 20),
          padding: const EdgeInsetsDirectional.only(
              top: 15, bottom: 10, start: 10, end: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF2B1A36),
            border: Border.all(
                width: 1,
                color: (data.discount != null)
                    ? const Color(0x80F447FF)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              //widget.logic.icon(index),
              Image.asset(
                data.diamondIcon ?? Assets.imgBigDiamond,
                width: 64,
                height: 64,
                matchTextDirection: true,
              ),
              const Spacer(),
              Text(
                "${data.value ?? "--"}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const SizedBox(height: 28),
            ],
          ),
        ),
        if (data.discount != null)
          PositionedDirectional(
            top: 0,
            start: 0,
            child: Container(
              width: 70,
              height: 24,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF902A), Color(0xFFFF3D27)],
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                ),
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(14),
                    bottomEnd: Radius.circular(14)),
              ),
              child: Center(
                child: AutoSizeText(
                  Tr.app_off.trArgs(["${data.discount}"]),
                  maxLines: 1,
                  maxFontSize: 12,
                  minFontSize: 8,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        if (data.showBonus != 0)
          PositionedDirectional(
              top: 0,
              end: 0,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: const BoxDecoration(
                    color: Color(0xFF523068),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(8),
                        topEnd: Radius.circular(18),
                        bottomStart: Radius.circular(8),
                        bottomEnd: Radius.zero)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Tr.appSend.tr}${data.showBonus}',
                      style: const TextStyle(
                          color: Color(0xFFFFF890), fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 2),
                      child: Image.asset(
                        Assets.imgDiamond,
                        width: 14,
                        height: 14,
                        matchTextDirection: true,
                      ),
                    ),
                  ],
                ),
              )),
        PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: Container(
              height: 38,
              constraints: const BoxConstraints(
                minWidth: 94,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular((20)),
                  gradient: const LinearGradient(colors: [
                    Color(0xFFAC53FB),
                    Color(0xFF7934F0),
                  ])),
              child: Center(
                child: AutoSizeText(
                  data.showPrice,
                  maxFontSize: 14,
                  minFontSize: 7,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
              ),
            )),
      ],
    );
  }
}
