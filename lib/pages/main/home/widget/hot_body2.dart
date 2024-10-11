import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/follow/widget/follow.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/build_select_country.dart';
import 'package:oliapro/pages/main/home/widget/hot/build_gift.dart';
import 'package:oliapro/pages/main/main/widget/keep_alive_page.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/widget/top_title.dart';

import 'hot/anchor_hot.dart';

class HomeBody2 extends StatefulWidget {
  const HomeBody2({super.key});
  @override
  State<HomeBody2> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody2>
    with RouteAware, TickerProviderStateMixin {
  late ScrollController ctl = ScrollController();
  late final StreamSubscription<AreaData> areaEvent;
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
    areaEvent = AppEventBus.eventBus.on<AreaData>().listen((event) {
      ctl.jumpTo(0);
      safeFind<HomeLogic>()?.areaRefreshData((event.areaCode ?? -1));
    });
  }

  @override
  void dispose() {
    areaEvent.cancel();
    ctl.dispose();
    tabController.dispose();
    super.dispose();
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
          Positioned.fill(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 40, end: 15, start: 5),
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
                          const EdgeInsetsDirectional.only(start: 5, end: 15),
                      tabs: [
                        _homeTab(tabIndex == 0, Tr.app_home_tab_hot.tr),
                        _homeTab(tabIndex == 1, Tr.app_home_tab_follow.tr)
                      ],
                    )),
                    if (!AppConstants.isFakeMode && tabIndex == 0)
                      const BuildSelectCountry()
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                // physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  AppKeepAlivePage(AnchorHot(
                    ctl: ctl,
                  )),
                  const FollowList()
                ],
              )),
            ],
          )),
          if (!AppConstants.isFakeMode && tabIndex == 0) const BuildGift(),
        ],
      ),
    );
  }

  Tab _homeTab(bool isSelect, String title) {
    return isSelect
        ? Tab(child: TopTitle(title))
        : Tab(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 10),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white60, fontSize: 18),
                  ),
                )
              ],
            ),
          );
  }
}
