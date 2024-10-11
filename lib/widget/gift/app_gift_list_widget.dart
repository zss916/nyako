import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/widget/semantics/semantics_widget.dart';

import '../../entities/app_gift_entity.dart';
import '../app_net_image.dart';

class AppGiftListWidget extends StatefulWidget {
  final List<GiftEntity> giftList;
  final bool isVip;
  final Function(int index) callBack;

  const AppGiftListWidget(
      {super.key,
      required this.giftList,
      required this.isVip,
      required this.callBack});

  @override
  State<AppGiftListWidget> createState() => _AppGiftListWidgetState();
}

class _AppGiftListWidgetState extends State<AppGiftListWidget> {
  var pageSize = 8;
  var pageCount = 0;
  int currentPageIndex = 0;
  var lastPageSize = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageCount = (widget.giftList.length / pageSize).ceil();
    lastPageSize = widget.giftList.length % pageSize;
    if (lastPageSize == 0) {
      lastPageSize = pageSize;
    }
    return pageCount == 0
        ? const SizedBox(
            height: 260,
          )
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: pageCount,
                options: CarouselOptions(
                    aspectRatio: 19 / 11,
                    height: 260,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) {
                      if (mounted) {
                        setState(() {
                          currentPageIndex = index;
                        });
                      }
                    }),
                itemBuilder:
                    (BuildContext context, int indexOut, int realIndex) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount:
                        indexOut == pageCount - 1 ? lastPageSize : pageSize,
                    itemBuilder: (context, index) {
                      var ind = indexOut * pageSize + index;
                      var gift = widget.giftList[ind];
                      //AppLog.debug('CarouselSlider ind=$ind');
                      return GestureDetector(
                        onTap: () {
                          /* setState(() {
                            selectedIndex = ind;
                            widget.callBack(ind);
                          });*/

                          if (ind == selectedIndex) {
                            if (gift.vipVisible == 1 &&
                                UserInfo.to.myDetail!.isVip == 0) {
                              // 不是VIP  显示购买VIP弹窗
                              sheetToVip(
                                  path: ChargePath.recharge_send_vip_gift,
                                  index: 4);
                            } else {
                              Get.back();
                              widget.callBack(ind);
                            }
                          } else {
                            if (mounted) {
                              setState(() {
                                selectedIndex = ind;
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: selectedIndex == ind
                              ? BoxDecoration(
                                  color: const Color(0x0fffffff),
                                  borderRadius:
                                      const BorderRadiusDirectional.all(
                                          Radius.circular(10)),
                                  border: Border.all(
                                      color: const Color(0xFFF447FF), width: 1),
                                )
                              : const BoxDecoration(
                                  color: Color(0x0fffffff),
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(10)),
                                ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 46,
                                    width: 46,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: AppNetImage(
                                            gift.icon ?? '',
                                            placeholderAsset: Assets.imgAppLogo,
                                            isCircle: true,
                                          ),
                                        )),
                                  ),
                                  const Spacer(),
                                  if (selectedIndex != ind)
                                    Container(
                                      margin:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 2),
                                      child: AutoSizeText(
                                        gift.name ?? "--",
                                        maxLines: 1,
                                        maxFontSize: 12,
                                        minFontSize: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 4, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            gift.diamonds.toString(),
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontFamily:
                                                    AppConstants.fontsBold,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Image.asset(
                                            Assets.imgDiamond,
                                            matchTextDirection: true,
                                            height: 12,
                                            width: 12,
                                          ),
                                        ],
                                      )),
                                  const Spacer(),
                                  sendGift(ind),
                                ],
                              ),
                              if (gift.vipVisible == 1)
                                PositionedDirectional(
                                    top: 4,
                                    start: 4,
                                    child: Image.asset(
                                      Assets.imgIconVip,
                                      height: 16,
                                      width: 32,
                                    ))
                            ],
                          ),
                        ),
                      ).onItemLabel(index: index);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 9 / 12,
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 2),
                child: DotsIndicator(
                  dotsCount: pageCount,
                  position: currentPageIndex,
                  decorator: DotsDecorator(
                    size: const Size.square(6.0),
                    activeSize: const Size(6.0, 6.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                    activeColor: Colors.white,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          );
  }

  Widget sendGift(int ind) {
    return selectedIndex == ind
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 3),
            height: 28,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFF447FF),
                  Color(0xFFF447FF),
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4))),
            child: AutoSizeText(
              Tr.app_gift_send.tr,
              maxLines: 1,
              maxFontSize: 14,
              minFontSize: 8,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        : const SizedBox.shrink();
  }
}
