import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_contribute_entity.dart';
import 'package:nyako/pages/anchor_detail/contribute_list/index.dart';
import 'package:nyako/pages/widget/base_empty.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';

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
            ? Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(24)),
                    color: Colors.white),
                child: const BaseEmpty(),
              )
            : Container(
                width: double.maxFinite,
                padding: const EdgeInsetsDirectional.all(20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(
                        top: Radius.circular(24)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "NO.",
                          style: TextStyle(
                              color: const Color(0xFFBCB6C4),
                              fontFamily: AppConstants.fontsBold,
                              fontSize: 13),
                        ),
                        const Spacer(),
                        Text(
                          Tr.app_contribution.tr,
                          style: TextStyle(
                              color: const Color(0xFFBCB6C4),
                              fontFamily: AppConstants.fontsBold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      padding: const EdgeInsetsDirectional.only(
                          start: 0, end: 0, bottom: 60, top: 10),
                      itemCount: contributions.length,
                      itemBuilder: (context, index) {
                        return buildItem(index, contributions[index]);
                      },
                    ))
                  ],
                ),
              ),
        PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, bottom: 15, top: 12),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 18,
                    spreadRadius: 2)
              ]),
              width: double.maxFinite,
              child: Row(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: cachedImage(UserInfo.to.userPortrait,
                          width: 42, height: 42),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        UserInfo.to.nickName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        "ID:${UserInfo.to.username}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: const Color(0xFF9B989D),
                            fontFamily: AppConstants.fontsRegular,
                            fontSize: 13),
                      )
                    ],
                  )),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: Text(
                      "-",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ))
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
            margin:
                EdgeInsetsDirectional.only(start: 0, end: index >= 10 ? 0 : 20),
            child: Text(
              index >= 6 ? "${index + 4}" : "${index + 4}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              border: Border.all(width: 1, color: Colors.transparent),
            ),
            margin: const EdgeInsetsDirectional.only(start: 0, end: 10),
            child: avatar(data, index),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  data.showNickName,
                  maxLines: 1,
                  maxFontSize: 15,
                  minFontSize: 15,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  data.showUserName,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: AppConstants.fontsRegular,
                      color: const Color(0xFF9B989D)),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: Text(
              (data.amount ?? 0).toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.normal),
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
