import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/entities/app_call_record_entity.dart';
import 'package:oliapro/pages/main/me/calllist/index.dart';
import 'package:oliapro/pages/main/me/calllist/widget/call_time.dart';
import 'package:oliapro/pages/main/me/calllist/widget/chat_record_button.dart';
import 'package:oliapro/pages/main/me/calllist/widget/header.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/pages/widget/build_item_avatar.dart';
import 'package:oliapro/pages/widget/line_state.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_some_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatRecordBody extends StatelessWidget {
  // final ChatRecordLogic logic;

  const ChatRecordBody({super.key});

  @override
  Widget build(BuildContext context) {
    // return buildCell(CallRecordEntity(), ChatRecordLogic());
    return GetBuilder<ChatRecordLogic>(
      assignId: true,
      init: ChatRecordLogic(),
      builder: (logic) {
        return SmartRefresher(
          header: const ListHeader(),
          enablePullDown: true,
          enablePullUp: true,
          controller: logic.refreshCtr,
          onRefresh: () => logic.refreshData(),
          onLoading: () => logic.loadMoreData(),
          child: logic.data.isNotEmpty ? buildList(logic) : const BaseEmpty(),
        );
      },
    );
  }

  Widget buildList(ChatRecordLogic logic) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: logic.data.length,
      itemBuilder: (context, index) {
        return buildCell(logic.data[index], logic);
      },
    );
  }

  Widget buildCell(CallRecordEntity item, ChatRecordLogic logic) {
    return GestureDetector(
        onTap: () => logic.goAnchorDetail(item.peerUserId ?? 0),
        child: Container(
          width: double.maxFinite,
          height: 96,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(16)),
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.all(12),
          margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  BuildItemAvatar(
                    item.peerPortrait ?? '',
                    item.lineState(),
                    r: 72,
                  ),
                  PositionedDirectional(
                      top: 6,
                      start: 6,
                      child: LineState(item.lineState(), r: 12)),
                ],
              ),
              Expanded(
                  child: Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsetsDirectional.only(end: 5),
                      child: AutoSizeText(
                        item.peerNickname?.convertName ?? "--",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxFontSize: 16,
                        minFontSize: 9,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AutoSizeText(
                      dateFormat((item.createdAt ?? 0)),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      maxFontSize: 13,
                      minFontSize: 6,
                      style: const TextStyle(
                          color: Color(0xFFBCB6C4), fontSize: 13),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 0),
                      child:
                          CallTime(logic.lineState(item), logic.stateStr(item)),
                    ),
                  ],
                ),
              )),
              ChatRecordButton(logic.isChat(item), item, logic),
            ],
          ),
        ));
  }
}
