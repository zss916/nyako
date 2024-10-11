import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/info/index.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_some_extension.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class EditBody extends StatelessWidget {
  final EditLogic logic;

  const EditBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditLogic>(
      assignId: true,
      init: EditLogic(),
      builder: (logic) => Column(
        children: [
          buildHeader(logic),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(14)),
                color: Colors.white10),
            margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildCell4(logic.listData[4], 4),
                const Divider(
                  height: 1,
                  color: Color(0xFFEEEEEE),
                ),
                buildCell(logic.listData[0], 0)
                    .onLabel(label: SemanticsLabel.name),
                const Divider(
                  height: 1,
                  color: Color(0xFFEEEEEE),
                ),
                buildCell3(logic.listData[1], 1,
                        isMale: logic.state.myDetail?.gender == 1)
                    .onLabel(label: SemanticsLabel.gender),
                const Divider(
                  height: 1,
                  color: Color(0xFFEEEEEE),
                ),
                buildCell(logic.listData[2], 2)
                    .onLabel(label: SemanticsLabel.date),
                const Divider(
                  height: 1,
                  color: Color(0xFFEEEEEE),
                ),
                buildCell2(logic.listData[3], 3)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(EditLogic logic) {
    return Container(
      width: double.maxFinite,
      color: const Color(0xFFF7F7F7),
      padding: const EdgeInsetsDirectional.symmetric(vertical: 30),
      margin: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 10),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          InkWell(
            //borderRadius: BorderRadius.circular(14),
            onTap: () => logic.clickAction('portrait'),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(100)),
              width: 160,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: cachedImage(logic.state.showPortrait,
                    width: 160, height: 160),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCell4(Map data, int index) {
    final String type = data['type']!;
    var value = logic.setValue(type);
    return InkWell(
      onTap: () => logic.clickAction(type),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.transparent),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        child: Row(
          //crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Text(
                data['title']!,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: AutoSizeText(
              Tr.appChange.tr,
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )),
            Image.asset(
              Assets.iconNext,
              width: 20,
              height: 20,
              matchTextDirection: true,
            )
          ],
        ),
      ),
    );
  }

  Widget buildCell(Map data, int index) {
    final String type = data['type']!;
    var value = logic.setValue(type);
    return InkWell(
      onTap: () => logic.clickAction(type),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.transparent),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        child: Row(
          //crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Text(
                data['title']!,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: AutoSizeText(
              value.isNotEmpty
                  ? ((index == 0 || index == 3)
                      ? value.replaceAll(RegExp(r"\d"), "*").clipWithChar
                      : value)
                  : '',
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            )),
            Image.asset(
              Assets.iconNext,
              width: 20,
              height: 20,
              matchTextDirection: true,
            )
          ],
        ),
      ),
    );
  }

  Widget buildCell2(Map data, int index) {
    final String type = data['type']!;
    var value = logic.setValue(type);
    return InkWell(
      onTap: () => logic.clickAction(type),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            color: Colors.white10),
        width: double.infinity,
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    child: Text(
                      data['title']!,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    Assets.iconNext,
                    width: 20,
                    height: 20,
                    matchTextDirection: true,
                  )
                ],
              ),
            ),
            if (value.isNotEmpty)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 0),
                child: AutoSizeText(
                  value.isNotEmpty
                      ? ((index == 0 || index == 3)
                          ? value.replaceAll(RegExp(r"\d"), "*").clipWithChar
                          : value)
                      : '--',
                  maxLines: 4,
                  maxFontSize: 16,
                  minFontSize: 7,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildCell3(Map data, int index, {required bool isMale}) {
    final String type = data['type']!;
    var value = logic.setValue(type);
    return InkWell(
      onTap: () => logic.clickAction(type),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.transparent),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        child: Row(
          //crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Text(
                data['title']!,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            AutoSizeText(
              value.isNotEmpty
                  ? ((index == 0 || index == 3)
                      ? value.replaceAll(RegExp(r"\d"), "*").clipWithChar
                      : value)
                  : '',
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Image.asset(
              Assets.iconNext,
              width: 20,
              height: 20,
              matchTextDirection: true,
            )
          ],
        ),
      ),
    );
  }
}
