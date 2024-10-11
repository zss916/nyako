import 'package:flutter/material.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_avatar.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_call_btn.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_msg_btn.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/hot/line_state_text.dart';
import 'package:oliapro/pages/widget/age_and_sex.dart';
import 'package:oliapro/pages/widget/line_state.dart';

class FollowItem extends StatelessWidget {
  final HostDetail data;
  final HomeLogic logic;
  final int index;

  const FollowItem(
      {super.key,
      required this.data,
      required this.logic,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return buildCell(data, logic, index);
  }

  Widget buildCell(HostDetail data, HomeLogic logic, int index) {
    return GestureDetector(
      key: ValueKey("follow$index"),
      onTap: () => logic.pushAnchorDetail(data),
      child: Container(
        //height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.transparent),
        margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
        padding: const EdgeInsetsDirectional.only(
            top: 0, bottom: 0, end: 0, start: 0),
        child: Row(
          children: [
            BuildAvatar(data.portrait ?? ''),
            Expanded(
                child: Container(
              margin: const EdgeInsetsDirectional.only(
                start: 10,
              ),
              padding:
                  const EdgeInsetsDirectional.only(bottom: 0, end: 0, top: 0),
              // height: 48,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 8),
                            child: Text(
                              data.showNickName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              AgeAndSex(data.showBirthday),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10)),
                                margin:
                                    const EdgeInsetsDirectional.only(start: 5),
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 3),
                                      child: LineState(
                                        data.lineState(),
                                        r: 10,
                                      ),
                                    ),
                                    LineStateText(data.lineState())
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
            data.isChat
                ? BuildCallBtn(data, logic)
                : BuildMsgBtn(data.getUid, logic)
          ],
        ),
      ),
    );
  }
}
