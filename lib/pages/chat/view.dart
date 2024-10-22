part of 'index.dart';

@RouteName(AppPages.chatPage)
class ChatPage extends GetView<ChatLogic> {
  @override
  String? get tag => (Get.arguments).toString();

  @override
  ChatLogic get controller => GetInstance().find<ChatLogic>(tag: tag);

  ChatPage({super.key});

  final centerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            children: [
              chatBar(),
              Expanded(
                  child: GetBuilder<ChatLogic>(
                      init: ChatLogic(),
                      tag: (Get.arguments).toString(),
                      builder: (logic) {
                        return Stack(
                          children: [
                            Positioned.fill(
                                child: Column(
                              children: [
                                if (!UserInfo.to.isUserVip &&
                                    UserInfo.to.isUseMsgCard)
                                  const ChatMsgCard(),
                                if (logic.isShowRechargeTip)
                                  BuildRechargeTip(logic),
                                Expanded(
                                  child: buildContent(logic),
                                ),
                                if (!logic.isSystemId)
                                  ChatInputWidget(
                                      userId: logic.herId,
                                      tag: (Get.arguments).toString()),
                              ],
                            )),
                            Positioned.fill(
                                child: AppVapPlayer(
                              vapController: logic.myVapController,
                            )),
                          ],
                        );
                      }))
            ],
          ),
        ],
      ),
    );
  }

  Widget getMsgWidget(ChatMsgWrapper wrapper, int index, ChatLogic logic) {
    bool isOnline = logic.herDetail?.isShowOnline ?? false;
    if (RTMMsgPhoto.typeCodes.contains(wrapper.msgEntity.msgType)) {
      return ChatMsgImage(wrapper: wrapper, isOnline: isOnline);
    }
    if (RTMMsgVoice.typeCodes.contains(wrapper.msgEntity.msgType)) {
      return ChatMsgVoice(wrapper: wrapper, isOnline: isOnline);
    }
    switch (wrapper.msgEntity.msgType) {
      case RTMMsgText.typeCode:
        // return ChatMsgText(wrapper: wrapper, isOnline: isOnline);
        return ChatMsgText(
          wrapper: wrapper,
          isOnline: isOnline,
          hasTranslateFunction: logic.hasTranslateFunction,
        );
      case RTMMsgGift.typeCode:
        return ChatMsgGift(wrapper: wrapper, isOnline: isOnline);
      case RTMMsgCallState.typeCode:
        return ChatMsgCall(wrapper: wrapper, isOnline: isOnline);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget chatBar() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(24), bottomEnd: Radius.circular(24)),
          color: Color(0xFFF5F4F6)),
      padding: const EdgeInsetsDirectional.only(
          top: 42, bottom: 15, start: 5, end: 10),
      child: Row(
        children: [
          Container(
            //color: Colors.blue,
            margin: const EdgeInsetsDirectional.only(end: 5),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsetsDirectional.all(10),
                  child: Image.asset(
                    Assets.iconBack,
                    matchTextDirection: true,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ).onLabel(label: SemanticsLabel.back),
          ),
          Expanded(
              child: GetBuilder<ChatLogic>(
                  id: 'herInfo',
                  init: ChatLogic(),
                  tag: (Get.arguments).toString(),
                  builder: (logic) {
                    return Row(
                      children: [
                        const Spacer(),
                        ChatPortrait(logic),
                        const Spacer(),
                        if (!logic.isSystemId)
                          BuildChatReport(
                            logic.herId,
                            isBlack: true,
                            type: ReportEnum.chat.index.toString(),
                          ),
                        if (!logic.isSystemId) BuildChatMore(logic)
                      ],
                    );
                  })),
        ],
      ),
    );
  }

  Widget buildContent(ChatLogic logic) {
    return Listener(
      onPointerDown: (event) =>
          safeFind<ChatInputController>()?.onPointerDown(),
      child: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollNotification) {
              if (notification.metrics is PageMetrics) {
                return false;
              }
              if (notification.metrics is FixedScrollMetrics) {
                if (notification.metrics.axisDirection == AxisDirection.left ||
                    notification.metrics.axisDirection == AxisDirection.right) {
                  return false;
                }
              }
              logic.extentAfter = notification.metrics.extentAfter;
              logic.extentBefore = notification.metrics.extentBefore;
            }
            return false;
          },
          child: RefreshIndicator(
              onRefresh: logic.getOldList,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: logic.scroller,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                center: centerKey,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var item = logic.showOldData[index];
                        return getMsgWidget(item, index, logic);
                      },
                      childCount: logic.showOldData.length,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.zero,
                    key: centerKey,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var item = logic.showNewData[index];
                        return getMsgWidget(item, index, logic);
                      },
                      childCount: logic.showNewData.length,
                    ),
                  ),
                  // footer!,
                ],
              ))),
    );
  }
}
