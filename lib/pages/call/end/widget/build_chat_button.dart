import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
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
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 20),
            child: Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: AppColors.btnGradient,
                borderRadius: BorderRadiusDirectional.circular(45),
              ),
              child: Row(
                children: [
                  const Spacer(),
                  RepaintBoundary(
                    child: Image.asset(
                      Assets.animaCall,
                      width: 30,
                      height: 30,
                      matchTextDirection: true,
                      fit: BoxFit.fill,
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
          ),
          PositionedDirectional(
              end: 20,
              bottom: 60,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color(0xFF1E1226),
                    border: Border.all(width: 0, color: Colors.transparent),
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(37),
                        bottomStart: Radius.circular(37),
                        topEnd: Radius.circular(37),
                        bottomEnd: Radius.circular(0))),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              bottom: 2, end: 2),
                          child: Image.asset(
                            Assets.imgDiamond,
                            matchTextDirection: true,
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "${logic.detail?.charge ?? 0}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: Tr.app_video_time_unit.tr,
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
