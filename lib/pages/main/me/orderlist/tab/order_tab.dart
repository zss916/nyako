import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/routes/route_name.dart';
import 'package:oliapro/widget/base_app_bar.dart';
import 'package:oliapro/widget/tab/kugou_tabbar.dart';
import 'package:oliapro/widget/tab/rrect_indicator.dart';

import '../../../../../routes/app_pages.dart';
import '../cost_list/cost_list_page.dart';
import '../order_list/order_list_page.dart';

@RouteName(AppPages.orderTab)
class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<StatefulWidget> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        RouteAware {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppPages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    controller.dispose();
    AppPages.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      appBar: BaseAppBar(
        titleWidget: buildTabBar(),
      ),
      extendBodyBehindAppBar: true,
      body: TabBarView(
        controller: controller,
        children: const [CostListPage(), OrderListPage()],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  KuGouTabBar buildTabBar() => KuGouTabBar(
        tabs: [
          Tab(
            text: Tr.app_consumption_detail.tr,
          ),
          Tab(
            text: Tr.app_order_details.tr,
          )
        ],
        isScrollable: true,
        padding: EdgeInsets.zero,
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        indicator: const RRecTabIndicator(
            radius: 2,
            insets: EdgeInsets.only(bottom: 5),
            color: Colors.transparent),
        indicatorMinWidth: 24,
      );
}
