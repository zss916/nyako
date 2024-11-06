import 'package:flutter/material.dart';
import 'package:nyako/pages/call/aiv/index.dart';
import 'package:nyako/pages/call/aiv/widget/page/aiv_widget.dart';
import 'package:nyako/pages/call/call/widget/call_header_tool.dart';
import 'package:nyako/widget/gift/app_vap_player.dart';

class AivBody extends StatelessWidget {
  final AivLogic logic;

  const AivBody(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        leading: const SizedBox.shrink(),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: logic.screenClearMode ? const SizedBox.shrink() : tools(logic),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => logic.switchClearMode(),
        child: Stack(
          children: [
            Positioned.fill(
              child: AivWidget(logic),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 10,
                bottom: 0,
                child: AppVapPlayer(
                  vapController: logic.myVapController,
                )),
          ],
        ),
      ),
    );
  }

  Widget tools(AivLogic logic) {
    return CallHeaderTool(
      detail: logic.detail,
      followed: logic.followed.value,
      audioMode: false,
      abandVolume: logic.deviceVolume.value,
      callBack: (CallToolEvent event) {
        switch (event) {
          case CallToolEvent.toolEventFollow:
            logic.handleFollow();
            break;
          case CallToolEvent.toolEventSwitchCamera:
            logic.switchCamera();
            break;
          case CallToolEvent.toolEventSwitchVoice:
            logic.switchVoice();
            break;
          case CallToolEvent.toolEventClose:
            logic.clickHangUp();
            break;
          default:
            break;
        }
      },
    );
  }
}
