part of 'index.dart';

class ReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportLogic>(() => ReportLogic());
  }
}
