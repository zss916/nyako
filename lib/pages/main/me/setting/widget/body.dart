import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/setting/index.dart';
import 'package:oliapro/pages/main/me/setting/widget/build_log_out.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/semantics/label.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

class SetBody extends StatelessWidget {
  final SetLogic logic;

  const SetBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    if (AppConstants.isFakeMode == false) {
      logic.listData
          .add({'title': Tr.app_setting_trouble.tr, 'type': 'trouble'});
      logic.isDoNotDisturb =
          UserInfo.to.myDetail?.isDoNotDisturb == 1 ? true : false;
    }
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadiusDirectional.circular(14)),
          margin: const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              /*          if (AppConstants.isFakeMode == false)
                GetBuilder<SetLogic>(
                    id: "disturbId",
                    builder: (logic) =>
                        buildCellTrouble(logic.listData[4], hasTrouble: true)),*/
              buildCell(logic.listData[0]),
              const Divider(
                height: 1,
                indent: 10,
                endIndent: 10,
                color: Color(0xFFE3E3E3),
              ),
              //buildCell(logic.listData[1]),
              // buildCell(logic.listData[3]),
              buildCell(logic.listData[6]),
              const Divider(
                height: 1,
                indent: 10,
                endIndent: 10,
                color: Color(0xFFE3E3E3),
              ),
              buildCell(logic.listData[5]),
              const Divider(
                height: 1,
                indent: 10,
                endIndent: 10,
                color: Color(0xFFE3E3E3),
              ),
              buildCell(logic.listData[2]),
            ],
          ),
        ),
        const Spacer(),
        BuildLogout(logic)
      ],
    );
  }

  Widget buildCell(Map data, {bool hasSize = false, bool hasTrouble = false}) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
      child: InkWell(
        //splashColor: const Color(0xFF7934F0),
        borderRadius: BorderRadius.circular(12),
        // behavior: HitTestBehavior.translucent,
        onTap: () => logic.pushView(data['type']!),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadiusDirectional.circular(12)),
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 20, horizontal: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 10),
                child: Image.asset(
                  data['image']!,
                  width: 20,
                  height: 20,
                  matchTextDirection: true,
                ),
              ),
              Text(
                data['title']!,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              !hasTrouble
                  ? Image.asset(
                      Assets.iconNext,
                      width: 20,
                      height: 20,
                      matchTextDirection: true,
                    )
                  : CupertinoSwitch(
                      onChanged: (changed) => logic.switchDND(changed),
                      value: logic.isDoNotDisturb,
                      trackColor: const Color(0xFFDBDBDB),
                      activeColor: const Color(0xFF8239FF),
                      thumbColor: Colors.white,
                    ).onLabel(label: SemanticsLabel.check),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCellTrouble(Map data,
      {bool hasSize = false, bool hasTrouble = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => logic.pushView(data['type']!),
      child: Container(
        margin: const EdgeInsetsDirectional.only(bottom: 10),
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: Image.asset(
                data['image']!,
                width: 20,
                height: 20,
                matchTextDirection: true,
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsetsDirectional.only(end: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  /*Container(
                    margin: const EdgeInsetsDirectional.only(top: 5),
                    child: Text(
                      Tr.appTroubleTip.tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )*/
                ],
              ),
            )),
            !hasTrouble
                ? Image.asset(
                    Assets.imgArrowEnd,
                    width: 18,
                    height: 18,
                    color: const Color(0xFFB6B6B6),
                    matchTextDirection: true,
                  )
                : CupertinoSwitch(
                    onChanged: (changed) => logic.switchDND(changed),
                    value: logic.isDoNotDisturb,
                    trackColor: const Color(0xFFDBDBDB),
                    activeColor: const Color(0xFF8239FF),
                    thumbColor: Colors.white,
                  ).onLabel(label: SemanticsLabel.check),
          ],
        ),
      ),
    );
  }
}
