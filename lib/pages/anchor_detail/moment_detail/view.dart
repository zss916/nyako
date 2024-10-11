part of 'index.dart';

@RouteName(AppPages.momentDetail)
class MomentDetailPage extends GetView<MomentDetailLogic> {
  const MomentDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MomentDetailLogic>(
        init: MomentDetailLogic(),
        builder: (logic) {
          return Scaffold(
            appBar: BaseAppBar(
              leading: toBack,
              actions: [toReport(logic)],
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xFF040706),
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned.fill(
                    child: PageView.builder(
                        controller:
                            PageController(initialPage: logic.pageIndex),
                        itemCount: logic.momentDetail.medias?.length ?? 0,
                        onPageChanged: (i) {
                          logic.pageIndex = i;
                          logic.update();
                        },
                        itemBuilder: (_, index) {
                          MomentMedia media = logic.momentDetail.medias![index];

                          /*return PhotoView(
                              imageProvider: CachedNetworkImageProvider(
                                  media.mediaUrl ?? ""));*/
                          return Container(
                            width: Get.width,
                            height: Get.height,
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        media.mediaUrl ?? ""))),
                          );
                        })),
                if (logic.momentDetail.medias != null &&
                    logic.momentDetail.medias!.length > 1)
                  PositionedDirectional(
                      start: 0,
                      end: 0,
                      top: 68,
                      child: SizedBox(
                        height: 6,
                        child: DotsIndicator(
                          dotsCount: logic.momentDetail.medias!.length,
                          position: logic.pageIndex,
                          decorator: DotsDecorator(
                            size: const Size.square(10),
                            activeSize: const Size(50.0, 5.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0)),
                            activeColor: Colors.white,
                            color: Colors.white.withOpacity(0.5),
                            spacing: const EdgeInsets.only(right: 9),
                          ),
                        ),
                      )),
                PositionedDirectional(
                    start: 0,
                    end: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 10, start: 15, end: 15, top: 40),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.3),
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 6),
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  color: const Color(0x7F000000),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  children: [
                                    AppNetImage(
                                      logic.momentDetail.portrait ?? '',
                                      width: 32,
                                      height: 32,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.transparent,
                                                width: 1),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LimitedBox(
                                          maxWidth: 100,
                                          child: Text(
                                            logic.momentDetail.showNick,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 1,
                                          ),
                                        ),
                                        /*Text(
                                          "ID:${logic.momentDetail.showID}",
                                          style: const TextStyle(
                                              color: Color(0xFFB4B4B4),
                                              fontSize: 12),
                                        )*/
                                      ],
                                    ),
                                    if (logic.momentDetail.followed != 1)
                                      const SizedBox(
                                        width: 4,
                                      ),
                                    if (logic.momentDetail.followed != 1)
                                      GestureDetector(
                                        onTap: () {
                                          logic.handleFollow();
                                        },
                                        child: Image.asset(
                                          Assets.imgFollow,
                                          matchTextDirection: true,
                                          width: 40,
                                          height: 30,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                          if (logic.momentDetail.content != null &&
                              logic.momentDetail.content!.isNotEmpty)
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                  bottom: 15, start: 10),
                              child: Text(
                                logic.momentDetail.content!,
                                style: const TextStyle(shadows: [
                                  Shadow(color: Colors.red, blurRadius: 3)
                                ], color: Colors.white, fontSize: 16),
                              ),
                            ),
                          SizedBox(
                            width: double.maxFinite,
                            child: toBuildCallButton(logic.momentDetail),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          );
        });
  }

  Widget toReport(MomentDetailLogic logic) => GestureDetector(
        onTap: () {
          ARoutes.toReport(
              uid: logic.momentDetail.getUid,
              type: ReportEnum.momentDetail.index.toString(),
              channelID: logic.momentDetail.momentId);
        },
        child: Container(
          margin: const EdgeInsetsDirectional.only(end: 15),
          child: Image.asset(
            Assets.imgReportIcon,
            width: 34,
            height: 34,
            matchTextDirection: true,
          ),
        ),
      );

  Widget get toBack => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Get.back(),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              Assets.imgCloseDialog,
              width: 34,
              height: 34,
            )
          ],
        ),
      );

  Widget toBuildCallButton(MomentDetail data) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 20),
          child: BuildCallButton(data),
        ),
        if (data.isChat)
          PositionedDirectional(
              end: 30,
              bottom: 60,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFF260418),
                    border:
                        Border.all(width: 1, color: const Color(0xFFEF45A3)),
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(37),
                        bottomStart: Radius.circular(37),
                        topEnd: Radius.circular(37),
                        bottomEnd: Radius.circular(0))),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 2),
                          child: Image.asset(
                            Assets.imgBigDiamond,
                            matchTextDirection: true,
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "${data.charge ?? 0}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: Tr.app_video_time_unit.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ))
      ],
    );
  }
}
