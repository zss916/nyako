import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
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
        ? GestureDetector(
            onTap: () {
              showComplianceDialog();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0x4DFF1A45),
                  Color(0x4DFF17D6),
                ]),
                borderRadius: BorderRadiusDirectional.circular(0),
              ),
              padding: const EdgeInsetsDirectional.only(
                  start: 8, top: 13, bottom: 13, end: 12),
              margin:
                  const EdgeInsetsDirectional.only(start: 0, end: 0, top: 0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    Tr.appCompliance.tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: const Color(0xFF9B6D87),
                        fontFamily: AppConstants.fontsRegular,
                        fontSize: 13),
                  )),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Image.asset(
                      Assets.iconExpandIc,
                      width: 30,
                      height: 30,
                      matchTextDirection: true,
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
