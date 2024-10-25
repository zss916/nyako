part of 'index.dart';

@RouteName(AppPages.callList)
class ChatRecordPage extends GetView<ChatRecordLogic> {
  const ChatRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD8D8D8),
      body: ChatRecordBody(),
    );
  }
}
