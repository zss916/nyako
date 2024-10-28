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
                              width: double.maxFinite,
                              margin: const EdgeInsetsDirectional.only(
                                  top: 60, bottom: 30),
                              child: Row(
                                children: [
                                  Container(
                                    width: 68,
                                    height: 68,
                                    padding: const EdgeInsetsDirectional.all(6),
                                    margin: const EdgeInsetsDirectional.all(0),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0x33FF3881),
                                              blurRadius: 6)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color(0xFFFF3881))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: cachedImage(logic.anchorPortrait,
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
                                              color: Color(0x334E70FF),
                                              blurRadius: 6)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                  Assets.iconHangUp,
                                  height: 84,
                                  width: 84,
                                  matchTextDirection: true,
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
