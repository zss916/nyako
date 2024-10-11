part of 'index.dart';

class MsgListPage extends GetView<MsgListLogic> {
  const MsgListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgNew,
      body: MsgListBody(controller),
    );
  }
}
