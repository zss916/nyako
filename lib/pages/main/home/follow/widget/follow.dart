import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/pages/main/home/follow/widget/follow_item.dart';
import 'package:nyako/pages/main/home/index.dart';
import 'package:nyako/pages/main/me/blacklist/utils/state.dart';
import 'package:nyako/pages/widget/base_empty.dart';
import 'package:nyako/pages/widget/circular_progress.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowList extends StatelessWidget {
  const FollowList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      init: HomeLogic(),
      builder: (logic) {
        return SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          controller: logic.refreshCtrlF,
          onRefresh: () => logic.refreshFollowData(),
          onLoading: () => logic.loadMoreFollowData(),
          child: buildContent(logic.followState, logic),
        );
      },
    );
  }

  Widget buildContent(int state, HomeLogic logic) {
    return switch (state) {
      _ when state == Status.EMPTY.index => const BaseEmpty(),
      _ when state == Status.DATA.index => buildList(logic),
      _ => const CircularProgress(),
    };
  }

  Widget buildList(HomeLogic logic) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
      itemBuilder: (context, index) =>
          FollowItem(data: logic.followList[index], logic: logic, index: index),
      itemCount: logic.followList.length,
      cacheExtent: 118,
      shrinkWrap: true,
      //physics: const ClampingScrollPhysics(),
      addRepaintBoundaries: false,
      addAutomaticKeepAlives: false,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 12, color: Colors.transparent);
      },
    );
  }
}
