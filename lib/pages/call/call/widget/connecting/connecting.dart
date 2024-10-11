import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/dialogs/dialog_confirm_hang.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/widget/connecting/connecting_webp.dart';
import 'package:oliapro/pages/call/call/index.dart';
import 'package:oliapro/pages/call/remote/widget/build_backgrand.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';

class Connecting extends StatelessWidget {
  final CallLogic logic;

  const Connecting(this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned.fill(
            child: BuildBackgrand(logic.detail?.showPortrait ?? ""),
          ),
          SizedBox(
              width: Get.width,
              height: Get.height,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  extendBodyBehindAppBar: true,
                  body: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        height: 120,
                        margin: const EdgeInsetsDirectional.only(
                            top: 60, bottom: 30),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            PositionedDirectional(
                                start: 0,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsetsDirectional.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: cachedImage(
                                        logic.detail?.portrait ?? "",
                                        type: 100),
                                  ),
                                )),
                            PositionedDirectional(
                                end: 0,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: const EdgeInsetsDirectional.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: cachedImage(
                                        UserInfo.to.myDetail?.portrait ?? ""),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const ConnectingWebp(),
                      const Spacer(),
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 0),
                        child: const Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => toCancelButton(logic),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(bottom: 30),
                          padding: const EdgeInsetsDirectional.only(
                              top: 10, bottom: 10, start: 30, end: 30),
                          child: Image.asset(
                            Assets.imgHangUp,
                            width: 75,
                            height: 75,
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  toCancelButton(CallLogic logic) {
    showHangDialog(
      pathName: AppPages.cancelCallConnectingDialog,
      avatar: logic.detail?.portrait,
      callback: (i) {
        if (i == 1) {
          logic.clickHangUp();
        }
      },
    );
  }
}
