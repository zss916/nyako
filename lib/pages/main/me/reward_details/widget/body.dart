import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_balance_list_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/reward_details/index.dart';
import 'package:oliapro/pages/widget/base_top_empty.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RewardDetailsBody extends StatefulWidget {
  final RewardDetailsLogic logic;

  const RewardDetailsBody(this.logic, {super.key});

  @override
  State<RewardDetailsBody> createState() => _RewardDetailsBodyState();
}

class _RewardDetailsBodyState extends State<RewardDetailsBody> {
  @override
  void initState() {
    super.initState();
    widget.logic.refreshCtrl = RefreshController(
        initialRefresh: false, initialLoadStatus: LoadStatus.canLoading);
    widget.logic.selectMonth = widget.logic.currentMonth;
    widget.logic.lastMonth = widget.logic.currentMonth - 1;
    if (widget.logic.lastMonth <= 0) {
      widget.logic.lastMonth = 12 + widget.logic.lastMonth;
    }
    widget.logic.lLastMonth = widget.logic.currentMonth - 2;
    if (widget.logic.lLastMonth <= 0) {
      widget.logic.lLastMonth = 12 + widget.logic.lLastMonth;
    }
  }

  @override
  void dispose() {
    widget.logic.refreshCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return buildConsumptionItem(BalanceListData());
    return GetBuilder<RewardDetailsLogic>(
      assignId: true,
      builder: (logic) {
        return Column(
          children: [
            buildMonthCate(),
            Expanded(
                child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: logic.refreshCtrl,
              onRefresh: () => logic.refreshData(),
              onLoading: () => logic.loadMoreData(),
              child: buildContent(logic.balanceList, logic),
            ))
          ],
        );
      },
    );
  }

  Widget buildContent(List<BalanceListData> data, RewardDetailsLogic logic) {
    return data.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => buildConsumptionItem(data[index]),
            itemCount: data.length,
          )
        : const BaseTopEmpty();
  }

  Container buildMonthCate() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => widget.logic.changeMonth(widget.logic.currentMonth),
            child: tab(widget.logic.currentMonth == widget.logic.selectMonth,
                widget.logic.getMonth(widget.logic.currentMonth)),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => widget.logic.changeMonth(widget.logic.lastMonth),
            child: tab(widget.logic.selectMonth == widget.logic.lastMonth,
                widget.logic.getMonth(widget.logic.lastMonth)),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => widget.logic.changeMonth(widget.logic.lLastMonth),
            child: tab(widget.logic.selectMonth == widget.logic.lLastMonth,
                widget.logic.getMonth(widget.logic.lLastMonth)),
          ),
        ],
      ),
    );
  }

  Widget tab(bool isSelect, String title) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 70, maxHeight: 80),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // if (isSelect)
            //   Image.asset(
            //     Assets.imgTabIcon,
            //     matchTextDirection: true,
            //     width: 57,
            //     height: 33,
            //     color: const Color(0xFF9CEBFA),
            //   ),
            Container(
              margin: const EdgeInsetsDirectional.only(bottom: 5),
              child: AutoSizeText(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                maxFontSize: 14,
                minFontSize: 6,
                style: TextStyle(
                    color: isSelect ? Colors.white : Colors.white,
                    fontSize: 14,
                    fontWeight: isSelect ? FontWeight.bold : FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildConsumptionItem(BalanceListData data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsetsDirectional.only(start: 15, top: 15, end: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsetsDirectional.only(end: 20),
                    child: AutoSizeText(
                      data.consumptioContent(),
                      maxFontSize: 16,
                      minFontSize: 6,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              )),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 3),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${data.type == 2 ? '+' : '-'}${data.diamonds ?? '--'}",
                          style: TextStyle(
                              color: const Color(0xFFFFF890),
                              fontSize: 24,
                              fontFamily: AppConstants.fontsBold,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 2),
                          child: Image.asset(
                            Assets.imgDiamond,
                            matchTextDirection: true,
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                        Tr.app_base_balance
                            .trArgs(["${data.afterChange ?? '--'}"]),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
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
                        const TextStyle(color: Color(0xFFFFF890), fontSize: 12),
                  ),
                ))
              ],
            ),
          if (data.inviteeRepeat == 2)
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    Tr.app_unbind_google_reward.tr,
                    style:
                        const TextStyle(color: Color(0xFFFF2A48), fontSize: 12),
                  ),
                ))
              ],
            )
        ],
      ),
    );
  }
}