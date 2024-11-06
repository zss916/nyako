import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_order_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/orderlist/cost_list/cost_list_logic.dart';
import 'package:nyako/pages/widget/base_top_empty.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/widget/tab/rrect_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CostListPage extends GetView<CostListLogic> {
  const CostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //return buildConsumptionItem(CostBean());
    return GetBuilder<CostListLogic>(
        init: CostListLogic(),
        initState: (_) {
          safeFind<CostListLogic>()?.onRefresh(index: 0);
        },
        builder: (logic) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const SizedBox.shrink(),
                centerTitle: true,
                leadingWidth: 0,
                title: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(0)),
                  child: TabBar(
                    onTap: (index) {
                      logic.onRefresh(index: index);
                    },
                    isScrollable: false,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const RRecTabIndicator(
                        radius: 2,
                        insets: EdgeInsets.only(bottom: 0),
                        color: Colors.transparent),
                    labelColor: Colors.black,
                    tabs: [
                      tab(
                        isSelect: logic.choosedIndex == 0,
                        text: logic.getMonth(logic.currentMonthInt),
                      ),
                      tab(
                        isSelect: logic.choosedIndex == 1,
                        text: logic.getMonth(logic.lastMoth),
                      ),
                      tab(
                        isSelect: logic.choosedIndex == 2,
                        text: logic.getMonth(logic.lastlastMoth),
                      ),
                    ],
                    labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
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
                  enablePullUp: true,
                  controller: logic.refreshCtr,
                  onRefresh: logic.onRefresh,
                  onLoading: logic.onLoading,
                  child: logic.dataList.isEmpty
                      ? const BaseTopEmpty()
                      : ListView.builder(
                          itemCount: logic.dataList.length,
                          itemBuilder: (context, index) {
                            return buildConsumptionItem(logic.dataList[index]);
                          }),
                ),
              ),
            ),
          );
        });
  }

  Container buildConsumptionItem(CostBean data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsetsDirectional.only(
          start: 15, top: 7, end: 15, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 210,
                        child: AutoSizeText(
                          data.consumptioContent(),
                          softWrap: true,
                          maxFontSize: 16,
                          minFontSize: 6,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        (data.createdAt != null)
                            ? formatDate(
                                DateTime.fromMillisecondsSinceEpoch(
                                    data.createdAt!),
                                [yyyy, '.', mm, '.', dd, '-', HH, ':', nn])
                            : "--",
                        style: const TextStyle(
                            color: Color(0xFF999999), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${data.type == 2 ? '+' : '-'}${data.diamonds ?? '--'}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 2),
                        child: Image.asset(
                          Assets.iconDiamond,
                          matchTextDirection: true,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Text(
                      Tr.app_base_balance
                          .trArgs(["${data.afterChange ?? '--'}"]),
                      style: TextStyle(
                          fontFamily: AppConstants.fontsRegular,
                          color: const Color(0xFF999999),
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (data.inviteeRepeat == 1)
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    Tr.app_re_registration_no_reward.tr,
                    style:
                        const TextStyle(color: Color(0xFFBB06FF), fontSize: 12),
                  ),
                ))
              ],
            )
        ],
      ),
    );
  }

  Tab tab({required bool isSelect, required String text}) {
    return isSelect
        ? Tab(
            child: AutoSizeText(
              text,
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 8,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          )
        : Tab(
            child: Text(
              text,
              style: const TextStyle(
                  color: Color(0xFF9B989D),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          );
  }
}
