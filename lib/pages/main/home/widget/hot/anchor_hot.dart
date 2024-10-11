import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/hot/build_banner.dart';
import 'package:oliapro/pages/main/home/widget/hot/hot_chat_button.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AnchorHot extends StatelessWidget {
  final ScrollController ctl;

  const AnchorHot({super.key, required this.ctl});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
        assignId: true,
        init: HomeLogic(),
        builder: (logic) => SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: logic.refreshCtrl,
              onRefresh: () => logic.refreshData(),
              onLoading: () => logic.loadMoreData(),
              child: buildList(logic, ctl),
            ));
  }

  Widget buildList(HomeLogic logic, ScrollController ctl) {
    // debugPrint("hot  buildList ===>>> ");
    return CustomScrollView(
      controller: ctl,
      slivers: [
        if (logic.banners.isNotEmpty)
          SliverPadding(
              padding: const EdgeInsets.only(top: 5, bottom: 0),
              sliver: banner(logic)),
        (logic.upDetailList.isEmpty && !logic.state)
            ? const SliverToBoxAdapter(
                child: BaseEmpty(),
              )
            : SliverPadding(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, start: 10, end: 10, bottom: 20),
                sliver: recommendList(logic),
              ),
      ],
    );
  }

  ///banner
  Widget banner(HomeLogic logic) {
    return SliverToBoxAdapter(
      child: BuildBanner(logic),
    );
  }

  ///recommend
  Widget recommendList(HomeLogic logic) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 10,
        childAspectRatio: 173 / 280,
        mainAxisExtent: 280,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: logic.upDetailList.length,
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: false,
        (BuildContext context, int index) {
          return RepaintBoundary(
            child: itemWidget(logic.upDetailList[index], logic),
          );
        },
      ),
    );
  }

  Widget itemWidget(HostDetail item, HomeLogic logic) {
    return GestureDetector(
      onTap: () => logic.pushAnchorDetail(item),
      child: Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(minHeight: 280),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.transparent),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage(Assets.imgAnchorDefaultIcon))),
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        //image: ExtendedNetworkImageProvider(item.portrait ?? "")
                        image: CachedNetworkImageProvider(
                          item.portrait ?? "",
                        ))),
                child: Container(
                  width: double.maxFinite,
                  height: 250,
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsetsDirectional.only(
                      start: 10, top: 8, bottom: 10, end: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: foregroundBoxDecoration,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      (!AppConstants.isFakeMode)
                          ? Expanded(
                              child: Container(
                              //color: Colors.green,
                              height: double.maxFinite,
                              alignment: AlignmentDirectional.bottomStart,
                              constraints: BoxConstraints(maxWidth: 110.w),
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        end: 2),
                                    child: Image.asset(
                                      Assets.imgDiamond,
                                      width: 16,
                                      height: 16,
                                      matchTextDirection: true,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text.rich(
                                    TextSpan(
                                      text: "",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                        fontFamily: AppConstants.fontsRegular,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: "${item.charge ?? '--'}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily:
                                                  AppConstants.fontsBold,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        TextSpan(
                                          text: Tr.app_video_time_unit.tr,
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12,
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ))
                          : const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (item.isChat) {
                            logic.callUp(item);
                          } else {
                            logic.startMsg(item.getUid);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 5, bottom: 0),
                          child: HotChatButton(isCall: item.isChat),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsetsDirectional.only(top: 5, bottom: 0, start: 6),
              child: Row(
                children: [
                  LineState(
                    item.lineState(),
                    r: 10,
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 2),
                    child: AutoSizeText(
                      item.showNickName,
                      softWrap: true,
                      minFontSize: 10,
                      maxFontSize: 14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
