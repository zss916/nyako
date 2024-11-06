import 'package:flutter/material.dart';
import 'package:nyako/dialogs/dialog_confirm_hang.dart';
import 'package:nyako/dialogs/sheet_report.dart';
import 'package:nyako/entities/app_host_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/widget/app_click_widget.dart';
import 'package:nyako/widget/app_user_widget.dart';

enum CallToolEvent {
  toolEventFollow,
  toolEventSwitchCamera,
  toolEventSwitchVoice,
  toolEventClose,
  toolEventDiamond,
  toolEventGift,
  toolEventOneGift,
}

class CallHeaderTool extends StatefulWidget {
  final HostDetail? detail;
  final int followed;
  final bool audioMode;

  ///是否是语音模式
  final bool abandVolume;
  final Function(CallToolEvent event) callBack;

  const CallHeaderTool({
    super.key,
    required this.detail,
    required this.followed,
    required this.audioMode,
    required this.abandVolume,
    required this.callBack,
  });

  @override
  State<CallHeaderTool> createState() => _CallHeaderToolState();
}

class _CallHeaderToolState extends State<CallHeaderTool> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.detail != null)
          UserWidget(
            detail: widget.detail!,
            callBack: () {
              widget.callBack(CallToolEvent.toolEventFollow);
            },
            showHostStatus: false,
            nameMaxWidth: 85,
          ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!widget.audioMode)
              AppClickWidget(
                  // onTap: controller.switchCamera,
                  onTap: () {
                    widget.callBack(CallToolEvent.toolEventSwitchCamera);
                  },
                  child: Image.asset(
                    Assets.iconCallCamera,
                    matchTextDirection: true,
                    width: 30,
                    height: 30,
                  )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  widget.callBack(CallToolEvent.toolEventSwitchVoice);
                },
                child: widget.abandVolume
                    ? Image.asset(
                        Assets.iconCallVoice,
                        width: 30,
                        height: 30,
                        matchTextDirection: true,
                      )
                    : Image.asset(
                        Assets.iconCallVoiceNo,
                        width: 30,
                        height: 30,
                        matchTextDirection: true,
                      )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () async {
                  if (widget.detail == null) return;
                  showReportSheet(widget.detail!.userId!, close: () {
                    widget.callBack(CallToolEvent.toolEventClose);
                  });

                  ///
                  /*showHostOptionSheet(
                      herId: widget.detail!.userId!,
                      close: () {
                        widget.callBack(CallToolEvent.toolEventClose);
                      });*/
                },
                child: Image.asset(
                  Assets.iconCallReport,
                  matchTextDirection: true,
                  height: 30,
                  width: 30,
                )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  showHangDialog(
                    pathName: AppPages.hangUpCallDialog,
                    avatar: widget.detail?.portrait,
                    callback: (i) {
                      if (i == 1) {
                        // controller.clickHangUp();
                        widget.callBack(CallToolEvent.toolEventClose);
                      }
                    },
                  );
                },
                child: Image.asset(Assets.iconCallClose,
                    matchTextDirection: true, height: 30, width: 30)),
            const SizedBox(
              width: 10,
            )
          ],
        ))
      ],
    );
  }
}
