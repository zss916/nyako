part of 'index.dart';

class AnchorDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<AnchorDetailLogic>(() => AnchorDetailLogic());
  }
}
