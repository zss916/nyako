import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/pages/main/discover/index.dart';
import 'package:oliapro/pages/main/discover/widget/discover/item_card.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/services/storage_service.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MomentLogic>(
        id: "discover",
        init: MomentLogic(),
        initState: (_) {},
        dispose: (_) {
          StorageService.to.eventBus.fire('pauseDiscover');
        },
        builder: (logic) {
          return Center(
            child:
                (logic.dataList.isNotEmpty) ? page(logic) : const BaseEmpty(),
          );
        });
  }

  Widget page(MomentLogic logic) {
    return PageViewCtrl(
      logic: logic,
    );
  }
}

class PageViewCtrl extends StatefulWidget {
  final MomentLogic logic;

  const PageViewCtrl({super.key, required this.logic});

  @override
  State<PageViewCtrl> createState() => _DiscoverState();
}

class _DiscoverState extends State<PageViewCtrl> {
  late PageController pageCtrl;
  // late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    pageCtrl = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageCtrl,
        scrollDirection: Axis.vertical,
        itemCount: widget.logic.dataList.length,
        onPageChanged: (i) {
          //debugPrint("page index ==> ${i}");
          if (i + 1 == widget.logic.dataList.length) {
            if (mounted) {
              setState(() {
                widget.logic.loadMoreDiscoverData(loading: true);
              });
            }
          }
        },
        itemBuilder: (_, index) {
          return ItemCard(widget.logic.dataList[index], index, true);
        });
  }
}
