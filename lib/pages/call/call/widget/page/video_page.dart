import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/dialogs/dialog_confirm_hang.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/pages/call/call/widget/call_header_tool.dart';
import 'package:oliapro/pages/call/call/widget/page/call_widget.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/widget/gift/app_vap_player.dart';

class VideoPage extends StatelessWidget {
  final CallLogic logic;

  const VideoPage(this.logic, {Key? key}) : super(key: key);

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
        title: titleAppBar(),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          logic.cleanMode();
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.loose,
          children: [
            const Positioned.fill(
              child: CallWidget(),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 10,
                bottom: 0,
                child: AppVapPlayer(
                  vapController: logic.myVapController,
                )),

            //logic.showWarn? const WarnTip():const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void toBack() {
    showHangDialog(
      pathName: AppPages.hangUpCallDialog,
      avatar: logic.detail?.portrait,
      callback: (i) {
        if (i == 1) {
          logic.clickHangUp();
        }
      },
    );
  }

  Widget titleAppBar() {
    return logic.screenClearMode
        ? const SizedBox.shrink()
        : Obx(() => CallHeaderTool(
              detail: logic.detail,
              followed: logic.followed.value,
              audioMode: logic.audioMode.value,
              abandVolume: logic.abandVolume.value,
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
                    // toBack();
                    break;
                  default:
                    break;
                }
              },
            ));
  }
}
