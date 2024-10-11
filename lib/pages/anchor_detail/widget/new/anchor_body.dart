import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';
import 'package:oliapro/pages/anchor_detail/widget/back.dart';
import 'package:oliapro/pages/anchor_detail/widget/backgrand.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_avatar.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_follow.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_imge.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_more.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_report.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_tags.dart';
import 'package:oliapro/pages/anchor_detail/widget/build_video.dart';
import 'package:oliapro/pages/anchor_detail/widget/new/build_intro.dart';
import 'package:oliapro/pages/anchor_detail/widget/new/build_tools.dart';
import 'package:oliapro/pages/anchor_detail/widget/new/sort_list.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/widget/tab/custom_tabbar.dart';

class AnchorBody extends StatefulWidget {
  final AnchorDetailLogic logic;
  const AnchorBody({super.key, required this.logic});

  @override
  State<AnchorBody> createState() => _AnchorBodyState();
}

class _AnchorBodyState extends State<AnchorBody> with TickerProviderStateMixin {
  final ScrollController _scrollCtl = ScrollController();
  late TabController _tabCtrl;
  bool showTitle = false;
  late Function() listener;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    listener = () {
      double position = _scrollCtl.offset;
      if (position >= 80 && !showTitle) {
        setShowTitle(true);
      } else if (position < 80 && showTitle) {
        setShowTitle(false);
      }
    };
    _scrollCtl.addListener(listener);
  }

  @override
  void dispose() {
    _scrollCtl.removeListener(listener);
    _tabCtrl.dispose();
    _scrollCtl.dispose();
    super.dispose();
  }

  void setShowTitle(bool show) {
    if (mounted) {
      setState(() {
        showTitle = show;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        PositionedDirectional(
            start: 0,
            end: 0,
            top: 0,
            child: Image.asset(
              Assets.imgAnchorDetailBg,
              matchTextDirection: true,
            )),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsetsDirectional.only(start: 5, end: 0),
                      child: const Back(),
                    ),
                  ],
                ),
                actions: [
                  if (showTitle)
                    UnconstrainedBox(
                      child: BuildAvatar(widget.logic),
                    ),
                  const Spacer(),
                  if (showTitle)
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 12),
                      child: UnconstrainedBox(
                        child: BuildFollow(widget.logic),
                      ),
                    ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: BuildReport(
                      widget.logic.state.anchorId.toString(),
                      type: ReportEnum.anchorDetail.index.toString(),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: BuildMore(widget.logic),
                  ),
                ],
              ),
              body: body(),
            )),
        PositionedDirectional(
            bottom: 20,
            start: 15,
            end: 15,
            child: BuildTools(widget.logic.state.canVideo,
                widget.logic.state.charge, widget.logic)),
      ],
    );
  }

  Widget body() => NestedScrollView(
        controller: _scrollCtl,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //BuildBar(widget.logic, showTitle),
            SliverToBoxAdapter(
              child: Backgarnd(widget.logic.state.host, widget.logic),
            ),
            SliverToBoxAdapter(
              child: BuildIntro(intro: widget.logic.state.host.showIntro),
            ),
            SliverToBoxAdapter(
              child: BuildTags(widget.logic.state.host.hostTags),
            ),
            SliverToBoxAdapter(
              child: SortList(widget.logic.state.contributions, widget.logic),
            ),
          ];
        },
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.all(5),
                child: KuGouTabBar(
                  tabs: [
                    Tab(text: Tr.app_details_album.tr),
                    Tab(text: Tr.app_details_video.tr)
                  ],
                  controller: _tabCtrl,
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
              Expanded(
                  child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 15, end: 15, top: 10),
                child: TabBarView(
                  controller: _tabCtrl,
                  children: <Widget>[
                    BuildImage(widget.logic, widget.logic.state.medias),
                    BuildVideo(widget.logic, widget.logic.state.videos)
                  ],
                ),
              ))
            ],
          ),
        ),
      );

/*  Widget body2() => CustomScrollView(
        controller: _scrollCtl,
        slivers: [
          BuildBar(
            widget.logic,
            showTitle,
            d: 110,
          ),
          BuildTabBar(
            tabCtrl: _tabCtrl,
            showTitle: false,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: Get.height - (Get.statusBarHeight + 56),
              //color: Colors.red,
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 15, end: 15, top: 20),
                child: TabBarView(
                  controller: _tabCtrl,
                  children: <Widget>[
                    BuildImage(
                      widget.logic,
                      widget.logic.state.medias,
                    ),
                    BuildVideo(widget.logic, widget.logic.state.videos)
                  ],
                ),
              ),
            ),
          ),

          */ /* SliverToBoxAdapter(
            child: Container(
              padding:
                  const EdgeInsetsDirectional.only(start: 15, end: 15, top: 10),
              child: TabBarView(
                controller: _tabCtrl,
                children: <Widget>[
                  BuildImage(widget.logic, widget.logic.state.medias),
                  BuildVideo(widget.logic, widget.logic.state.videos)
                ],
              ),
            ),
          )*/ /*
        ],
      );*/
}
