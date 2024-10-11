part of 'index.dart';

class ShareLogic extends GetxController {
  InviteInfoEntity? data;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() async {
    final value = await CommonAPI.loadInviteInfo();
    data = value;
    update();
  }

  copyId() {
    if (data?.inviteCode != null) {
      Clipboard.setData(ClipboardData(text: data?.inviteCode ?? ""));
      AppLoading.toast(Tr.app_base_success.tr);
    }
  }
}
