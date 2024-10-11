import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_card_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/index.dart';
import 'package:oliapro/pages/charge/charge_dialog_manager.dart';
import 'package:oliapro/widget/gift/app_gift_data_helper.dart';
import 'package:oliapro/widget/gift/prop_gift_list_widget.dart';
import 'package:oliapro/widget/gift/widget/build_balance.dart';

import '../../entities/app_gift_entity.dart';
import 'app_gift_list_widget.dart';

typedef GiftChoose = Function(GiftEntity entity);

/// 送礼物弹窗列表
class AppGiftListView extends StatefulWidget {
  final GiftChoose choose;
  // 主播id
  final String? herId;
  final bool? isChatOrCall;
  final bool? showFreeDiamondPage;

  const AppGiftListView({
    super.key,
    required this.choose,
    this.herId,
    this.isChatOrCall,
    this.showFreeDiamondPage = true,
  });

  @override
  State<AppGiftListView> createState() => _AppGiftListViewState();
}

class _AppGiftListViewState extends State<AppGiftListView> {
  late List<GiftEntity> list = <GiftEntity>[];
  late List<GiftEntity> vipList = <GiftEntity>[];
  late List<CardBean> giftData = [];
  late int selectedIndex = 0;
  int tabIndex = 0;
  //late final AppCallback<SocketBalance> _balanceListener;

  @override
  void initState() {
    super.initState();
    AivLogic.openGiftDialog = true;
    /*_balanceListener = (balance) {
      */ /*setState(() {
        UserInfo.to.myDetail?.userBalance?.remainDiamonds = balance.diamonds;
      });*/ /*
    };*/
    // debugPrint(" gift add");
    //AppSocketManager.to.addBalanceListener(_balanceListener);
    getGift();
  }

  @override
  void dispose() {
    super.dispose();
    AivLogic.openGiftDialog = false;
  }

  @override
  void deactivate() {
    //debugPrint(" gift deactivate");
    // AppSocketManager.to.removeBalanceListener(_balanceListener);
    super.deactivate();
  }

  void getGift() {
    list.clear();
    vipList.clear();
    giftData.clear();
    GiftDataHelper.getGifts().then((value) {
      setState(() {
        list.addAll(value!);
        vipList.addAll(value.where((element) => element.vipVisible == 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradientDialogsBg,
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(30),
          topEnd: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: Image.asset(Assets.imgDialogTopBg)),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 0, top: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    ChargeDialogManager.showChargeDialog(
                        ChargePath.gift_send_no_money,
                        upid: widget.herId,
                        showFreeDiamondPage: widget.showFreeDiamondPage!);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                end: 3, start: 3),
                            child: Image.asset(
                              Assets.imgDiamond,
                              matchTextDirection: true,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          /*AutoSizeText(
                        Tr.app_base_balance.trArgs([
                          (UserInfo.to.myDetail?.userBalance?.remainDiamonds ??
                                  0)
                              .toString()
                        ]),
                        maxLines: 1,
                        minFontSize: 10,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),*/

                          const BuildBalance()
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Tr.app_recharge.tr,
                            style: TextStyle(
                                color: const Color(0xFFF447FF),
                                fontSize: 14,
                                fontFamily: AppConstants.fontsBold,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset(
                            Assets.imgArrowEnd,
                            width: 16,
                            height: 16,
                            matchTextDirection: true,
                          )
                        ],
                      )

                      /*GestureDetector(
                  onTap: () {
                    // debugPrint("tabIndex ==> $tabIndex, selectedIndex ===> $selectedIndex");
                    GiftEntity? gift = getSelectGift(tabIndex, selectedIndex);
                    if (gift != null) {
                      if (gift.vipVisible == 1 &&
                          UserInfo.to.myDetail!.isVip == 0) {
                        // 不是VIP  显示购买VIP弹窗
                        toVipDialog(
                            path: ChargePath.recharge_send_vip_gift, index: 4);
                      } else {
                        Get.back();
                        widget.choose.call(gift);
                      }
                    }
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        gradient: AppColors.btnGradient,
                        borderRadius: BorderRadiusDirectional.circular(50)),
                    alignment: AlignmentDirectional.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
                    child: AutoSizeText(
                      Tr.app_gift_send.tr,
                      maxFontSize: 20,
                      minFontSize: 6,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ),*/
                    ],
                  ),
                ),
              ),
              _buildTabItem(),
              Container(
                color: Colors.transparent,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    if (tabIndex == 0)
                      (list.isEmpty) ? loading() : commonGift(),
                    if (tabIndex == 1)
                      (vipList.isEmpty) ? loading() : vipGift(),
                    if (tabIndex == 2)
                      (giftData.isEmpty) ? loading() : propGift(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildTabItem() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                if (mounted) {
                  setState(() {
                    tabIndex = 0;
                  });
                }
              },
              child: tab(
                tabIndex == 0,
                Tr.app_all_gift.tr,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                if (mounted) {
                  setState(() {
                    tabIndex = 1;
                  });
                }
              },
              child: tab(
                tabIndex == 1,
                Tr.app_vip_title.tr,
              ),
            ),
          ),
          if (giftData.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  if (mounted) {
                    setState(() {
                      tabIndex = 2;
                    });
                  }
                },
                child: tab(
                  tabIndex == 2,
                  Tr.app_my_gift.tr,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget tab(bool isSelect, String text) {
    return Container(
      padding: const EdgeInsetsDirectional.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelect ? FontWeight.bold : FontWeight.normal,
          color: isSelect ? Colors.white : Colors.white54,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget loading() {
    return Container(
      width: double.maxFinite,
      height: 300,
      alignment: AlignmentDirectional.center,
      child: Container(
        width: 30,
        height: 30,
        alignment: AlignmentDirectional.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget commonGift() {
    return AppGiftListWidget(
      giftList: list,
      isVip: false,
      callBack: (int index) {
        selectedIndex = index;
        widget.choose.call(list[index]);
      },
      key: GlobalKey(),
    );
  }

  Widget vipGift() {
    return AppGiftListWidget(
      giftList: vipList,
      isVip: true,
      callBack: (int index) {
        selectedIndex = index;
        widget.choose.call(vipList[index]);
      },
      key: GlobalKey(),
    );
  }

  Widget propGift() {
    return PropGiftListWidget(
      giftList: giftData,
      callBack: (int index) {
        selectedIndex = index;
        widget.choose.call(GiftEntity.createGift(giftData[index]));
      },
      key: GlobalKey(),
    );
  }

  GiftEntity? getSelectGift(int tabIndex, int index) {
    switch (tabIndex) {
      case 0:
        return list[index];
      case 1:
        return vipList[index];
      case 2:
        return GiftEntity.createGift(giftData[index]);
      default:
        return null;
    }
  }
}
