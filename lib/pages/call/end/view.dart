part of settlement_page;

@RouteName(AppPages.callEnd)
class EndPage extends StatelessWidget {
  /* @override
  String? get tag => (Get.arguments).toString();

  @override
  EndLogic get controller => GetInstance().find<EndLogic>(tag: tag);
*/
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(Assets.iconAnchorDefault),
              fit: BoxFit.cover)),
      child: GetBuilder<EndLogic>(
          //tag: (Get.arguments).toString(),
          init: EndLogic(),
          builder: (logic) {
            return Container(
              decoration: BoxDecoration(
                  image: logic.detail?.portrait == ""
                      ? null
                      : DecorationImage(
                          image: CachedNetworkImageProvider(
                            logic.detail?.portrait ?? "",
                          ),
                          fit: BoxFit.cover)),
              child: Scaffold(
                backgroundColor: Colors.black87,
                extendBodyBehindAppBar: false,
                appBar: BaseAppBar(
                  isSetBg: false,
                  isDark: false,
                  titleWidget: Text(
                    Tr.app_call_ended.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: UnconstrainedBox(
                    child: GestureDetector(
                      onTap: () {
                        if (logic.detail == null) return;
                        //controller.closeMe();
                        showReportSheet(logic.herId, close: () {
                          StorageService.to.updateBlackList(logic.herId, true);
                          AppEventBus.eventBus
                              .fire(BlackEvent(uid: logic.herId));
                        });
                        /*ARoutes.toReport(
                            uid: logic.herId,
                            type: ReportEnum.settlement.index.toString());*/
                      },
                      child: Image.asset(
                        Assets.iconReportIcon,
                        matchTextDirection: true,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  back: () {
                    logic.closeMe();
                  },
                  actions: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        // logic.closeMe();
                      },
                      child: Image.asset(
                        Assets.iconCloseSettlement,
                        matchTextDirection: true,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                body: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () =>
                                ARoutes.toAnchorDetail(logic.detail?.getUid),
                            child: Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsetsDirectional.all(0),
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 0, color: Colors.transparent)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: cachedImage(logic.detail?.portrait ?? "",
                                    type: 100),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                logic.detail?.showNickName ?? "--",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: AppConstants.fontsBold,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  logic.handleFollow();
                                },
                                child: logic.followed
                                    ? Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 6),
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(
                                            horizontal: 9, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF5F4F6),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(30)),
                                        child: Image.asset(
                                          Assets.iconFollowed,
                                          matchTextDirection: true,
                                          width: 18,
                                          height: 18,
                                        ),
                                      )
                                    : Container(
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 6),
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(
                                            horizontal: 9, vertical: 3),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF9341FF),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(30)),
                                        child: Image.asset(
                                          Assets.iconFollow,
                                          matchTextDirection: true,
                                          width: 18,
                                          height: 18,
                                        ),
                                      ),
                              )
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 84,
                            margin: const EdgeInsetsDirectional.only(
                                start: 20, end: 20, top: 20, bottom: 12),
                            decoration: const BoxDecoration(
                                color: Color(0x14FFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(() => (logic.endCallEntity.value == null)
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppBallBeatIndicator(),
                                          ],
                                        )
                                      : Builder(builder: (context) {
                                          var callTime = logic.endCallEntity
                                                  .value?.callTime ??
                                              '';
                                          final usedDiamond =
                                              callTime.isNotEmpty &&
                                                  callTime != '00:00' &&
                                                  callTime != '00:00:00';
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (usedDiamond)
                                                Text(
                                                  logic.endCallEntity.value
                                                          ?.callTime ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontFamily: AppConstants
                                                          .fontsBold,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              if (usedDiamond &&
                                                  logic.endCallEntity.value
                                                          ?.usedProp ==
                                                      true)
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              if (logic.endCallEntity.value
                                                      ?.usedProp ==
                                                  true)
                                                Image.asset(
                                                  Assets.iconCallVideoCard,
                                                  matchTextDirection: true,
                                                  height: 32,
                                                  width: 24,
                                                ),
                                            ],
                                          );
                                        })),
                                  Text(
                                    Tr.app_video_chat_duration.tr,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: AppConstants.fontsRegular,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 84,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                decoration: const BoxDecoration(
                                    color: Color(0x14FFFFFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(() => Text(
                                              "${logic.endCallEntity.value?.callAmount ?? "--"}" +
                                                  ' ',
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontFamily:
                                                      AppConstants.fontsBold,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Image.asset(
                                          Assets.iconDiamond,
                                          matchTextDirection: true,
                                          width: 17,
                                          height: 17,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Tr.app_call_cast.tr,
                                      style: TextStyle(
                                          fontFamily: AppConstants.fontsRegular,
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )),
                              const SizedBox(
                                width: 13,
                                height: 0,
                              ),
                              Expanded(
                                  child: Container(
                                height: 84,
                                margin:
                                    const EdgeInsetsDirectional.only(end: 20),
                                decoration: const BoxDecoration(
                                    color: Color(0x14FFFFFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(() => Text(
                                              "${logic.endCallEntity.value?.giftAmount ?? "--"}" +
                                                  ' ',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontFamily:
                                                      AppConstants.fontsBold,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Image.asset(
                                          Assets.iconDiamond,
                                          matchTextDirection: true,
                                          width: 17,
                                          height: 17,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Tr.app_present_consumption.tr,
                                      style: TextStyle(
                                          fontFamily: AppConstants.fontsRegular,
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 12, bottom: 15, left: 20, right: 20),
                            child: BuildChatButton(logic),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Container(
                                margin: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  Tr.app_home_recommend.tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: AppConstants.fontsBold,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          logic.recommend.isNotEmpty
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 0, start: 10, end: 10, bottom: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 172 / 275,
                                    mainAxisExtent: 275,
                                  ),
                                  itemCount: logic.recommend.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RepaintBoundary(
                                      child: itemWidget(
                                          logic.recommend[index], logic),
                                    );
                                  },
                                )
                              : const BaseEmpty()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget itemWidget(HostDetail item, EndLogic logic) {
    return GestureDetector(
      onTap: () => logic.pushAnchorDetail(item),
      child: Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(minHeight: 275),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage(Assets.iconAnchorDefault)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      //image: ExtendedNetworkImageProvider(item.portrait ?? "")
                      image: CachedNetworkImageProvider(
                        item.portrait ?? "",
                      ))),
              child: Container(
                width: double.maxFinite,
                height: 275,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsetsDirectional.only(
                    start: 10, top: 10, bottom: 12, end: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: foregroundBoxDecoration,
                ),
                child: Column(
                  children: [
                    Row(
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      ],
                    ),
                    if (!AppConstants.isFakeMode)
                      Container(
                        margin: const EdgeInsetsDirectional.only(top: 2),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 2),
                              child: Image.asset(
                                Assets.iconDiamond,
                                width: 15,
                                height: 15,
                                matchTextDirection: true,
                              ),
                            ),
                            Expanded(
                                child: Text.rich(
                              TextSpan(
                                text: " ",
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
                                        fontFamily: AppConstants.fontsBold,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                    text: Tr.app_video_time_unit.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: AppConstants.fontsRegular,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    const Spacer(),
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
                            start: 0, bottom: 0),
                        child: HotChatButton(isCall: item.isChat),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
