import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/database/entity/app_conversation_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/msg/index.dart';
import 'package:oliapro/pages/main/msg/widget/build_avatars.dart';
import 'package:oliapro/pages/main/msg/widget/build_compliance.dart';
import 'package:oliapro/pages/main/msg/widget/build_msg_content.dart';
import 'package:oliapro/pages/main/msg/widget/build_msg_unread.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_some_extension.dart';
import 'package:oliapro/utils/app_voice_player.dart';

class MessageListView extends StatelessWidget {
  final BuildContext context;
  final MsgListLogic logic;
  const MessageListView(this.context, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    //  debugPrint("count: ${UserInfo.to.getLoginCount()}");
    return CustomScrollView(slivers: [
      if (UserInfo.to.isShowCompliance)
        SliverToBoxAdapter(
          child: GetBuilder<MsgListLogic>(
              id: "compliance",
              init: MsgListLogic(),
              builder: (logic) => BuildCompliance(logic: logic)),
        ),
      /*if (!AppConstants.isFakeMode)
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            width: double.maxFinite,
            margin:
                const EdgeInsetsDirectional.only(start: 12, end: 12, top: 10),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    matchTextDirection: true,
                    image: ExactAssetImage(Assets.imgNextPayBg))),
            child: GetBuilder<MsgListLogic>(
                init: MsgListLogic(),
                builder: (logic) => BuildNextPayActivity(
                      logic: logic,
                    )),
          ),
        ),*/
      SliverToBoxAdapter(
        child: buildAiHelp(logic),
      ),
      GetBuilder<MsgListLogic>(
          init: MsgListLogic(),
          builder: (logic) {
            return SlidableAutoCloseBehavior(
              child: SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final data = logic.dataList[index];
                    return slid(index, data, buildItem(data, logic), logic);
                  },
                  childCount: logic.dataList.length,
                  addRepaintBoundaries: false,
                  addAutomaticKeepAlives: false,
                ),
                itemExtent: 72,
              ),
            );
          }),
      const SliverPadding(padding: EdgeInsetsDirectional.only(bottom: 100))
    ]);
  }

  buildItem(ConversationEntity data, MsgListLogic logic) {
    return Container(
      height: 72,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => logic.toChat(data.herId),
          child: buildCell(data, logic),
        ),
      ),
    );
  }

  Widget buildCell(ConversationEntity entity, MsgListLogic logic) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      padding: const EdgeInsetsDirectional.only(start: 10),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (!entity.isSystem) {
                AppAudioPlayer().stop();
                logic.toAnchorDetail(entity.herId);
              }
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.all(3),
                  child: BuildAvatars(entity.isSystem, entity.anchorPortrait),
                ),
                PositionedDirectional(
                    top: 0, end: 0, child: BuildMsgUnRead(entity.unReadQuality))
              ],
            ),
          ),
          Expanded(
              child: Container(
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsetsDirectional.only(
                start: 10, end: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        entity.isSystem
                            ? Tr.app_message_official.tr.clipWithChar
                            : (entity.anchorName),
                        maxLines: 1,
                        maxFontSize: 16,
                        minFontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      BuildMsgContent(entity)
                    ],
                  ),
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      entity.showTime,
                      style: const TextStyle(
                          color: Color(0xFFBCB6C4), fontSize: 12),
                    ),
                    // BuildMsgUnRead(entity.unReadQuality),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget slid(
      int index, ConversationEntity data, Widget child, MsgListLogic logic) {
    return Container(
      width: 60,
      margin: const EdgeInsetsDirectional.only(top: 5, end: 5),
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          debugPrint("onHorizontalDragStart");
        },
        onHorizontalDragDown: (details) {
          debugPrint("onHorizontalDragDown");
        },
        onHorizontalDragEnd: (details) {
          debugPrint("onHorizontalDragEnd");
        },
        onHorizontalDragUpdate: (details) {
          debugPrint("onHorizontalDragUpdate");
        },
        onHorizontalDragCancel: () {
          debugPrint("onHorizontalDragCancel");
        },
        child: Slidable(
          key: ValueKey("msg$index"),
          groupTag: "slidable",
          useTextDirection: true,
          endActionPane: ActionPane(
            extentRatio: 0.20,
            motion: const DrawerMotion(),
            children: [
              CustomSlidableAction(
                onPressed: (BuildContext context) =>
                    logic.removeMessage(index, data.herId),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                autoClose: true,
                backgroundColor: const Color(0xFFFF4864),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      Assets.iconMsgDelete,
                      width: 32,
                      height: 32,
                    )
                  ],
                ),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget buildAiHelp(MsgListLogic logic) {
    return Container(
      height: 72,
      margin: const EdgeInsetsDirectional.only(start: 5, end: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => logic.openAiHelp(),
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 0, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    Assets.iconCustomer,
                    width: 50,
                    height: 50,
                    matchTextDirection: true,
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              Tr.app_mine_customer_service.tr,
                              maxLines: 1,
                              maxFontSize: 16,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
