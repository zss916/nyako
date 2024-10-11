part of 'index.dart';

@RouteName(AppPages.connectFailed)
class ConnectFailedPage extends GetView<FailLogic> {
  const ConnectFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<FailLogic>(
          init: FailLogic(),
          builder: (logic) {
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned.fill(
                  child: BuildBackgrand(logic.anchorPortrait),
                ),
                SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        extendBodyBehindAppBar: true,
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                        margin:
                                            const EdgeInsetsDirectional.all(0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1, color: Colors.white)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: cachedImage(
                                              logic.anchorPortrait,
                                              type: 100),
                                        ),
                                      )),
                                  PositionedDirectional(
                                      end: 0,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        margin:
                                            const EdgeInsetsDirectional.all(0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1, color: Colors.white)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: cachedImage(
                                              UserInfo.to.myDetail?.portrait ??
                                                  ""),
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
                              child: Text(
                                Tr.app_video_chat_net_error.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () =>
                                  Get.removeName(AppPages.connectFailed),
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    bottom: 30),
                                child: Image.asset(
                                  Assets.imgHangUp,
                                  height: 75,
                                  width: 75,
                                  matchTextDirection: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ))),
              ],
            );
          }),
    );
  }
}
