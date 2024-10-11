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
              image: ExactAssetImage(Assets.imgAnchorBigDefaultBg),
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
                  titleWidget: Text(
                    Tr.app_call_ended.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: UnconstrainedBox(
                    child: GestureDetector(
                      onTap: () async {
                        if (logic.detail == null) return;
                        //controller.closeMe();
                        ARoutes.toReport(
                            uid: logic.herId,
                            type: ReportEnum.settlement.index.toString());
                      },
                      child: Image.asset(
                        Assets.imgReportIcon,
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
                        Assets.imgCloseTip,
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
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              InkWell(
                                onTap: () => ARoutes.toAnchorDetail(
                                    logic.detail?.getUid),
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  clipBehavior: Clip.hardEdge,
                                  padding: const EdgeInsetsDirectional.all(0),
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          width: 0, color: Colors.transparent)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: cachedImage(
                                        logic.detail?.portrait ?? "",
                                        type: 100),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  logic.handleFollow();
                                },
                                child: logic.followed
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(10),
                                        child: Image.asset(
                                          Assets.imgFollow,
                                          matchTextDirection: true,
                                          width: 28,
                                          height: 20,
                                        ),
                                      ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                logic.detail?.showNickName ?? "--",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsetsDirectional.only(
                                start: 0, end: 0, top: 20, bottom: 5),
                            decoration: const BoxDecoration(
                                /* gradient: LinearGradient(colors: [
                                Color(0x1AD270FF),
                                Color(0x1AD270FF),
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))*/

                                image: DecorationImage(
                                    image:
                                        ExactAssetImage(Assets.imgEndTopBg))),
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
                                                  Assets.imgCallCard2,
                                                  matchTextDirection: true,
                                                  height: 20,
                                                  width: 30,
                                                ),
                                            ],
                                          );
                                        })),
                                  Text(
                                    Tr.app_video_chat_duration.tr,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
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
                                height: 68,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsetsDirectional.only(start: 15),
                                decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.imgDiamond,
                                          matchTextDirection: true,
                                          width: 24,
                                          height: 24,
                                        ),
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Tr.app_call_cast.tr,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )),
                              Container(
                                width: 1,
                                height: 20,
                                color: const Color(0x1AFFF7FE),
                              ),
                              Expanded(
                                  child: Container(
                                height: 68,
                                margin:
                                    const EdgeInsetsDirectional.only(end: 15),
                                decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Assets.imgDiamond,
                                          matchTextDirection: true,
                                          width: 24,
                                          height: 24,
                                        ),
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Tr.app_present_consumption.tr,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 0),
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
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                                      top: 10, start: 10, end: 10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 173 / 300,
                                  ),
                                  itemCount: logic.recommend.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return itemWidget(
                                        logic.recommend[index], logic);
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
        constraints: const BoxConstraints(minHeight: 300),
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
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      matchTextDirection: true,
                      image: ExactAssetImage(Assets.imgAnchorDefaultIcon))),
              child: Container(
                width: double.maxFinite,
                height: 250,
                clipBehavior: Clip.hardEdge,
                decoration: item.portrait == null
                    ? BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            matchTextDirection: true,
                            image:
                                ExactAssetImage(Assets.imgAnchorDefaultIcon)))
                    : BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
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
                      Expanded(
                          child: Container(
                        //color: Colors.green,
                        height: double.maxFinite,
                        alignment: AlignmentDirectional.bottomStart,
                        constraints: BoxConstraints(maxWidth: 110.w),
                        margin: const EdgeInsetsDirectional.only(bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 2),
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
                                text: "${item.charge ?? '--'}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: AppConstants.fontsBold,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: Tr.app_video_time_unit.tr,
                                    style: TextStyle(
                                      color: const Color(0xFFFFFFFF)
                                          .withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      )),
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
