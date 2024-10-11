part of connect_fail;

class FailLogic extends GetxController {
  late String anchorPortrait;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    anchorPortrait = arguments['anchorPortrait'];
    update();
  }
}
