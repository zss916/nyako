part of 'index.dart';

class MsgListPage extends GetView<MsgListLogic> {
  const MsgListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        leading: const SizedBox.shrink(),
        systemOverlayStyle: darkBarStyle,
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: MsgListBody(controller),
    );
  }
}
