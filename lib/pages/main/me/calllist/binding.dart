part of 'index.dart';

class RecordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRecordLogic>(() => ChatRecordLogic());
  }
}
