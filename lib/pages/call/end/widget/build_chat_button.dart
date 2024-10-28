import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/end/index.dart';
import 'package:oliapro/routes/a_routes.dart';

class BuildChatButton extends StatelessWidget {
  final EndLogic logic;

  const BuildChatButton(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ARoutes.toLocalCall(logic.herId ?? '', logic.portrait ?? '',
            closeSelf: true);
      },
      child: btn(logic),
    );
  }

  Widget btn(EndLogic logic) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Row(
        children: [
          Container(
            height: 52,
            width: 72,
            margin: const EdgeInsetsDirectional.only(end: 12),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFF81E0FF),
                  Color(0xFF4AC6FF),
                ]),
                borderRadius: BorderRadiusDirectional.circular(30)),
            child: Image.asset(
              Assets.iconToMsgIcon,
              width: 32,
              height: 32,
              matchTextDirection: true,
            ),
          ),
          Expanded(
              child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 52,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFF8A29F8),
                    Color(0xFFFC0193),
                  ]),
                  borderRadius: BorderRadiusDirectional.circular(45),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    RepaintBoundary(
                      child: Image.asset(
                        Assets.iconCallIc,
                        width: 30,
                        height: 30,
                        matchTextDirection: true,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      child: Text(
                        Tr.app_grade_video_chat.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              PositionedDirectional(
                  end: 20,
                  bottom: 60,
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF822CFE),
                          Color(0xFFD500FE),
                        ]),
                        border: Border.all(width: 0, color: Colors.transparent),
                        borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(7),
                            bottomStart: Radius.circular(7),
                            topEnd: Radius.circular(7),
                            bottomEnd: Radius.circular(7))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                  bottom: 2, end: 2),
                              child: Image.asset(
                                Assets.iconDiamond,
                                matchTextDirection: true,
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "${logic.detail?.charge ?? 0}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: Tr.app_video_time_unit.tr,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
