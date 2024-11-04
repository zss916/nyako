part of matching_page;

class MatchingPage extends GetView<MatchingLogic> {
  const MatchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        backgroundColor: Colors.transparent,
        title: Tr.app_match_title.tr,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Image.asset(
                  Assets.iconMatchingBg,
                  matchTextDirection: true,
                )),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 80),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  RepaintBoundary(
                      child: AvatarGlow(
                    glowRadiusFactor: 1,
                    glowColor: const Color(0xFF8C2CF6),
                    child: const SizedBox(
                      width: 90,
                      height: 90,
                    ),
                  )),
                  const RepaintBoundary(child: RotationWidget()),
                  Container(
                    decoration: BoxDecoration(
                        border: const GradientBoxBorder(
                          gradient: LinearGradient(colors: [
                            Color(0xFFF83DB1),
                            Color(0xFF8C2CF6),
                            Color(0xFF7D3DFF),
                            Color(0xFFF62D68),
                            Color(0xFFC046FE)
                          ]),
                          width: 3,
                        ),
                        borderRadius: BorderRadiusDirectional.circular(100)),
                    padding: const EdgeInsetsDirectional.all(3),
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: cachedImage(UserInfo.to.userPortrait,
                          width: 78, height: 78),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 10),
                  child: Text(
                    "正在为你寻找有缘人",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      bottom: 30, start: 20, end: 20, top: 15),
                  child: Text(
                    "请你心等待..",
                    style: TextStyle(
                        color: Color(0xFF9B989D),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 207,
                    height: 56,
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsetsDirectional.only(
                        bottom: 80, start: 20, end: 20),
                    decoration: BoxDecoration(
                        color: const Color(0x1A9341FF),
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    child: Text(
                      Tr.app_base_cancel.tr,
                      style: const TextStyle(
                          color: Color(0xFF9341FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
