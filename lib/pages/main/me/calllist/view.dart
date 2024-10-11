part of 'index.dart';

@RouteName(AppPages.callList)
class ChatRecordPage extends GetView<ChatRecordLogic> {
  const ChatRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_my_call_list.tr,
      ),
      backgroundColor: AppColors.splashBg,
      body: ChatRecordBody(controller),
    );
  }
}
