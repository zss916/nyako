import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/anchor_detail/widget/tab_bar_delegate.dart';
import 'package:nyako/widget/tab/kugou_tabbar.dart';
import 'package:nyako/widget/tab/rrect_indicator.dart';

class BuildTabBar extends StatelessWidget {
  final TabController tabCtrl;
  final bool showTitle;
  const BuildTabBar(
      {super.key, required this.tabCtrl, required this.showTitle});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            decoration: BoxDecoration(
              color: showTitle ? const Color(0xFF1E1226) : Colors.transparent,
            ),
            padding: const EdgeInsets.all(5),
            child: KuGouTabBar(
              tabs: [
                Tab(text: Tr.app_details_album.tr),
                Tab(text: Tr.app_details_video.tr)
              ],
              controller: tabCtrl,
              labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: const RRecTabIndicator(
                  radius: 10,
                  insets: EdgeInsets.only(bottom: 5),
                  color: Color(0xFF8239FF)),
              indicatorMinWidth: 20,
            ),
          ),
        ),
      ),
    );
  }
}
