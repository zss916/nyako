part of 'index.dart';

class InviteCodeLogic extends GetxController {
  late String inviteCode = "";
  late bool isTimeOut = false;

  late TextEditingController controller = TextEditingController(text: "");
  late String stateStr = Tr.app_binding_code_tip1.tr; //0默认，1已经绑定，2无法绑定

  late int state = 0; //0默认，1已经绑定，2无法绑定

  @override
  void onReady() {
    super.onReady();
    inviteCode = Get.arguments[0] ?? "";
    isTimeOut = Get.arguments[1];
    if (inviteCode.isNotEmpty && !isTimeOut) {
      controller.text = inviteCode;
      stateStr = Tr.app_binding_code_tip1.tr;
      state = 1;
      update();
    }
  }

  bindCode() {
    inviteCode = controller.text;
    if (state == 0) {
      if (inviteCode.trim().isEmpty) {
        AppLoading.toast(Tr.app_input_invite_code.tr);
      } else {
        Http.instance.post(NetPath.bindInviteCode + inviteCode.trim(),
            errCallback: (error) {
          stateStr = error.message;
          update();
          AppLoading.toast(error.message);
        }, doneCallback: (success, result) {
          if (success) {
            state = 1;
            update();
            AppLoading.toast(Tr.app_base_success.tr);
            StorageService.to.eventBus.fire(eventBusRefreshMe);
          }
        });
      }
    } else if (state == 1) {
      AppLoading.toast(Tr.app_bound.tr);
    } else if (state == 2) {
      AppLoading.toast(Tr.app_can_not_bind.tr);
    }
  }
}
