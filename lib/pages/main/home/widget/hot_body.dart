import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/pages/main/home/index.dart';
import 'package:nyako/pages/main/home/widget/hot/build_gift.dart';
import 'package:nyako/pages/main/main/widget/keep_alive_page.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_extends.dart';
import 'package:nyako/widget/top_title.dart';

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

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    areaEvent = AppEventBus.eventBus.on<AreaData>().listen((event) {
      ctl.jumpTo(0);
      safeFind<HomeLogic>()?.areaRefreshData((event.areaCode ?? -1));
    });
  }

  @override
  void dispose() {
    areaEvent.cancel();
    ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned.fill(
              child: GetBuilder<HomeLogic>(
                  assignId: true,
                  init: HomeLogic(),
                  builder: (logic) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              top: 10, end: 0, start: 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        start: 12),
                                    child: TopTitle(Tr.app_home_tab_hot.tr),
                                  ),
                                  const Spacer()
                                ],
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: 50,
                                child: ListView.separated(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 10, end: 10, top: 5, bottom: 10),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic.areaList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          InkWell(
                                    onTap: () {
                                      bool isChoose =
                                          logic.areaList[index].showCanChoose;

                                      if (isChoose) {
                                        for (int i = 0;
                                            i < logic.areaList.length;
                                            i++) {
                                          logic.areaList[i].isSelect =
                                              i == index;
                                        }
                                        logic.areaCode =
                                            (logic.areaList[index].areaCode ??
                                                    -1)
                                                .toString();

                                        if (logic.areaList[index].areaCode !=
                                            logic.currentArea?.areaCode) {
                                          ctl.jumpTo(0);
                                          logic.update();
                                          logic.loadDta(1,
                                              areaCode: (logic.areaList[index]
                                                          .areaCode ??
                                                      -1)
                                                  .toString(),
                                              showLoading: true);
                                        }
                                      } else {
                                        /// toVip
                                        if (!AppConstants.isFakeMode) {
                                          sheetToVip(
                                              path: ChargePath
                                                  .recharge_choose_area,
                                              index: 3);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 28,
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 12),
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          color:
                                              logic.areaList[index].isSelect ==
                                                      true
                                                  ? const Color(0xFF625969)
                                                  : const Color(0xFFF5F4F6),
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  8)),
                                      child: Text(
                                        logic.areaList[index].title ?? "--",
                                        style: TextStyle(
                                            color: logic.areaList[index]
                                                    .showCanChoose
                                                ? (logic.areaList[index]
                                                            .isSelect ==
                                                        true
                                                    ? Colors.white
                                                    : Colors.black)
                                                : const Color(0x802D2A30),
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const VerticalDivider(
                                    width: 10,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: AppKeepAlivePage(AnchorHot(
                            ctl: ctl,
                            logic: logic,
                          )),
                        )
                      ],
                    );
                  })),
          if (!AppConstants.isFakeMode && tabIndex == 0) const BuildGift(),
        ],
      ),
    );
  }
}
