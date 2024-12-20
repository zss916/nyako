import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/dialog_confirm_hang.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/call/aiv/widget/connecting/connecting_webp.dart';
import 'package:nyako/pages/call/call/index.dart';
import 'package:nyako/pages/call/remote/widget/build_backgrand.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';

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
                        width: double.maxFinite,
                        margin: const EdgeInsetsDirectional.only(
                            top: 60, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 68,
                              height: 68,
                              padding: const EdgeInsetsDirectional.all(6),
                              margin: const EdgeInsetsDirectional.all(0),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x33FF3881), blurRadius: 6)
                                  ],
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1.5,
                                      color: const Color(0xFFFF3881))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: cachedImage(logic.detail?.portrait ?? "",
                                    type: 100),
                              ),
                            ),
                            const ConnectingWebp(),
                            Container(
                              width: 68,
                              height: 68,
                              padding: const EdgeInsetsDirectional.all(6),
                              margin: const EdgeInsetsDirectional.all(0),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x334E70FF), blurRadius: 6)
                                  ],
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1.5,
                                      color: const Color(0xFF4E70FF))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: cachedImage(
                                    UserInfo.to.myDetail?.portrait ?? ""),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 0),
                        child: Text(
                          Tr.appConnectingWait.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.normal),
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
                            Assets.iconHangUp,
                            width: 84,
                            height: 84,
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
