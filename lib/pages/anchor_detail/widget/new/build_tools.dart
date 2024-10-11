import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            height: 58,
            width: 90,
            margin: const EdgeInsetsDirectional.only(top: 10, end: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF7770FF),
                Color(0xFF5138FF),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(
              child: Image.asset(
                Assets.imgToMsgIcon,
                matchTextDirection: true,
                height: 30,
                width: 30,
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
                height: 58,
                margin: const EdgeInsetsDirectional.only(top: 10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFFAC53FB),
                          Color(0xFF7934F0),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imgToCallIcon,
                      height: 30,
                      width: 30,
                      matchTextDirection: true,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AutoSizeText(
                      Tr.app_grade_video_chat.tr,
                      maxFontSize: 20,
                      minFontSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
                        color: Color(0xFF1E1226),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(12),
                            topEnd: Radius.circular(12),
                            bottomStart: Radius.circular(12),
                            bottomEnd: Radius.zero)),
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
                                Assets.imgDiamond,
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
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 11),
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
        height: 58,
        margin: const EdgeInsetsDirectional.only(end: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF7770FF),
            Color(0xFF5138FF),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 5),
              child: Image.asset(
                Assets.imgToMsgIcon,
                height: 30,
                width: 30,
                matchTextDirection: true,
              ),
            ),
            Text(
              Tr.app_base_message.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
