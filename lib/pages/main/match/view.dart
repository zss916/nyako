part of match_page;

class MatchPage extends GetView<MatchLogic> {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        leading: const SizedBox.shrink(),
        title: Tr.app_match_title.tr,
      ),
      body: MusicBgm(
        controller,
        child: GameBody(controller),
      ),
    );
  }
}
