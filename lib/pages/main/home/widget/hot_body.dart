import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/build_select_country.dart';
import 'package:oliapro/pages/main/home/widget/hot/build_gift.dart';
import 'package:oliapro/pages/main/main/widget/keep_alive_page.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/widget/top_title.dart';

import 'hot/anchor_hot.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
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
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PositionedDirectional(
            top: 0, start: 0, end: 0, child: Image.asset(Assets.imgTabTopBg)),
        Positioned.fill(
            child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsetsDirectional.only(top: 40, end: 15, start: 5),
              child: Row(
                children: [
                  TopTitle(Tr.app_home_tab_hot.tr),
                  const Spacer(),
                  if (!AppConstants.isFakeMode) const BuildSelectCountry()
                ],
              ),
            ),
            Expanded(
                child: AppKeepAlivePage(AnchorHot(
              ctl: ctl,
            ))),
          ],
        )),
        if (!AppConstants.isFakeMode) const BuildGift(),
      ],
    );
  }

  Tab _homeTab(bool isSelect, String title) {
    return isSelect
        ? Tab(child: TopTitle(title))
        : Tab(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white60, fontSize: 20),
            ),
          );
  }
}
