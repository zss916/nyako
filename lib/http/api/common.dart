part of 'index.dart';

abstract class CommonAPI {
  ///config
  static Future<ConfigData> config({bool showLoading = false}) async {
    final result = await Http.instance.post<ConfigData>(NetPath.configApiV2,
        showLoading: showLoading, errCallback: (e) {
      AppLoading.toast(e.message);
      Future.delayed(const Duration(seconds: 8), () {
        config(showLoading: true);
      });
    });
    UserInfo.to.config = result;
    AppConstants.openFacebookLogin = (result.openFbLogin == true);
    return result;
  }

  ///礼物
  static Future<void> gifts() async {
    await Http.instance.post<List<GiftEntity>>(NetPath.giftAllListApi,
        errCallback: (err) {
      AppLoading.toast(err.message);
    }).then((value) {
      if (value.isNotEmpty) {
        String jsonGifts = json.encode(value);
        // debugPrint("gifts===>>>>  ${jsonGifts}");
        StorageService.to.prefs.setString(
            "${Get.locale?.languageCode}_${AppConstants.giftsJson}", jsonGifts);
      }
    });
  }

  ///敏感词
  static Future<void> sensitiveWords() async {
    await Http.instance
        .post<List<SensitiveWordBean>>(NetPath.sensitiveWordsApi,
            errCallback: (err) {})
        .then((value) {
      if (value.isNotEmpty) {
        List<String> list = value.map((e) => e.words ?? '').toList();
        UserInfo.to.sensitiveList = list;
      }
    });
  }

  ///搜索主播
  static Future<HostDetail> searchAnchor(String anchorId) async {
    final data = await Http.instance.post<HostDetail>(
      NetPath.searchUpApi + anchorId.trim(),
      showLoading: true,
    );
    return data;
  }

  ///获取拉黑列表
  static Future<List<HostDetail>> loadBlackList(
      {bool showLoading = true}) async {
    return await Http.instance.post<List<HostDetail>>(
      NetPath.blacklistApi,
      showLoading: showLoading,
      data: {
        "page": 1,
        "pageSize": 200,
      },
    );
  }

  ///获取邀请信息
  static Future<InviteInfoEntity> loadInviteInfo() async {
    final data = await Http.instance.post<InviteInfoEntity>(
      NetPath.getInviteInfo,
    );
    return data;
  }

  ///获取道具卡/加成卡
  static Future<List<CardBean>> loadCards() async {
    return await Http.instance.post<List<CardBean>>(NetPath.toolsApi,
        errCallback: (err) {
      AppLoading.toast(err.message);
    });
  }

  ///签到头像
  static Future<List<AppLiveSignCard>> loadSignAvatar() async {
    return await Http.instance.post<List<AppLiveSignCard>>(
        NetPath.loadSignAvatar, errCallback: (err) {
      AppLoading.toast(err.message);
    });
  }

  ///获取banner
  static Future<List<BannerBean>> loadBanner() async {
    return await Http.instance.post<List<BannerBean>>(NetPath.bannerApi);
  }

  ///发送砖石礼物
  static Future<SendGiftResult> sendDiamondGift({
    required String receiverId,
    int? gid,
    VoidCallback? errCall,
    bool isSystem = false,
    bool showLoading = true,
  }) async {
    //debugPrint("sendDiamondGift showing");
    return await Http.instance.post<SendGiftResult>(NetPath.sendDiamondGiftApi,
        data: {
          "receiverId": isSystem ? AppConstants.systemId : receiverId,
          "quantity": 1,
          "gid": gid
        },
        showLoading: showLoading, errCallback: (err) {
      errCall?.call();
      if (err.code == 8) {
        ChargeDialogManager.showChargeDialog(
            ChargePath.chating_send_gift_no_money,
            upid: receiverId,
            showBalanceText: true);
        AppLoading.toast(err.message, duration: const Duration(seconds: 3));
      }
      /* if (err.code == 25) {
        toVipDialog(path: ChargePath.recharge_vip_dialog_match, index: 0);
      }*/
    });
  }

  ///发送背包礼物
  static Future<SendGiftResult> sendPackagesGift(
      {required String receiverId,
      int? gid,
      VoidCallback? errCall,
      bool isSystem = false,
      bool showLoading = true}) async {
    return await Http.instance.post<SendGiftResult>(NetPath.sendPackageGiftApi,
        data: {
          "receiverId": isSystem ? AppConstants.systemId : receiverId,
          "quantity": 1,
          "gid": gid
        },
        showLoading: showLoading, errCallback: (err) {
      errCall?.call();
    });
  }
}
