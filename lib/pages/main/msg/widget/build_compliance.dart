import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/dialog_confirm_compliance.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/msg/index.dart';

class BuildCompliance extends StatefulWidget {
  final MsgListLogic logic;

  const BuildCompliance({super.key, required this.logic});

  @override
  State<BuildCompliance> createState() => _BuildComplianceState();
}

class _BuildComplianceState extends State<BuildCompliance> {
  @override
  Widget build(BuildContext context) {
    return widget.logic.isShowCompliance
        ? Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              GestureDetector(
                onTap: () {
                  showComplianceDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFF543B5F),
                          Color(0xFF41575A),
                        ]),
                    borderRadius: BorderRadiusDirectional.circular(16),
                  ),
                  padding: const EdgeInsetsDirectional.only(
                      start: 8, top: 13, bottom: 13, end: 12),
                  margin: const EdgeInsetsDirectional.only(
                      start: 12, end: 12, top: 0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 10),
                        child: Image.asset(
                          Assets.imgMsgNotify,
                          width: 30,
                          height: 30,
                          matchTextDirection: true,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        Tr.appCompliance.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )),
                      Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10),
                        width: 0.5,
                        height: 32,
                        color: const Color(0x33FFFFFF),
                      ),
                      RotatedBox(
                        quarterTurns: 0,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(top: 5),
                          child: Image.asset(
                            Assets.imgArrowR,
                            width: 20,
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  start: 12,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 0),
                    child: GestureDetector(
                      onTap: () {
                        widget.logic.closeCompliance();
                      },
                      child: Image.asset(
                        Assets.imgCloseHg2,
                        width: 24,
                        height: 24,
                        matchTextDirection: true,
                      ),
                    ),
                  ))
            ],
          )
        : const SizedBox.shrink();
  }
}
