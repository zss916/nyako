import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/msg/index.dart';
import 'package:oliapro/pages/main/msg/widget/build_more.dart';
import 'package:oliapro/widget/top_title.dart';

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
    tabController = TabController(length: 1, vsync: this);
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
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
            Color(0xFF3C2944),
            Color(0xFF26232C),
          ])),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0, start: 0, end: 0, child: Image.asset(Assets.imgTopBgNew)),
          Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 50, start: 5, end: 10, bottom: 0),
                child: Row(
                  children: [
                    Expanded(
                        child: TabBar(
                      controller: tabController,
                      splashBorderRadius: BorderRadius.circular(5),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicator: const BoxDecoration(),
                      labelPadding:
                          const EdgeInsetsDirectional.only(start: 15, end: 15),
                      tabs: [
                        titleTab(tabIndex == 0, Tr.app_message_title.tr),
                        //titleTab(tabIndex == 1, Tr.app_home_tab_follow.tr)
                      ],
                    )),
                    if (tabIndex == 0) BuildMore(widget.logic),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                    MessageListView(context, widget.logic),
                    //const FollowList()
                  ]))
            ],
          )
        ],
      ),
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
                style: const TextStyle(color: Colors.white60, fontSize: 20),
              ),
            ),
          );
  }
}