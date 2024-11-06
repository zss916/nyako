import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/pages/main/me/mine/index.dart';
import 'package:nyako/utils/app_loading.dart';

class BuildIdentity extends StatelessWidget {
  final MeLogic logic;
  const BuildIdentity(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(
                start: 5, end: 5, top: 4, bottom: 4),
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(6))),
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Text(
              "ID:${logic.state.username}",
              style: TextStyle(
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.normal,
                  color: logic.state.isVip
                      ? const Color(0xFF9B989D)
                      : const Color(0xFF9B989D),
                  fontSize: 15),
            ),
          ),
          /* Container(
            margin: const EdgeInsetsDirectional.only(start: 0),
            child: Image.asset(
              logic.state.isVip ? Assets.imgIdVipArrow : Assets.imgIdArrow,
              width: 24,
              height: 24,
              matchTextDirection: true,
            ),
          )*/
        ],
      ),
      onTap: () => copyId(logic.state.username),
    );
  }

  copyId(String identity) {
    Clipboard.setData(ClipboardData(text: identity));
    AppLoading.toast(Tr.app_base_success.tr);
  }
}
