part of contribute_list_page;

class ContributeListLogic extends GetxController {
  late String herId;
  HostDetail? detail;
  late List<ContributeEntity> contributions = []; //贡献排行榜
  //var myVapController = VapController();

  ContributeEntity? sortAAvatar;
  ContributeEntity? sortBAvatar;
  ContributeEntity? sortCAvatar;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments as Map<String, dynamic>;
    herId = arguments['herId']!;
    detail = arguments['host'];
  }

  @override
  void onReady() {
    super.onReady();
    loadRankList(herId);
  }

  loadRankList(String anchorId) {
    contributions.clear();
    Http.instance.post<List<ContributeEntity>>(
        NetPath.contributeList + anchorId,
        showLoading: true, errCallback: (error) {
      AppLoading.toast(error.message);
    }).then((value) {
      //value.removeRange(1, value.length);

      if (value.length == 1) {
        sortAAvatar = value[0];
      }
      if (value.length == 2) {
        sortAAvatar = value[0];
        sortBAvatar = value[1];
      }
      if (value.length >= 3) {
        sortAAvatar = value[0];
        sortBAvatar = value[1];
        sortCAvatar = value[2];
      }
      if (value.length >= 4) {
        value.removeRange(0, 3);
        contributions.addAll(value);
      }
      update();
    });
  }

  /* void clickGift() {
    */ /*Get.bottomSheet(
      GiftListView(
        choose: (LlGiftEntity gift) {
          sendGift(gift);
        },
        herId: herId,
      ),
      backgroundColor: LlColors.baseColorBlackBg,
    );*/ /*
  }

  void sendGift(GiftEntity gift) {
    Http.instance.post<SendGiftResult>(NetPath.sendGiftApi,
        data: {"receiverId": herId, "quantity": 1, "gid": gift.gid},
        showLoading: true, errCallback: (err) {
      if (err.code == 8) {
        GameDialogManager.openChargeDialog(
          ChargePath.chating_send_gift_no_money,
          upid: herId,
        );
        AppLoading.toast(err.message, duration: const Duration(seconds: 3));
      } else if (err.code == 25) {
        */ /*GameDialogManager.openVipDialog(4,
            createPath: ChargePath.recharge_send_vip_gift);*/ /*
      }
    }).then((value) {
      // _getContributeList();
      // myVapController.playGift(gift);
      var json = RtmMsgSender.makeRTMMsgGift(herId, gift, value.gid.toString());
      var msg = MsgEntity(UserInfo.to.userLogin?.userId ?? '', herId, 0, 'gift',
          DateTime.now().millisecondsSinceEpoch, json, RTMMsgGift.typeCode,
          msgEventType: MsgEventType.sendDone, sendState: 0);
      msg.rawData = json;
      StorageService.to.objectBoxMsg.insertOrUpdateMsg(msg);
    });
  }*/
}
