part of 'index.dart';

class BlackLogic extends GetxController {
  late List<HostDetail> data = [];
  int state = Status.INIT.index; // 0 empty, 1 loading ,2 list

  @override
  void onInit() {
    super.onInit();
    state = Status.INIT.index;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future loadData() async {
    final value = await CommonAPI.loadBlackList(showLoading: false);
    data.clear();
    data.addAll(value);
    state = data.isEmpty ? Status.EMPTY.index : Status.DATA.index;
    update();
  }

  void removeBlack(String anchorId, int index, {String? avatar}) {
    Get.dialog(AppDialogConfirm(
      title: Tr.app_dialog_remove_black.tr,
      showIcon: false,
      avatar: avatar,
      h: 300,
      callback: (i) {
        if (anchorId == AppConstants.serviceId) {
          AppLoading.toast(Tr.app_base_success.tr);
          StorageService.to.updateBlackList(anchorId, false);
          return;
        }
        relieveBlackout(anchorId);
        data.removeAt(index);
        update();
      },
    ));
  }

  relieveBlackout(String anchorId) async {
    final data = await ProfileAPI.relieveBlackout(anchorId);
    AppLoading.toast(Tr.app_base_success.tr);
    StorageService.to.updateBlackList(anchorId, data == 1);
  }
}
