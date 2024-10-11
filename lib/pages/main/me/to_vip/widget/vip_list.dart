import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/match/util/bgm_control.dart';
import 'package:oliapro/utils/point/point_utils.dart';

class VipList extends StatefulWidget {
  PayQuickCommodite? discountVip;
  final List<PayQuickCommodite> data;
  final int? selectIndex;
  final String? path;

  final AreaData? area;

  VipList(
      {super.key,
      this.discountVip,
      required this.data,
      required this.path,
      this.selectIndex,
      required this.area});

  @override
  State<VipList> createState() => _VipListState();
}

class _VipListState extends State<VipList> {
  @override
  void initState() {
    super.initState();
    AppConstants.isVIPPay = true;
    BgmControl.setMatchVolume(false);
  }

  @override
  void dispose() {
    super.dispose();
    AppConstants.isVIPPay = false;
    BgmControl.setMatchVolume(true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*if (widget.discountVip != null)
          toRenew(widget.discountVip ?? PayQuickCommodite()),*/
        Container(
          alignment: AlignmentDirectional.center,
          width: Get.width,
          height: 150,
          color: Colors.transparent,
          margin: const EdgeInsetsDirectional.only(
              start: 7, end: 7, top: 10, bottom: 10),
          child: widget.data.isNotEmpty ? buildContent() : buildProgress(),
        )
      ],
    );
  }

  Widget buildProgress() => const CircularProgressIndicator(
        color: Color(0xFF7934F0),
      );

  Widget buildContent() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length,
        itemBuilder: (context, index) =>
            vipItem(index, widget.data[index], widget.data, widget.area),
      );

  Widget vipItem(int index, PayQuickCommodite item,
      List<PayQuickCommodite> data, AreaData? area) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 7),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            if (mounted) {
              setState(() {
                select(index, data);
                // PayQuickCommodite item = data.firstWhere((e) => (e.isSelect == true));
                List<PayQuickCommodite> list =
                    data.where((e) => (e.isSelect == true)).toList();
                if (list.isNotEmpty) {
                  toQuickVIPPayChannel(list.first,
                      createPath: widget.path ?? "", area: area);
                }
              });
            }
          },
          child: Stack(
            children: [
              Container(
                width: (Get.width - (55)) / 3,
                height: 150,
                alignment: AlignmentDirectional.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadiusDirectional.circular(14),
                    border:
                        Border.all(color: const Color(0xFFF447FF), width: 1)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: const EdgeInsetsDirectional.all(3),
                      padding: const EdgeInsetsDirectional.all(5),
                      child: Column(
                        children: [
                          const Spacer(),
                          Image.asset(
                            Assets.benefitKing,
                            matchTextDirection: true,
                            width: 40,
                            height: 40,
                          ),
                          AutoSizeText(
                            Tr.app_str_day
                                .trArgs([(item.vipDays ?? 0).toString()]),
                            textAlign: TextAlign.center,
                            maxFontSize: 16,
                            minFontSize: 8,
                            softWrap: true,
                            maxLines: Get.locale?.languageCode == "ar" ? 1 : 2,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )),
                    Container(
                      width: double.maxFinite,
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 8, horizontal: 3),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFFAC53FB),
                            Color(0xFF7934F0),
                          ]),
                          borderRadius: BorderRadiusDirectional.circular(25)),
                      margin: const EdgeInsetsDirectional.only(
                          start: 5, end: 5, top: 0, bottom: 6),
                      child: AutoSizeText(
                        item.showPrice,
                        softWrap: true,
                        maxFontSize: 14,
                        minFontSize: 7,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              if (item.showValue != 0)
                PositionedDirectional(
                    top: 0,
                    start: 0,
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFFFF40A3),
                            Color(0xFFFF8D1E),
                          ]),
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(14),
                              topEnd: Radius.circular(14),
                              bottomStart: Radius.zero,
                              bottomEnd: Radius.circular(14))),
                      child: Row(
                        children: [
                          Text(
                            "${Tr.appSend.tr}${item.showValue}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 1),
                            child: Image.asset(
                              Assets.imgDiamond,
                              matchTextDirection: true,
                              height: 13,
                              width: 13,
                            ),
                          )
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  select(int index, List<PayQuickCommodite> data) {
    for (int i = 0; i < data.length; i++) {
      data[i].isSelect = (i == index);
    }
  }

  Widget btn(String path, List<PayQuickCommodite> data) {
    return GestureDetector(
      onTap: () {
        PayQuickCommodite item = data.firstWhere((e) => (e.isSelect == true));
        toQVipPayChannel(item, createPath: path);
      },
      child: Container(
        height: 56,
        margin: const EdgeInsets.only(top: 5, left: 14, right: 14, bottom: 15),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Text(
          Tr.app_quick_buy.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  ///续费
  Widget toRenew(PayQuickCommodite data) {
    return Container(
      width: Get.width,
      height: 90,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 15),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xFF661FF7),
            Color(0xFFCB67FD),
            Color(0xFFF161E1),
            Color(0xFFFEB05E),
          ]),
          borderRadius: BorderRadiusDirectional.circular(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    Tr.app_str_day.trArgs([(data.vipDays ?? 0).toString()]),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  if (data.showValue != 0)
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                          color: const Color(0x33000000),
                          borderRadius: BorderRadiusDirectional.circular(6)),
                      child: Row(
                        children: [
                          Text(
                            "+${data.showValue}",
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 2),
                            child: Image.asset(
                              Assets.imgDiamond,
                              width: 14,
                              height: 14,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 5),
                child: Text(
                  Tr.appExclusiveDiscount.tr,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
          InkWell(
            onTap: () {
              PointUtils.instance.toRenewPointB();
              toQuickVIPPayChannel(data, createPath: widget.path ?? "");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.showOldPrice,
                  style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14),
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 72),
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 5, horizontal: 12),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          colors: [
                            Color(0xFFFDFBF1),
                            Color(0xFFFEEBC3),
                            Color(0xFFFED78A),
                          ]),
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  margin: const EdgeInsetsDirectional.only(
                      start: 5, end: 5, top: 4, bottom: 6),
                  child: AutoSizeText(
                    data.showPrice,
                    softWrap: true,
                    maxFontSize: 14,
                    minFontSize: 7,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color(0xFF51350F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
