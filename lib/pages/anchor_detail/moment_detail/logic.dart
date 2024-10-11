part of moment_detail_page;

class MomentDetailLogic extends GetxController {
  MomentDetail momentDetail = MomentDetail();
  int pageIndex = 0;
  //late final StreamSubscription<FollowEvent> followEvent;

  @override
  void onInit() {
    super.onInit();
    /*followEvent = AppEventBus.eventBus.on<FollowEvent>().listen((event) {

    });*/

    var arguments = Get.arguments as Map<String, dynamic>;
    momentDetail = arguments['momentDetail'];
    pageIndex = arguments['index'];
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    //followEvent.cancel();
  }

  handleFollow() {
    Http.instance.post<int>(NetPath.followUpApi + (momentDetail.userId ?? ""),
        errCallback: (err) {
      AppLoading.toast(err.message);
    }, showLoading: true).then((value) {
      momentDetail.followed = value;
      AppEventBus.eventBus.fire(FollowEvent(
          anchorId: (momentDetail.getUid), isFollowed: (value == 1)));
      update();
    });
  }
}
