import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/charge_path.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/anchor_detail/index.dart';
import 'package:nyako/pages/anchor_detail/widget/build_more.dart';
import 'package:nyako/pages/anchor_detail/widget/build_report.dart';
import 'package:nyako/pages/anchor_detail/widget/build_tags.dart';
import 'package:nyako/pages/anchor_detail/widget/build_vip_image.dart';
import 'package:nyako/pages/anchor_detail/widget/follow_btn.dart';
import 'package:nyako/pages/anchor_detail/widget/new/build_contribute.dart';
import 'package:nyako/pages/anchor_detail/widget/new/build_tools.dart';
import 'package:nyako/pages/widget/age_and_sex_widget.dart';
import 'package:nyako/pages/widget/app_preview.dart';
import 'package:nyako/pages/widget/base_top_empty.dart';
import 'package:nyako/pages/widget/line_state.dart';
import 'package:nyako/utils/app_event_bus.dart';
import 'package:nyako/utils/app_loading.dart';
import 'package:nyako/widget/base_app_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AnchorBody extends StatefulWidget {
  final AnchorDetailLogic logic;
  const AnchorBody({super.key, required this.logic});

  @override
  State<AnchorBody> createState() => _AnchorBodyState();
}

class _AnchorBodyState extends State<AnchorBody> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Scaffold(
          appBar: BaseAppBar(
            isDark: false,
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                alignment: AlignmentDirectional.center,
                child: BuildReport(
                  widget.logic.state.anchorId.toString(),
                  type: ReportEnum.anchorDetail.index.toString(),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: BuildMore(widget.logic),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: SlidingUpPanel(
            maxHeight: Get.height - 80,
            minHeight: 340,
            borderRadius: const BorderRadiusDirectional.vertical(
                top: Radius.circular(24)),
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  width: Get.width,
                  height: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ExactAssetImage(Assets.iconAnchorDefault))),
                  child: Container(
                    width: Get.width,
                    height: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                widget.logic.state.portrait))),
                    foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            stops: [0, 0.3],
                            colors: [Color(0x4D000000), Colors.transparent])),
                  ),
                )
              ],
            ),
            padding:
                const EdgeInsetsDirectional.only(top: 20, start: 20, end: 20),
            panelBuilder: (ScrollController sc) => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnconstrainedBox(
                          child: Container(
                            height: 20,
                            margin: const EdgeInsetsDirectional.only(bottom: 5),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadiusDirectional.circular(10)),
                            padding: const EdgeInsetsDirectional.only(
                                start: 6, end: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LineState(
                                  widget.logic.state.lineState,
                                  r: 8,
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 3),
                                  child: AutoSizeText(
                                    widget.logic.state.host.stateStr,
                                    style: TextStyle(
                                        fontFamily: AppConstants.fontsRegular,
                                        color: Colors.white,
                                        fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 10),
                          width: double.maxFinite,
                          //color: Colors.cyanAccent,
                          child: Text(
                            widget.logic.state.nickname,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AgeAndSexWidget(
                                  widget.logic.state.host.showBirthday),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.logic.state.host.getUid));
                                  AppLoading.toast(Tr.app_base_success.tr);
                                },
                                child: Container(
                                  height: 20,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 4),
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 8),
                                  alignment: AlignmentDirectional.centerStart,
                                  decoration: BoxDecoration(
                                      color: const Color(0x1A3BC2FF),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(5)),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                end: 2),
                                        child: Image.asset(
                                            Assets.iconIdSmallIcon,
                                            width: 14,
                                            height: 14),
                                      ),
                                      Text(
                                        widget.logic.state.host.showId,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: const Color(0xFF3BC2FF),
                                            fontSize: 13,
                                            fontFamily:
                                                AppConstants.fontsRegular,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                    GestureDetector(
                      onTap: () => widget.logic.follow(),
                      child: FollowBtn(
                          isFollowed: widget.logic.state.host.isFollowed),
                    )
                  ],
                ),
                Expanded(
                    child: CustomScrollView(
                  controller: sc,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            top: 12, bottom: 14),
                        width: double.maxFinite,
                        child: Text(
                          widget.logic.state.host.showIntro,
                          style: TextStyle(
                              color: const Color(0xFF9B989D),
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: BuildTags(widget.logic.state.host.hostTags),
                    ),
                    SliverToBoxAdapter(
                      child: BuildContribute(
                          contributions: widget.logic.state.contributions,
                          anchorId: widget.logic.state.anchorId.toString(),
                          host: widget.logic.state.host),
                    ),
                    SliverAppBar(
                      pinned: true,
                      primary: false,
                      //toolbarHeight: 0,
                      leadingWidth: 0,
                      elevation: 0,
                      titleSpacing: 0,
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      leading: const SizedBox.shrink(),
                      title: Container(
                        margin:
                            const EdgeInsetsDirectional.only(bottom: 0, top: 0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 2),
                              child: Image.asset(
                                Assets.iconAlbum,
                                width: 26,
                                height: 26,
                                matchTextDirection: true,
                              ),
                            ),
                            Text(
                              Tr.app_details_album.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppConstants.fontsBold,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    (widget.logic.state.data.isEmpty)
                        ? const SliverToBoxAdapter(
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                BaseTopEmpty(
                                  h: 50,
                                ),
                              ],
                            ),
                          )
                        : SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 9,
                              childAspectRatio: 110 / 160,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                childCount: widget.logic.state.data.length,
                                (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if (widget.logic.state.userVip) {
                                    showAnchorDetailPreview(
                                        widget.logic.state.data, context,
                                        initIndex: index,
                                        uid: widget.logic.state.host.getUid,
                                        data: widget.logic.state.host);
                                  } else {
                                    if (widget.logic.state.data[index]
                                            .vipVisible ==
                                        1) {
                                      sheetToVip(
                                          path: ChargePath
                                              .recharge_vip_dialog_anchor_details,
                                          index: 4);
                                    } else {
                                      List<HostMedia> arr = widget
                                          .logic.state.data
                                          .where((element) =>
                                              element.vipVisible == 0)
                                          .toList();
                                      int i = arr.indexWhere((element) =>
                                          element.mid ==
                                          widget.logic.state.data[index].mid);
                                      // debugPrint("aaa===>>> $i,${arr[i].path},${arr[i].isSelected}");
                                      showAnchorDetailPreview(arr, context,
                                          initIndex: i,
                                          uid: widget.logic.state.host.getUid,
                                          data: widget.logic.state.host);
                                    }
                                  }
                                },
                                child: _albumItem(
                                    widget.logic.state.data[index].showPath,
                                    isVip: (widget.logic.state.data[index]
                                            .vipVisible ==
                                        1),
                                    isPhoto:
                                        widget.logic.state.data[index].type ==
                                            0),
                              );
                            })),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 120,
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
        PositionedDirectional(
            bottom: 20,
            start: 15,
            end: 15,
            child: BuildTools(widget.logic.state.canVideo,
                widget.logic.state.charge, widget.logic)),
      ],
    );
  }

  Widget _albumItem(String path, {bool isVip = true, bool isPhoto = false}) {
    // debugPrint("_albumItem path ==>>> $isPhoto,====>> $path");
    //cachedImage(path,fit: BoxFit.cover,type: 5,width: double.maxFinite,height: double.maxFinite,)
    return !AppConstants.isFakeMode
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (isVip && (!widget.logic.state.userVip))
                BuildVipImage()
              else
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  clipBehavior: Clip.hardEdge,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    //color: const Color(0x805138FF),
                    image: const DecorationImage(
                        image: ExactAssetImage(Assets.iconAnchorDefault),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundDecoration: BoxDecoration(
                      // color: const Color(0x805138FF),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(path),
                          fit: BoxFit.cover)),
                ),
              if (!isPhoto)
                PositionedDirectional(
                  top: 5,
                  end: 5,
                  child: Image.asset(
                    Assets.iconVideoPlay,
                    matchTextDirection: true,
                    width: 24,
                    height: 24,
                  ),
                ),
              if (isVip)
                PositionedDirectional(
                  top: 5,
                  start: 4,
                  child: Image.asset(
                    Assets.iconNyakoVipIc,
                    width: 40,
                    height: 16,
                  ),
                ),
            ],
          )
        : const SizedBox.shrink();
  }
}
