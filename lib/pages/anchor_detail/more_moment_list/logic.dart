part of more_moments_page;

class MoreDynamicLogic extends GetxController {
  late List<MomentDetail> moments = []; //动态
  late String herId;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
  }

  @override
  void onReady() {
    super.onReady();
    loadMoment(herId);
  }

  loadMoment(String userId, {int page = 1}) {
    Http.instance.post<List<MomentDetail>>(NetPath.getMoments, data: {
      "page": page,
      "pageSize": 10,
      "userId": userId,
    }, errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      // 筛掉黑名单的动态
      Iterable<MomentDetail> arr = value
          .where((e) => !StorageService.to.checkMomentReportList(e.momentId));
      moments.addAll(arr);
      update();
    });
  }

  void showRemoveDialog(String rId, int index) {
    Get.dialog(AppDialogConfirm(
      title: Tr.app_message_delete_tip.tr,
      showIcon: false,
      h: 280,
      callback: (i) {
        remove(rId, index);
      },
    ));
  }

  void remove(String rId, int index) async {
    await DynamicAPI.deleteMyDynamic(rId);
    moments.removeAt(index);
    update();
    AppLoading.toast(Tr.app_base_success.tr);
  }
}
