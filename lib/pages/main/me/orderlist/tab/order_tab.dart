import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/main/me/orderlist/cost_list/cost_list_page.dart';
import 'package:nyako/pages/main/me/orderlist/order_list/order_list_page.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/widget/base_app_bar.dart';
import 'package:nyako/widget/tab/kugou_tabbar.dart';
import 'package:nyako/widget/tab/rrect_indicator.dart';

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
      backgroundColor: const Color(0xFFF4F5F6),
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
        labelColor: const Color(0xFF9341FF),
        unselectedLabelColor: Colors.black,
        labelStyle: TextStyle(
            fontSize: 21,
            color: const Color(0xFF9341FF),
            fontFamily: AppConstants.fontsBold,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            fontSize: 21,
            color: Colors.black,
            fontFamily: AppConstants.fontsBold,
            fontWeight: FontWeight.bold),
        indicator: const RRecTabIndicator(
            radius: 2,
            insets: EdgeInsets.only(bottom: 5),
            color: Colors.transparent),
        indicatorMinWidth: 24,
      );
}
