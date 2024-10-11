part of 'index.dart';

class DynamicLogic extends GetxController with ListState {
  late List<LinkContent> list = [];
  late final StreamSubscription<MyMomentEvent> momentEvent;

  @override
  void onInit() {
    super.onInit();
    updateLoading();
  }

  @override
  void onReady() {
    super.onReady();
    loadDta();
    momentEvent = AppEventBus.eventBus.on<MyMomentEvent>().listen((event) {
      loadDta();
    });
  }

  @override
  void onClose() {
    momentEvent.cancel();
    super.onClose();
  }

  updateLoading() {
    loading;
    update();
  }

  updateEmpty() {
    if (list.isEmpty) {
      empty;
      update();
    }
  }

  loadDta() async {
    updateLoading();
    final value = await DynamicAPI.loadMyDynamic(uid: UserInfo.to.uid);
    list.clear();
    list.addAll(value);
    state = list.isEmpty ? empty : data;
    update();
  }

  void remove(String rId, int index) async {
    await DynamicAPI.deleteMyDynamic(rId);
    list.removeAt(index);
    update();
    AppLoading.toast(Tr.app_base_success.tr);
    updateEmpty();
  }

  void showRemoveDialog(String rId, int index) {
    Get.dialog(AppDialogConfirm(
      title: Tr.app_message_delete_tip.tr,
      showIcon: false,
      h: 290,
      callback: (i) {
        remove(rId, index);
      },
    ));
  }
}
