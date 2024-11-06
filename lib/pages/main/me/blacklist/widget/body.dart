import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/blacklist/index.dart';
import 'package:nyako/pages/main/me/blacklist/utils/state.dart';
import 'package:nyako/pages/widget/base_empty.dart';
import 'package:nyako/pages/widget/build_item_avatar.dart';
import 'package:nyako/pages/widget/circular_progress.dart';
import 'package:nyako/utils/app_extends.dart';

class BlackBody extends StatelessWidget {
  final BlackLogic logic;

  const BlackBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    //  return buildCell(HostDetail(), 0, BlackLogic());
    return GetBuilder<BlackLogic>(
      assignId: true,
      init: BlackLogic(),
      builder: (logic) {
        return buildContent(logic.state, logic);
      },
    );
  }

  Widget buildContent(int state, BlackLogic logic) {
    return switch (state) {
      _ when state == Status.EMPTY.index => const BaseEmpty(),
      _ when state == Status.DATA.index => buildList(logic),
      _ => const CircularProgress(),
    };
  }

  Widget buildList(BlackLogic logic) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: logic.data.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCell(logic.data[index], index, logic);
      },
    );
  }

  Widget buildCell(HostDetail data, int index, BlackLogic logic) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsetsDirectional.only(
          start: 12, end: 6, top: 5, bottom: 5),
      margin: const EdgeInsetsDirectional.only(
          start: 15, end: 15, top: 10, bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(16),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              BuildItemAvatar(
                data.showPortrait,
                LineType.other.number,
                r: 50,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      data.showNickName,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 8,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 5),
                      child: AutoSizeText(
                        data.showBlackTime,
                        maxLines: 1,
                        maxFontSize: 12,
                        textAlign: TextAlign.start,
                        minFontSize: 6,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              )),
              GestureDetector(
                onTap: () => logic.removeBlack(data.getUid, index,
                    avatar: data.showPortrait),
                child: Container(
                  width: 46,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color(0x1AFF4864),
                      borderRadius: BorderRadiusDirectional.circular(10)),
                  child: Center(
                    child: Image.asset(
                      Assets.iconRemove,
                      matchTextDirection: true,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
