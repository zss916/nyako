import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_avatar.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_call_btn.dart';
import 'package:oliapro/pages/main/home/follow/widget/build_msg_btn.dart';
import 'package:oliapro/pages/main/home/index.dart';
import 'package:oliapro/pages/main/home/widget/hot/line_state_text.dart';
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
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
        padding: const EdgeInsetsDirectional.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(bottom: 9),
                  child: BuildAvatar(data.portrait ?? ''),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsetsDirectional.only(
                    start: 10,
                  ),
                  padding: const EdgeInsetsDirectional.only(
                      bottom: 0, end: 0, top: 0),
                  height: 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(bottom: 0),
                        child: Text(
                          data.showNickName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      UnconstrainedBox(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadiusDirectional.circular(10)),
                          margin: const EdgeInsetsDirectional.only(start: 0),
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 6, vertical: 2),
                          child: Row(
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                margin:
                                    const EdgeInsetsDirectional.only(end: 2),
                                child: LineState(
                                  data.lineState(),
                                  r: 6,
                                ),
                              ),
                              LineStateText(data.lineState())
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 82,
                ),
                Row(
                  children: [
                    Image.asset(
                      Assets.iconDiamond,
                      matchTextDirection: true,
                      width: 18,
                      height: 18,
                    ),
                    Text.rich(
                      TextSpan(
                        text: " ",
                        style: TextStyle(
                          color: const Color(0xFF9341FF),
                          fontSize: 18,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                              text: "${data.charge ?? '--'}",
                              style: TextStyle(
                                color: const Color(0xFF9341FF),
                                fontSize: 18,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text: Tr.app_video_time_unit.tr,
                            style: TextStyle(
                              color: const Color(0xFF9B989D),
                              fontSize: 13,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                data.isChat
                    ? BuildCallBtn(data, logic)
                    : BuildMsgBtn(data.getUid, logic)
              ],
            )
          ],
        ),
      ),
    );
  }
}
