import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_card_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/widget/app_net_image.dart';

class PropGiftListWidget extends StatefulWidget {
  final List<CardBean> giftList;
  final Function(int index) callBack;

  const PropGiftListWidget(
      {super.key, required this.giftList, required this.callBack});

  @override
  State<PropGiftListWidget> createState() => _PropGiftListWidgetState();
}

class _PropGiftListWidgetState extends State<PropGiftListWidget> {
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
            height: 285,
          )
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: pageCount,
                options: CarouselOptions(
                    aspectRatio: 19 / 11,
                    height: 285,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    }),
                itemBuilder:
                    (BuildContext context, int indexOut, int realIndex) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount:
                        indexOut == pageCount - 1 ? lastPageSize : pageSize,
                    itemBuilder: (context, index) {
                      var ind = indexOut * pageSize + index;
                      var gift = widget.giftList![ind];
                      //AppLog.debug('CarouselSlider ind=$ind');
                      return GestureDetector(
                        onTap: () {
                          if (ind == selectedIndex) {
                            Get.back();
                            widget.callBack(ind);
                          } else {
                            setState(() {
                              selectedIndex = ind;
                            });
                          }
                        },
                        child: Container(
                          decoration: selectedIndex == ind
                              ? const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(10)),
                                  border: GradientBoxBorder(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color(0xFF8A29F8),
                                            Color(0xFFFC0193),
                                          ]),
                                      width: 1),
                                )
                              : const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.all(
                                      Radius.circular(10)),
                                ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: selectedIndex == ind
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    // padding: const EdgeInsets.all(3),
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
                                            placeholderAsset:
                                                Assets.iconSmallLogo,
                                            isCircle: true,
                                          ),
                                        )),
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
                                            gift.num,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF642A4B),
                                                fontSize: 14),
                                          ),
                                        ],
                                      )),
                                  const Spacer(),
                                  sendGift(ind),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 80 / 110,
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 20),
                child: DotsIndicator(
                  dotsCount: pageCount,
                  position: currentPageIndex,
                  decorator: DotsDecorator(
                    size: const Size.square(4.0),
                    activeSize: const Size(8.0, 4.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    activeColor: const Color(0xFF9341FF),
                    color: const Color(0x999341FF),
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
                  Color(0xFF8A29F8),
                  Color(0xFFFC0193),
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
                  fontWeight: FontWeight.w500),
            ),
          )
        : const SizedBox.shrink();
  }
}
