part of 'index.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    //Get.create<ChatLogic>(() => ChatLogic());
    Get.put<ChatLogic>(ChatLogic(), tag: Get.arguments.toString());
  }
}
