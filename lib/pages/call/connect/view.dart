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
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 0,
                  leading: const SizedBox.shrink(),
                  systemOverlayStyle: lightBarStyle,
                ),
                backgroundColor: Colors.black,
                extendBodyBehindAppBar: true,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsetsDirectional.only(
                          top: 120, bottom: 30),
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
                              child:
                                  cachedImage(logic.anchorPortrait, type: 100),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 10),
                            child: Lottie.asset(Assets.jsonAnimaLoveFail,
                                width: 60, height: 60),
                          ),
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
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 5, end: 5),
                      child: Text(
                        Tr.app_video_chat_net_error.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.removeName(AppPages.connectFailed),
                      child: Container(
                        width: 155,
                        height: 54,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5, vertical: 3),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: const Color(0x26FFFFFF),
                            borderRadius: BorderRadiusDirectional.circular(30)),
                        margin: const EdgeInsetsDirectional.only(bottom: 40),
                        child: Text(
                          Tr.appOK.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
