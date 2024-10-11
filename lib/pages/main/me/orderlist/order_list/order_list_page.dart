import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_order_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/orderlist/order_list/order_list_logic.dart';
import 'package:oliapro/pages/widget/base_top_empty.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_format_util.dart';
import 'package:oliapro/widget/tab/rrect_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderListPage extends GetView<OrderListLogic> {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //return buildOrderItem(OrderData(), OrderListLogic());
    return GetBuilder<OrderListLogic>(
        initState: (_) {
          safeFind<OrderListLogic>()?.onRefresh();
        },
        init: OrderListLogic(),
        builder: (logic) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                leading: const SizedBox.shrink(),
                centerTitle: true,
                leadingWidth: 0,
                titleSpacing: 0,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadiusDirectional.circular(0)),
                  child: TabBar(
                    onTap: (index) {
                      logic.onRefresh(index: index);
                    },
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const RRecTabIndicator(
                        radius: 2,
                        insets: EdgeInsets.only(bottom: 0),
                        color: Colors.transparent),
                    tabs: [
                      tab(
                        isSelect: logic.chooseIndex == 0,
                        text: Tr.app_all_order.tr,
                      ),
                      tab(
                        isSelect: logic.chooseIndex == 1,
                        text: Tr.app_obligation.tr,
                      ),
                      tab(
                        isSelect: logic.chooseIndex == 2,
                        text: Tr.app_order_completion.tr,
                      ),
                      tab(
                        isSelect: logic.chooseIndex == 3,
                        text: Tr.app_order_failed.tr,
                      ),
                    ],
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2A272A),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              extendBodyBehindAppBar: false,
              backgroundColor: Colors.transparent,
              body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.transparent,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: logic.enablePullUp,
                  controller: logic.refreshCtr,
                  onRefresh: logic.onRefresh,
                  onLoading: logic.onLoading,
                  child: logic.dataList.isEmpty
                      ? const BaseTopEmpty()
                      : ListView.builder(
                          itemCount: logic.dataList.length,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return buildOrderItem(logic.dataList[index], logic);
                          }),
                ),
              ),
            ),
          );
        });
  }

  Widget buildOrderItem(OrderData data, OrderListLogic logic) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        logic.pushOrderDetail(data);
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
          color: Colors.white10,
          gradient: const LinearGradient(
              colors: [Color(0xFFFFE3ED), Color(0xFFFFF2F6)]),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              data.titleStr(),
              maxFontSize: 12,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: TextStyle(color: data.txtColor(), fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (data.vipDays == null)
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 3),
                              child: Image.asset(
                                Assets.imgDiamond,
                                width: 25,
                                height: 25,
                                matchTextDirection: true,
                              ),
                            ),
                            AutoSizeText(
                              "+${data.diamonds ?? '--'}",
                              maxFontSize: 24,
                              minFontSize: 12,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: AppConstants.fontsBold,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            if (data.vipDays != null)
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(end: 5),
                                child: Image.asset(
                                  Assets.imgKing,
                                  matchTextDirection: true,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            Expanded(
                              child: AutoSizeText(
                                (data.vipDays == null)
                                    ? "+${data.diamonds ?? '--'}"
                                    : Tr.app_str_day
                                        .trArgs(["${data.vipDays ?? 0}"]),
                                maxFontSize: 24,
                                minFontSize: 12,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: AppConstants.fontsBold,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      if (data.showDiamond != 0 && data.vipDays != null)
                        Container(
                            margin: const EdgeInsetsDirectional.only(start: 5),
                            child: Row(
                              children: [
                                Text(
                                  "+${(data.showDiamond)}",
                                  style: TextStyle(
                                      fontFamily: AppConstants.fontsRegular,
                                      color: const Color(0xFFFFF890),
                                      fontSize: 14),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 3),
                                  child: Image.asset(
                                    Assets.imgDiamond,
                                    matchTextDirection: true,
                                    width: 14,
                                    height: 14,
                                  ),
                                )
                              ],
                            )),
                    ],
                  ),
                ),
                Text(
                  "${AppFormatUtil.currencyToSymbol(data.currencyCode)} ${data.currencyFee != null ? data.currencyFee! / 100.0 : '--'}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${Tr.app_order_channelName.tr}: ${data.channelName}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  '${Tr.app_order_orderNo.tr}:',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  '${data.orderNo}',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppConstants.fontsRegular,
                      fontSize: 12),
                ),
              ],
            ),
            Container(
              height: 1,
              color: Colors.white,
              margin: const EdgeInsets.only(top: 20, bottom: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Tr.app_order_one_details.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Image.asset(
                  matchTextDirection: true,
                  Assets.imgArrowEnd,
                  width: 16,
                  height: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Tab tab({required bool isSelect, required String text}) {
    return isSelect
        ? Tab(
            child: AutoSizeText(
              text,
              maxLines: 1,
              maxFontSize: 17,
              minFontSize: 8,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Tab(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          );
  }
}
