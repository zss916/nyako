import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_card_entity.dart';
import 'package:oliapro/entities/app_sign_card_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/blacklist/utils/state.dart';
import 'package:oliapro/pages/main/me/cardlist/index.dart';
import 'package:oliapro/pages/main/me/cardlist/widget/avatar_item.dart';
import 'package:oliapro/pages/main/me/cardlist/widget/body.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/utils/app_extends.dart';

class CardList extends StatelessWidget {
  final int type;
  final PropLogic logic;
  const CardList(this.type, this.logic, {super.key});

  @override
  Widget build(BuildContext context) {
    //return buildCell(CardBean(), PropLogic());
    return buildContent(type, logic);
  }

  Widget buildContent(int type, PropLogic logic) {
    return switch (type) {
      _ when type == TabType.prop.index =>
        buildPropList(logic.chatData, logic.propData),
      _ when type == TabType.reward.index =>
        buildRewardList(logic.giftData, logic),
      _ when type == TabType.avatar.index => buildAvatarList(logic.signData),
      _ => const SizedBox.shrink(),
    };
  }

  ///道具卡
  Widget buildPropList(List<dynamic> data, List<dynamic> data2) =>
      (data.isEmpty && data2.isEmpty)
          ? showEmpty(logic)
          : buildPropContent(logic);

