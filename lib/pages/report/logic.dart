part of 'index.dart';

class ReportLogic extends GetxController {
  var selectIndex = 0.obs;
  var content = '';
  TextEditingController? controller;
  final reportList = [
    Tr.app_report_text_1.tr,
    Tr.app_report_text_2.tr,
    Tr.app_report_text_3.tr,
    Tr.app_report_text_4.tr,
    Tr.app_report_text_5.tr,
    Tr.app_report_text_7.tr,
    Tr.app_report_text_8.tr,
    Tr.app_report_text_9.tr,
    Tr.app_report_text_6.tr
  ];
  String? upid;
  String? channelid;
  String? mid;
  int index = 0;
  int type = 0; // 0举报主播，1举报动态，2举报封面视频或主播图片视频,3举报app

  @override
  void onReady() {
    super.onReady();
    type = int.parse(Get.parameters["type"] ?? "0");
    upid = Get.parameters["upid"];
    channelid = Get.parameters["channelid"];
    index = int.parse(Get.parameters["index"] ?? "0");
    mid = Get.parameters["mid"];
  }

  void setSelect(int index) {
    selectIndex.value = index;
    update();
  }

  report() {
    Get.back();
    handReport();
    showReportDialog(type);
  }

  Future<void> handReport() async {
    Map<String, dynamic> data = {
      "type": "2",
      "anchorUserId": upid,
      "topic": reportList[selectIndex.value],
      "content": (controller?.text != null && controller!.text.isNotEmpty)
          ? controller!.text
          : "not input",
    };
    if (channelid != null) {
      data["linkId"] = channelid;
    }

    //debugPrint("===>>>> ${data.toString()}");
    await ProfileAPI.report(data: data, showLoading: false);
    // 举报后要拉黑
    if ((!StorageService.to.checkBlackList(upid)) && (upid != null)) {
      // debugPrint("===>>>> 拉黑 ${data.toString()}");
      await ProfileAPI.handBlack(anchorId: (upid ?? ""));
    }
  }

  void showReportDialog(int type) {
    Get.dialog(
        PopScope(
            canPop: false,
            child: AppDialogConfirm(
              title: Tr.app_report_thanks.tr,
              onlyConfirm: true,
              h: 260,
              callback: (int callback) {
                switch (type) {
                  case 0:

                    ///anchorDetail
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    AppEventBus.eventBus
                        .fire(ReportEvent(ReportEnum.anchorDetail.index));

                    break;
                  case 1:

                    ///moment
                    StorageService.to.updateMomentReportList(channelid);
                    AppEventBus.eventBus.fire(ReportEvent(
                        ReportEnum.moment.index,
                        momentId: channelid));
                    break;
                  case 2:

                    ///chat
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    AppEventBus.eventBus
                        .fire(ReportEvent(ReportEnum.chat.index));
                    break;
                  case 3:

                    ///discover
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    StorageService.to.updateMediaReportList(mid);
                    AppEventBus.eventBus.fire(ReportEvent(
                        ReportEnum.discover.index,
                        discoverIndex: mid));
                    break;
                  case 4:

                    ///settlement
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    break;
                  case 5:

                    ///anchorDetailMoment
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    StorageService.to.updateMomentReportList(channelid);
                    AppEventBus.eventBus.fire(ReportEvent(
                        ReportEnum.anchorDetailMoment.index,
                        momentId: channelid));
                    break;
                  case 6:

                    ///momentDetail
                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    StorageService.to.updateMomentReportList(channelid);
                    AppEventBus.eventBus.fire(ReportEvent(
                        ReportEnum.momentDetail.index,
                        momentId: channelid));

                    if (ARoutes.isMomentDetail) Get.back();
                    break;

                  case 7:
                    //setting

                    break;

                  case 8:
                    //match
                    AppEventBus.eventBus
                        .fire(ReportEvent(ReportEnum.match.index));
                    break;
                  case 9:
                    //anchorDetailImage

                    StorageService.to.updateBlackList(upid, true);
                    AppEventBus.eventBus.fire(BlackEvent(uid: upid));
                    StorageService.to.updateMediaReportList(mid);
                    AppEventBus.eventBus.fire(ReportEvent(
                        ReportEnum.anchorDetailImage.index,
                        mid: mid));
                    Get.back();

                    break;

                  default:
                    break;
                }
              },
            )),
        barrierDismissible: false);
  }
}
