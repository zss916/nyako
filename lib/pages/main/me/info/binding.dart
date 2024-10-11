part of 'index.dart';

class EditBinding implements Bindings {
  @override
  void dependencies() => Get.put<EditLogic>(EditLogic());
}
