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
          ],
        ),
      ),
    );
  }
}
