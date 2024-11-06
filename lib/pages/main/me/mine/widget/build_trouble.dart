import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/mine/index.dart';
import 'package:nyako/pages/main/me/mine/widget/build_switch.dart';

class BuildTrouble extends StatelessWidget {
  const BuildTrouble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsetsDirectional.only(
          start: 20, end: 20, top: 0, bottom: 50),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 8),
                child: Image.asset(
                  Assets.iconDisturb,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                ),
              ),
              Text(
                Tr.app_setting_trouble.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              const Spacer(),
              GetBuilder<MeLogic>(
                  id: "disturbId",
                  builder: (logic) {
                    return BuildSwitch(
                      isSwitch: logic.isDoNotDisturb,
                      onChange: (changed) => logic.switchDND(changed),
                    );
                  })
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 10),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFF4F5F6),
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Text(
              Tr.appDisturbTip.tr,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: AppConstants.fontsRegular,
                  color: const Color(0xFF9B989D)),
            ),
          )
        ],
      ),
    );
  }
}
