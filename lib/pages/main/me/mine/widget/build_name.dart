import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/mine/index.dart';
import 'package:nyako/utils/app_some_extension.dart';

class BuildName extends StatelessWidget {
  const BuildName({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsetsDirectional.only(top: 10, end: 10, start: 10),
      child: GetBuilder<MeLogic>(
        init: MeLogic(),
        builder: (logic) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              child: AutoSizeText(
                (logic.state.nickName).convertName,
                maxLines: 1,
                maxFontSize: 20,
                minFontSize: 20,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (logic.state.isVip)
              Container(
                margin: const EdgeInsetsDirectional.only(start: 4),
                child: Image.asset(
                  Assets.iconVipBadge,
                  width: 42,
                  height: 18,
                ),
              )
          ],
        ),
      ),
    );
  }
}
