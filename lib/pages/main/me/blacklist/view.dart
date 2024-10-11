part of 'index.dart';

@RouteName(AppPages.blackList)
class BlackPage extends GetView<BlackLogic> {
  const BlackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_dialog_add_black.tr,
      ),
      backgroundColor: const Color(0xFFF4F5F6),
      body: BlackBody(controller),
    );
  }
}
