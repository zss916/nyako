import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/chat/index.dart';
import 'package:oliapro/pages/chat/widget/buildLineState.dart';
import 'package:oliapro/utils/app_extends.dart';

class ChatPortrait extends StatelessWidget {
  final ChatLogic logic;
  const ChatPortrait(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            if (!logic.isSystemId)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: cachedImage(logic.herDetail?.showPortrait ?? "",
                      width: 40, height: 40),
                ),
              )
            else
              Image.asset(
                Assets.iconSystem,
                width: 40,
                height: 40,
                matchTextDirection: true,
              ),
            if (!logic.isSystemId)
              PositionedDirectional(
                  bottom: 0, end: 0, child: BuildLineState(logic)),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LimitedBox(
              maxWidth: 200,
              child: Text(
                logic.herId == AppConstants.systemId
                    ? Tr.app_message_official.tr
                    : logic.herId == AppConstants.serviceId
                        ? AppConstants.appName
                        : logic.herDetail?.nickname ?? '--',
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (logic.herId != AppConstants.systemId &&
                logic.herId != AppConstants.serviceId)
              Text.rich(
                TextSpan(
                  text: "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    WidgetSpan(
                        child: Container(
                      margin:
                          const EdgeInsetsDirectional.only(end: 2, bottom: 3),
                      child: Image.asset(
                        Assets.iconDiamond,
                        width: 15,
                        height: 15,
                        matchTextDirection: true,
                      ),
                    )),
                    TextSpan(
                        text: "${logic.herDetail?.charge ?? '--'}",
                        style: TextStyle(
                          color: const Color(0xFF9341FF),
                          fontSize: 14,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                      text: Tr.app_video_time_unit.tr,
                      style: TextStyle(
                        color: const Color(0xFF9B989D),
                        fontSize: 12,
                        fontFamily: AppConstants.fontsRegular,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ],
    );
  }
}
