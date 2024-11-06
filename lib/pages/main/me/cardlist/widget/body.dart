import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/main/me/blacklist/utils/state.dart';
import 'package:nyako/pages/main/me/cardlist/index.dart';
import 'package:nyako/pages/main/me/cardlist/widget/card_list.dart';
import 'package:nyako/pages/widget/base_empty.dart';
import 'package:nyako/pages/widget/circular_progress.dart';
import 'package:nyako/widget/tab/custom_tabbar.dart';

enum TabType { prop, reward, avatar }

class CardListBody extends StatelessWidget {
  const CardListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const SizedBox.shrink(),
            centerTitle: true,
            leadingWidth: 0,
            title: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadiusDirectional.circular(0)),
              child: KuGouTabBar(
                isScrollable: true,
                //tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const RRecTabIndicator(
                    radius: 2,
                    insets: EdgeInsets.only(bottom: 3),
                    color: Color(0xFF9341FF)),
                labelColor: Colors.black,
                tabs: [
                  Tab(text: Tr.app_mine_my_prop.tr),
                  // Tab(text: Tr.app_my_gift.tr),
                  Tab(text: Tr.appSignHeader.tr),
                ],
                labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFFB9BBCB),
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w500),
                indicatorMinWidth: 20,
              ),
            ),
          ),
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.transparent,
          body: GetBuilder<PropLogic>(
            init: PropLogic(),
            assignId: true,
            builder: (logic) {
              return buildContent(logic.state, logic);
            },
          )),
    );
  }

  Widget buildContent(int state, PropLogic logic) {
    return switch (state) {
      _ when state == Status.EMPTY.index => showEmpty(logic),
      _ when state == Status.DATA.index => TabBarView(
          children: [
            CardList(TabType.prop.index, logic),
            // CardList(TabType.reward.index, logic),
            CardList(TabType.avatar.index, logic),
          ],
        ),
      _ => const CircularProgress(),
    };
  }

  Widget showEmpty(PropLogic logic) {
    return InkWell(
      onTap: () {
        logic.state = Status.INIT.index;
        logic.update();
        Future.delayed(const Duration(seconds: 3), () {
          logic.loadData();
        });
      },
      child: const BaseEmpty(),
    );
  }
}