  Widget buildPropContent(PropLogic logic) {
    return showRefresh(
        logic,
        CustomScrollView(
          slivers: [
            if (logic.chatData.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildChatCardItem(logic.chatData[index], logic);
                  },
                  childCount: logic.chatData.length,
                ),
              ),
            if (logic.propData.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return buildCell(logic.propData[index], logic);
                  },
                  childCount: logic.propData.length,
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            )
          ],
        ));
  }

  Widget buildCell(CardBean item, PropLogic logic) {
    return GestureDetector(
      onTap: () => item.isPropCard ? logic.goHome() : logic.toRechargeCenter(),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 140,
            margin:
                const EdgeInsetsDirectional.only(top: 10, start: 15, end: 15),
            padding:
                const EdgeInsetsDirectional.only(bottom: 0, end: 16, top: 16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: item.isPropCard
                        ? [
                            const Color(0xFFF5EEFF),
                            const Color(0xFFFFEFF5),
                          ]
                        : [
                            const Color(0xFFFFEDE5),
                            const Color(0xFFFFF9EF),
                          ]),
                borderRadius: BorderRadiusDirectional.circular(16)),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  //color: Colors.green,
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 10),
                        child: Image.asset(
                          item.isPropCard
                              ? Assets.iconCallCard
                              : Assets.iconAddCard,
                          width: 64,
                          height: 64,
                          matchTextDirection: true,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 230),
                            child: AutoSizeText(
                              item.title,
                              maxLines: 1,
                              maxFontSize: 18,
                              minFontSize: 13,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppConstants.fontsBold,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: 5, end: 20),
                            width: double.maxFinite,
                            child: AutoSizeText(
                              item.content,
                              maxFontSize: 12,
                              minFontSize: 6,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: const Color(0xFF9B989D),
                                  fontFamily: AppConstants.fontsRegular,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                )),
                const Divider(
                  height: 1,
                  indent: 16 + 64 + 15,
                  color: Color(0x0f000000),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsetsDirectional.only(start: 16 + 64 + 15),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 0),
                        child: Text(
                          Tr.appUse.tr,
                          style: TextStyle(
                              color: const Color(0xFF9341FF),
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 13),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        Assets.iconNextPurple,
                        matchTextDirection: true,
                        width: 14,
                        height: 14,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          PositionedDirectional(
              top: 10,
              start: 15,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color(0xFFFE2C55),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(11),
                        bottomStart: Radius.zero,
                        topEnd: Radius.circular(11),
                        bottomEnd: Radius.circular(11))),
                child: AutoSizeText(
                  item.num,
                  maxLines: 1,
                  maxFontSize: 13,
                  minFontSize: 8,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildChatCardItem(AppLiveSignCard item, PropLogic logic) {
    return GestureDetector(
      onTap: () => logic.goHome(),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 140,
            margin:
                const EdgeInsetsDirectional.only(top: 10, start: 15, end: 15),
            padding:
                const EdgeInsetsDirectional.only(bottom: 0, end: 16, top: 16),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      Color(0xFFF5EEFF),
                      Color(0xFFEFF8FF),
                    ]),
                borderRadius: BorderRadiusDirectional.circular(15)),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  //color: Colors.green,
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 15),
                        child: Image.asset(
                          Assets.iconToolsChatCard,
                          width: 64,
                          height: 64,
                          matchTextDirection: true,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 230),
                            child: AutoSizeText(
                              item.showChatCardTitle,
                              maxLines: 1,
                              maxFontSize: 18,
                              minFontSize: 13,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppConstants.fontsBold,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                top: 5, end: 20),
                            width: double.maxFinite,
                            child: AutoSizeText(
                              item.showChatCardContent,
                              maxFontSize: 12,
                              minFontSize: 6,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: const Color(0xFF9B989D),
                                  fontFamily: AppConstants.fontsRegular,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                )),
                const Divider(
                  height: 1,
                  indent: 16 + 64 + 15,
                  color: Color(0x0f000000),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsetsDirectional.only(start: 16 + 64 + 15),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 0),
                        child: Text(
                          Tr.appUse.tr,
                          style: TextStyle(
                              color: const Color(0xFF9341FF),
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 13),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        Assets.iconNextPurple,
                        matchTextDirection: true,
                        width: 14,
                        height: 14,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          PositionedDirectional(
              top: 10,
              start: 15,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color(0xFFFE2C55),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(11),
                        bottomStart: Radius.zero,
                        topEnd: Radius.circular(11),
                        bottomEnd: Radius.circular(11))),
                child: AutoSizeText(
                  " x1 ",
                  maxLines: 1,
                  maxFontSize: 13,
                  minFontSize: 8,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: AppConstants.fontsRegular,
                      fontWeight: FontWeight.normal),
                ),
              )),
          /*if (item.propStatus != null)
            PositionedDirectional(
                top: 0,
                start: 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  margin: const EdgeInsetsDirectional.only(
                      top: 10, start: 15, end: 15),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(16),
                          topEnd: Radius.zero,
                          bottomStart: Radius.zero,
                          bottomEnd: Radius.circular(16)),
                      gradient: LinearGradient(
                          colors: [Color(0xFFFF3878), Color(0xFFFFCD1D)])),
                  child: AutoSizeText(
                    Tr.appEffect.tr,
                    textAlign: TextAlign.center,
                    maxFontSize: 14,
                    minFontSize: 12,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                )),*/
        ],
      ),
    );
  }

  ///奖励
  Widget buildRewardList(List<dynamic> data, PropLogic logic) =>
      data.isNotEmpty ? buildRewardContent(logic) : showEmpty(logic);

  Widget buildRewardContent(PropLogic logic) {
    return showRefresh(
        logic,
        CustomScrollView(
          slivers: [
            if (logic.giftData.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 136,
                      childAspectRatio: 106 / 136,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        childCount: logic.giftData.length,
                        (BuildContext context, int index) {
                      CardBean item = logic.giftData[index];
                      return Container(
                        width: double.maxFinite,
                        height: 136,
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [Colors.white30, Colors.white30]),
                          borderRadius: BorderRadiusDirectional.circular(16),
                        ),
                        child: Column(
                          children: [
                            cachedImage(item.showIcon, width: 50, height: 50),
                            Container(
                              alignment: AlignmentDirectional.center,
                              margin: const EdgeInsetsDirectional.only(top: 5),
                              child: AutoSizeText(
                                item.showName,
                                maxLines: 1,
                                maxFontSize: 14,
                                minFontSize: 6,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              margin: const EdgeInsetsDirectional.only(top: 2),
                              child: Text(
                                item.num,
                                style: const TextStyle(
                                  color: Color(0xFFFF497E),
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })),
              ),
          ],
        ));
  }

  ///签到头像
  Widget buildAvatarList(List<dynamic> data) =>
      data.isNotEmpty ? buildAvatarContent(logic) : showEmpty(logic);

  Widget buildAvatarContent(PropLogic logic) {
    return showRefresh(
        logic,
        CustomScrollView(
          slivers: [
            if (logic.signData.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 17,
                      mainAxisExtent: 230,
                      childAspectRatio: 163 / 230,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        childCount: logic.signData.length,
                        (BuildContext context, int index) {
                      AppLiveSignCard item = logic.signData[index];
                      return AvatarItem(item, logic);
                    })),
              ),
          ],
        ));
  }

  ///空
  Widget showEmpty(PropLogic logic) {
    return InkWell(
      onTap: () {
        logic.state = Status.INIT.index;
        logic.update();
        Future.delayed(const Duration(seconds: 3), () {
          logic.loadData();
        });
      },
      child: const BaseEmpty(),
    );
  }

  Widget showRefresh(PropLogic logic, Widget child) {
    return RefreshIndicator(onRefresh: () => refresh(logic), child: child);
  }

  ///刷新
  Future<void> refresh(PropLogic logic) async {
    logic.loadData();
    await Future.delayed(const Duration(seconds: 2));
  }
}
