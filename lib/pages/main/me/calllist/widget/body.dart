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
  final ChatRecordLogic logic;

  const ChatRecordBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    //return buildCell(CallRecordEntity(), ChatRecordLogic());
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
          height: 142,
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadiusDirectional.circular(16)),
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.all(12),
          margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  BuildItemAvatar(
                    item.peerPortrait ?? '',
                    item.lineState(),
                    r: 60,
                  ),
                  Expanded(
                      child: Container(
                    height: 48,
                    alignment: AlignmentDirectional.centerStart,
                    padding:
                        const EdgeInsetsDirectional.only(start: 10, end: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 5),
                              child: AutoSizeText(
                                item.peerNickname?.convertName ?? "--",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                maxFontSize: 18,
                                minFontSize: 9,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            LineState(item.lineState(), r: 12),
                          ],
                        ),
                        AutoSizeText(
                          dateFormat((item.createdAt ?? 0)),
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 6,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
                  ChatRecordButton(logic.isChat(item), item, logic),
                ],
              ),
              Container(
                color: Colors.white10,
                height: 1,
                width: double.maxFinite,
                margin: const EdgeInsetsDirectional.only(
                    top: 12, bottom: 0, start: 70),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 70),
                child: CallTime(logic.lineState(item), logic.stateStr(item)),
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
