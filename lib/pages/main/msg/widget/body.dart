import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/calllist/index.dart';
import 'package:nyako/pages/main/msg/index.dart';
import 'package:nyako/pages/main/msg/widget/build_more.dart';
import 'package:nyako/routes/a_routes.dart';
import 'package:nyako/widget/top_title.dart';

import 'message.dart';

class MsgListBody extends StatefulWidget {
  final MsgListLogic logic;

  const MsgListBody(this.logic, {super.key});

  @override
  State<MsgListBody> createState() => _MsgListBodyState();
}

class _MsgListBodyState extends State<MsgListBody>
    with RouteAware, TickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index == tabController.animation?.value) {
        if (mounted) {
          setState(() {
            tabIndex = tabController.index;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    widget.logic.reloadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SizedBox(
            width: Get.width,
            height: Get.height,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.only(top: 90),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: MessageListView(context, widget.logic),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.only(top: 90),
                    decoration: const BoxDecoration(color: Color(0xFFD8D8D8)),
                    child: const ChatRecordPage(),
                  )
                ])),
        Container(
          padding: const EdgeInsetsDirectional.only(
              top: 40, start: 5, end: 10, bottom: 0),
          child: Row(
            children: [
              Expanded(
                  child: TabBar(
                controller: tabController,
                splashBorderRadius: BorderRadius.circular(5),
                isScrollable: true,
                dividerHeight: 0,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                indicatorWeight: 0,
                indicator: const BoxDecoration(),
                labelPadding:
                    const EdgeInsetsDirectional.only(start: 15, end: 15),
                tabs: [
                  titleTab(tabIndex == 0, Tr.app_message_title.tr),
                  titleTab(tabIndex == 1, Tr.app_my_call_list.tr)
                ],
              )),
              toFollowList(),
              if (tabIndex == 0) BuildMore(widget.logic),
            ],
          ),
        ),
      ],
    );
  }

  Tab titleTab(bool isSelect, String title) {
    return isSelect
        ? Tab(child: TopTitle(title))
        : Tab(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 3, left: 0, right: 0),
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: AppConstants.fontsBold,
                    color: const Color(0xFFB9BBCB),
                    fontSize: 20),
              ),
            ),
          );
  }

  Widget toFollowList() => InkWell(
        onTap: () => ARoutes.toFollow(),
        child: Container(
          margin: const EdgeInsetsDirectional.only(start: 5, end: 6),
          child: Image.asset(
            Assets.iconFollowList,
            matchTextDirection: true,
            width: 24,
            height: 24,
          ),
        ),
      );
}
