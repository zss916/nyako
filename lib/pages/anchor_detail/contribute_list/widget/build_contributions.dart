import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/entities/app_contribute_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/contribute_list/index.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/utils/app_extends.dart';

class BuildContributions extends StatelessWidget {
  final ContributeListLogic logic;
  final List<ContributeEntity> contributions;

  const BuildContributions(this.logic, this.contributions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        contributions.isEmpty
            ? const BaseEmpty()
            : ListView.builder(
                padding: const EdgeInsetsDirectional.only(
                    start: 0, end: 0, bottom: 20, top: 15),
                itemCount: contributions.length,
                itemBuilder: (context, index) {
                  return buildItem(index, contributions[index]);
                },
              ),
      ],
    );
  }

  Widget buildItem(int index, ContributeEntity data) {
    return Container(
      height: 62,
      margin: const EdgeInsetsDirectional.only(start: 0, end: 0, bottom: 10),
      padding: const EdgeInsetsDirectional.only(
          start: 0, end: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(start: 0, end: 10),
            child: Text(
              index >= 6 ? " ${index + 4}" : " 0${index + 4}",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(width: 1, color: Colors.transparent),
            ),
            margin: const EdgeInsetsDirectional.only(start: 0, end: 10),
            child: avatar(data, index),
          ),
          Expanded(
            child: AutoSizeText(
              data.showNickName,
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  // fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 1),
                  child: Image.asset(
                    Assets.imgSmallPickLove,
                    width: 18,
                    height: 18,
                    matchTextDirection: true,
                  ),
                ),
                Text(
                  (data.amount ?? 0).toString(),
                  style: TextStyle(
                      color: const Color(0x80FFFFFF),
                      fontSize: 16,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Color getIndexColors(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFEE8AB);
      case 1:
        return const Color(0xFFCCCFD9);
      case 2:
        return const Color(0xFFF0CEB5);
      default:
        return const Color(0xFFFFE3ED);
    }
  }

  Color getIndexColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFF890E);
      case 1:
        return const Color(0xFF3FCDFF);
      case 2:
        return const Color(0xFFFF2A48);
      default:
        return const Color(0x4D333333);
    }
  }

  String getIndexIcon(int index) {
    switch (index) {
      case 0:
        return "";
      case 1:
        return "";
      case 2:
        return "";
      default:
        return "";
    }
  }

  Widget avatar(ContributeEntity data, int index) {
    return Container(
      width: 44,
      height: 44,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsetsDirectional.only(start: 0, end: 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: cachedImage(data.portrait ?? ""),
      ),
    );
  }
}
