part of 'index.dart';

class DiscoverPage extends GetView<MomentLogic> {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DragWebpFront(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        leading: const SizedBox.shrink(),
        systemOverlayStyle: lightBarStyle,
      ),
      backgroundColor: Colors.black,
      body: DiscoverBody(),
    ));
  }
}
