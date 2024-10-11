part of 'index.dart';

class PropLogic extends GetxController {
  ///加成卡/视频卡
  late List<CardBean> propData = [];

  ///聊天卡
  late List<AppLiveSignCard> chatData = [];

  ///游戏道具/礼物道具
  late List<CardBean> giftData = [];

  ///签到奖励头像
  late List<AppLiveSignCard> signData = [];
  late List<CardBean> data = [];

  late final StreamSubscription<BubbleAwardEvent> bubbleAwardEvent;

  late int state = Status.INIT.index;

  @override
  void onInit() {
    super.onInit();
    bubbleAwardEvent =
        AppEventBus.eventBus.on<BubbleAwardEvent>().listen((event) {
      loadData();
    });
    state = Status.INIT.index;
    update();
  }

  @override
  void onClose() {
    bubbleAwardEvent.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() async {
    propData.clear();
    giftData.clear();
    signData.clear();
    chatData.clear();

    var result = await Future.wait<dynamic>([
      CommonAPI.loadCards(),
      CommonAPI.loadSignAvatar(),
      ProfileAPI.info(showLoading: false),
      UserInfo.to.getSignFrame()
    ]);
    List<CardBean> list = result[0];
    List<AppLiveSignCard> list2 = result[1];
    InfoDetail info = result[2];
    UserInfo.to.setMyDetail = info;

    ///游戏道具卡
    List<CardBean> gifts =
        list.where((element) => element.propType == 3).toList();

    ///道具卡
    List<CardBean> props =
        list.where((element) => element.propType != 3).toList();
    propData.addAll(props);
    // propData.add(CardBean());
    giftData.addAll(gifts);

    /*giftData.add(CardBean());
    giftData.add(CardBean());
    giftData.add(CardBean());
    giftData.add(CardBean());*/

    //signData.add(AppLiveSignCard());
    //signData.add(AppLiveSignCard());

    ///签到奖励头像
    signData.addAll(list2.where((element) =>
        element.propType == 6 &&
        element.propStatus == 1 &&
        element.getRemainTimes() > 0));

    for (var element in signData) {
      element.isUsed = (AvatarStatusHand.getType() == AvatarStatus.sign.index);
    }

    /// 如果是vip,放一个空的表示vip的头像框
    if (UserInfo.to.isUserVip) {
      signData.add(AppLiveSignCard()
        ..propId = AvatarStatusHand.vipPropID
        ..showEndTime = vipEndTime(info.vipEndTime)
        ..isUsed = (AvatarStatusHand.getType() == AvatarStatus.vip.index));
    }

    ///聊天卡
    List<AppLiveSignCard> chatCards = list2
        .where((element) => element.propType == 5 && element.propStatus == 1)
        .toList();
    chatCards.sort((a, b) => a.getRemainTimes().compareTo(b.getRemainTimes()));
    if (chatCards.isNotEmpty) {
      chatData.add(chatCards.last);
    } else {
      chatData.addAll(chatCards);
    }

    // chatData.add(AppLiveSignCard());
    state = result.isEmpty ? Status.EMPTY.index : Status.DATA.index;
    update();
  }

  goHome() {
    Navigator.popUntil(
        Get.context!,
        (route) => ((Get.isDialogOpen != true &&
            Get.isBottomSheetOpen != true &&
            Get.isOverlaysOpen != true &&
            Get.isSnackbarOpen != true &&
            ARoutes.isMainPage)));
    AppEventBus.eventBus.fire(BackHomeEvent());
  }

  toRechargeCenter() => ARoutes.toRecharge();

  String vipEndTime(int? vipEndTime) {
    return (vipEndTime == null)
        ? ""
        : Tr.app_time_end
            .trArgs([dateFormat(vipEndTime, formatStr: 'yyyy.MM.dd')]);
  }

  ///处理状态
  void hand(int propId) {
    if (signData.isNotEmpty) {
      for (var value in signData) {
        value.isUsed = value.propId == propId;
      }
      update();
    }
  }

  @Deprecated("close")
  loadData2() {
    data.clear();
    giftData.clear();
    Http.instance.post<List<CardBean>>(NetPath.toolsApi, errCallback: (err) {
      AppLoading.toast(err.message);
    }, showLoading: true).then((value) {
      List<CardBean> gifts =
          value.where((element) => element.propType == 3).toList();
      List<CardBean> props =
          value.where((element) => element.propType != 3).toList();
      data.addAll(props);
      giftData.addAll(gifts);
      update();
    });
  }
}
