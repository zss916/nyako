import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_card_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/cardlist/index.dart';
import 'package:oliapro/pages/widget/base_empty.dart';
import 'package:oliapro/utils/app_extends.dart';

class CardList2 extends StatelessWidget {
  const CardList2({super.key});

  @override
  Widget build(BuildContext context) {
    // return buildCell(CardBean(), PropLogic());
    return GetBuilder<PropLogic>(
      init: PropLogic(),
      assignId: true,
      builder: (logic) {
        return (logic.data.isNotEmpty || logic.giftData.isNotEmpty)
            ? buildContent(logic)
            : const BaseEmpty();
      },
    );
  }

  Widget buildContent(PropLogic logic) {
    return CustomScrollView(
      slivers: [
        if (logic.data.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    color: const Color(0xFFBB06FF),
                  ),
                  Text(
                    Tr.app_mine_my_prop.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return buildCell(logic.data[index], logic);
            },
            childCount: logic.data.length,
          ),
        ),
        if (logic.giftData.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    color: const Color(0xFFBB06FF),
                  ),
                  Text(
                    Tr.app_my_gift.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
          sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                mainAxisExtent: 110,
                childAspectRatio: 1 / 1,
              ),
              delegate:
                  SliverChildBuilderDelegate(childCount: logic.giftData.length,
                      (BuildContext context, int index) {
                CardBean item = logic.giftData[index];
                return Container(
                  width: double.maxFinite,
                  height: 110,
                  padding: const EdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B1A36),
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: Column(
                    children: [
                      cachedImage(item.showIcon, width: 50, height: 50),
                      /* Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 5),
                        child: AutoSizeText(
                          item.showName,
                          maxLines: 1,
                          maxFontSize: 14,
                          minFontSize: 6,
                          style: const TextStyle(
                            color: Color(0xFFBB06FF),
                            fontSize: 14,
                          ),
                        ),
                      ),*/
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.only(top: 2),
                        child: Text(
                          item.num,
                          style: const TextStyle(
                            color: Color(0xFFFE2C55),
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
    );
  }

  Widget buildCell(CardBean item, PropLogic logic) {
    return GestureDetector(
      onTap: () => item.isPropCard ? logic.goHome() : logic.toRechargeCenter(),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 94,
            margin:
                const EdgeInsetsDirectional.only(top: 10, start: 15, end: 15),
            padding: const EdgeInsetsDirectional.only(bottom: 10, end: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: item.isPropCard
                        ? [
                            const Color(0xFF9E49E0),
                            const Color(0xFFFF88F8),
                          ]
                        : [
                            const Color(0xFFFF7634),
                            const Color(0xFFFFC767),
                          ]),
                borderRadius: BorderRadiusDirectional.circular(16)),
            child: Container(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    child: Image.asset(
                      item.isPropCard ? Assets.imgCallCard : Assets.imgAddCard,
                      width: 60,
                      height: 60,
                      matchTextDirection: true,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 160),
                            child: AutoSizeText(
                              item.title,
                              maxLines: 1,
                              maxFontSize: 18,
                              minFontSize: 8,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          AutoSizeText(
                            item.num,
                            maxLines: 1,
                            maxFontSize: 16,
                            minFontSize: 8,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsetsDirectional.only(top: 6, end: 20),
                        width: double.maxFinite,
                        child: AutoSizeText(
                          item.content,
                          maxFontSize: 12,
                          minFontSize: 5,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
          ),
          PositionedDirectional(
              top: 10,
              end: 15,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 3, vertical: 2),
                decoration: const BoxDecoration(
                    color: Color(0xFFFE2C55),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.zero,
                        bottomStart: Radius.circular(10),
                        topEnd: Radius.circular(10),
                        bottomEnd: Radius.zero)),
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
              ))
        ],
      ),
    );
  }
}
