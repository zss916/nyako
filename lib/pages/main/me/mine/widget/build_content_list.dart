import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/mine/index.dart';
import 'package:oliapro/pages/main/me/mine/widget/build_trouble.dart';
import 'package:oliapro/pages/main/me/mine/widget/gradient_text.dart';

class BuildContentList extends StatelessWidget {
  final MeLogic logic;
  BuildContentList(this.logic, {super.key});

  final listData = [
    {'title': Tr.app_prop_package.tr, 'image': Assets.iconSmallLogo},
    {'title': Tr.app_my_moments.tr, 'image': Assets.iconSmallLogo},
    {'title': Tr.app_my_call_list.tr, 'image': Assets.iconSmallLogo},
    {'title': Tr.app_mine_customer_service.tr, 'image': Assets.iconService},
    {'title': Tr.app_my_binding_code.tr, 'image': Assets.iconInvite},
    {'title': Tr.app_receive_gift.tr, 'image': Assets.iconDiamondF},
    {'title': Tr.app_mine_setting.tr, 'image': Assets.iconSetting},
    {'title': Tr.app_bind_google.tr, 'image': Assets.iconSmallLogo},
    {'title': Tr.app_setting_search.tr, 'image': Assets.iconSearch},
    {'title': Tr.app_setting_day_sign.tr, 'image': Assets.iconCheckIn}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*BuildLucky(logic),
        if (!logic.state.isBindGoogle && (!AppConstants.isFakeMode))
          BuildBindingGoogle(logic),*/
        Container(
          margin: const EdgeInsetsDirectional.only(
              start: 20, end: 20, bottom: 10, top: 5),
          child: contentList(),
        ),
        if (AppConstants.isFakeMode == false) BuildTrouble()
      ],
    );
  }

  Widget contentList() {
    return GetBuilder<MeLogic>(
        init: MeLogic(),
        builder: (logic) => Container(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 15, left: 0, right: 0),
              child: Column(
                children: [
                  if (logic.state.isVip) buildVip(),
                  if (logic.state.isVip)
                    const SizedBox(
                      width: double.maxFinite,
                      height: 15,
                    ),
                  if (!AppConstants.isFakeMode)
                    buildCell(9, logic, color: const Color(0x33FFA647)),
                  /*if (!AppConstants.isFakeMode)
                    const SizedBox(
                      width: double.maxFinite,
                      height: 15,
                    ),*/
                  // if (!AppConstants.isFakeMode) buildCell(2, logic),
                  if (!AppConstants.isFakeMode)
                    const SizedBox(
                      width: double.maxFinite,
                      height: 15,
                    ),
                  buildCell(4, logic, color: const Color(0x33FB83AE)),
                  const SizedBox(
                    width: double.maxFinite,
                    height: 15,
                  ),
                  buildCell(5, logic, color: const Color(0x33B181FF)),
                  const SizedBox(
                    width: double.maxFinite,
                    height: 15,
                  ),
                  buildCell(3, logic, color: const Color(0x33FB83AE)),
                  const SizedBox(
                    width: double.maxFinite,
                    height: 15,
                  ),
                  buildCell(6, logic, color: const Color(0x333BC2FF)),
                  /*const SizedBox(
                    width: double.maxFinite,
                    height: 15,
                  ),*/
                  // buildCell(8, logic, color: const Color(0x33B181FF)),
                ],
              ),
            ));
  }

  Widget buildCell(int index, MeLogic logic, {Color? color}) {
    final data = listData[index];
    if ((index == 0 || index == 1 || index == 3) && AppConstants.isFakeMode) {
      return const SizedBox.shrink();
    }
    return InkWell(
      highlightColor: color,
      borderRadius: BorderRadius.circular(10),
      onTap: () => logic.toIndex(index),
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 7, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  data['image']!,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                ),
                (index == 7 && Get.locale?.languageCode == "vi")
                    ? Container(
                        width: 170.w,
                        alignment: AlignmentDirectional.centerStart,
                        margin:
                            const EdgeInsetsDirectional.only(start: 3, end: 3),
                        child: AutoSizeText(
                          data['title'] ?? "--",
                          textAlign: TextAlign.start,
                          minFontSize: index == 4 ? 7 : 15,
                          maxFontSize: 15,
                          maxLines: 1,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin:
                            const EdgeInsetsDirectional.only(start: 8, end: 3),
                        child: AutoSizeText(
                          data['title'] ?? "--",
                          textAlign: TextAlign.start,
                          minFontSize: index == 4 ? 7 : 15,
                          maxFontSize: 15,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
            Row(
              children: [
                index == 1
                    ? Container(
                        margin: const EdgeInsetsDirectional.only(end: 4),
                      )
                    : const SizedBox.shrink(),
                (index == 0 &&
                        logic.state.myDetail != null &&
                        logic.state.propCount != 0)
                    ? Container(
                        margin: const EdgeInsetsDirectional.only(end: 4),
                        child: Text(
                          "x${logic.state.propCount}",
                          style: const TextStyle(
                              color: Color(0xFFFF4864), fontSize: 12),
                        ),
                      )
                    : const SizedBox.shrink(),
                index == 4
                    ? bindText(logic.state.inviterCode)
                    : const SizedBox.shrink(),
                Image.asset(
                  matchTextDirection: true,
                  Assets.iconNext,
                  width: 20,
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bindText(String? inviterCode) => AutoSizeText(
        inviterCode ?? Tr.app_unbind.tr,
        maxFontSize: 13,
        minFontSize: 6,
        maxLines: 1,
        style: TextStyle(
            color: inviterCode == null
                ? const Color(0xFFFF4864)
                : const Color(0xFFBAAEB7),
            fontSize: 13),
      );

  Widget buildVip() => InkWell(
        highlightColor: const Color(0x33FFC14E),
        borderRadius: BorderRadius.circular(10),
        onTap: () => logic.toVip(),
        child: Container(
          width: double.maxFinite,
          padding:
              const EdgeInsetsDirectional.symmetric(vertical: 7, horizontal: 0),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 10),
                child: Image.asset(
                  Assets.iconVip,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                ),
              ),
              Expanded(child: GradientText(title: logic.state.showVipEndTime)),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 10),
                child: Image.asset(
                  matchTextDirection: true,
                  Assets.iconNext,
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
        ),
      );
}
