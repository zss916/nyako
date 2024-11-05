import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/index.dart';

class BuildTools extends StatelessWidget {
  final bool isCall;
  final String charge;
  final AnchorDetailLogic logic;
  const BuildTools(this.isCall, this.charge, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return isCall ? call() : msg();
  }

  Widget call() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => logic.toChat(),
          child: Container(
            height: 52,
            width: 72,
            margin: const EdgeInsetsDirectional.only(top: 10, end: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF81E0FF),
                Color(0xFF4AC6FF),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(
              child: Image.asset(
                Assets.iconToMsgIcon,
                matchTextDirection: true,
                height: 32,
                width: 32,
              ),
            ),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () => logic.callUp(logic.state.anchorId.toString()),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 10),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 52,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: AlignmentDirectional.centerStart,
                              end: AlignmentDirectional.centerEnd,
                              colors: [
                                Color(0xFF8A29F8),
                                Color(0xFFFC0193),
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*Image.asset(
                            Assets.iconToCallIcon,
                            height: 32,
                            width: 32,
                            matchTextDirection: true,
                          ),*/
                          Lottie.asset(Assets.jsonAnimaCall,
                              width: 32, height: 32),
                          const SizedBox(
                            width: 10,
                          ),
                          AutoSizeText(
                            Tr.app_grade_video_chat.tr,
                            maxFontSize: 18,
                            minFontSize: 16,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Lottie.asset(Assets.jsonAnimaFlash),
                  ],
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 4, vertical: 2),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF822CFE), Color(0xFFD500FE)]),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(7),
                            topEnd: Radius.circular(7),
                            bottomStart: Radius.circular(7),
                            bottomEnd: Radius.circular(7))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: 2),
                              child: Image.asset(
                                Assets.iconDiamond,
                                width: 12,
                                height: 12,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: charge,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConstants.fontsBold,
                                fontSize: 14),
                          ),
                          TextSpan(
                            text: Tr.app_video_time_unit.tr,
                            style: TextStyle(
                                color: Colors.white60,
                                fontFamily: AppConstants.fontsRegular,
                                fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ))
      ],
    );
  }

  Widget msg() {
    return GestureDetector(
      onTap: () => logic.toChat(),
      child: Container(
        height: 52,
        margin: const EdgeInsetsDirectional.only(end: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF81E0FF),
            Color(0xFF4AC6FF),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 5),
              child: Image.asset(
                Assets.iconToMsgIcon,
                height: 32,
                width: 32,
                matchTextDirection: true,
              ),
            ),
            Text(
              Tr.app_base_message.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: AppConstants.fontsRegular,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
