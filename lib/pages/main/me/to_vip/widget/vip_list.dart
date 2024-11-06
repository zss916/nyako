import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:nyako/entities/app_charge_quick_entity.dart';
import 'package:nyako/entities/app_hot_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/match/util/bgm_control.dart';
import 'package:nyako/utils/point/point_utils.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.discountVip != null)
          toRenew(widget.discountVip ?? PayQuickCommodite()),
        Container(
          alignment: AlignmentDirectional.center,
          width: Get.width,
          // color: Colors.green,
          margin: const EdgeInsetsDirectional.only(
              start: 15, end: 15, top: 0, bottom: 30),
          child: widget.data.isNotEmpty
              ? buildContent()
              : Container(
                  alignment: AlignmentDirectional.center,
                  width: double.maxFinite,
                  height: 204,
                  child: buildProgress(),
                ),
        )
      ],
    );
  }

  Widget buildProgress() => const CircularProgressIndicator(
        color: Color(0xFF7934F0),
      );

  Widget buildContent() => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.data.length,
        padding: EdgeInsetsDirectional.zero,
        itemBuilder: (context, index) =>
            vipItem(index, widget.data[index], widget.data, widget.area),
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.transparent,
          height: 12,
        ),
      );

  Widget vipItem(int index, PayQuickCommodite item,
      List<PayQuickCommodite> data, AreaData? area) {
    return Container(
      width: double.maxFinite,
      height: 60,
      padding: const EdgeInsetsDirectional.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: const Color(0xFFF5F4F6)),
          borderRadius: BorderRadiusDirectional.circular(12)),
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF5F4F6),
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: Row(
          children: [
            Text(
              (item.vipDays ?? 0).toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              " ${Tr.appDays.tr}",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            if (item.showValue != 0)
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xFF822CFE),
                      Color(0xFFD500FE),
                    ]),
                    borderRadius: BorderRadiusDirectional.circular(7)),
                child: Row(
                  children: [
                    Text(
                      "${Tr.appSend.tr}${item.showValue}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstants.fontsRegular,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 2),
                      child: Image.asset(
                        Assets.iconDiamond,
                        width: 14,
                        height: 14,
                      ),
                    )
                  ],
                ),
              ),
            const Spacer(),
            InkWell(
              onTap: () {
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
              },
              child: Container(
                height: 32,
                constraints: const BoxConstraints(minWidth: 90),
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 5, horizontal: 12),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x4DFF33A7),
                          offset: Offset(2, 2),
                          blurRadius: 18,
                          spreadRadius: 4)
                    ],
                    gradient: const LinearGradient(
                        colors: [Color(0xFFFF741A), Color(0xFFFF17D6)]),
                    borderRadius: BorderRadiusDirectional.circular(30)),
                margin: const EdgeInsetsDirectional.only(
                    start: 5, end: 5, top: 4, bottom: 6),
                child: AutoSizeText(
                  item.showPrice,
                  softWrap: true,
                  maxFontSize: 14,
                  minFontSize: 7,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  select(int index, List<PayQuickCommodite> data) {
    for (int i = 0; i < data.length; i++) {
      data[i].isSelect = (i == index);
    }
  }

  ///续费
  Widget toRenew(PayQuickCommodite data) {
    return Container(
      width: Get.width,
      height: 90,
      padding: const EdgeInsetsDirectional.all(1),
      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: const GradientBoxBorder(
              width: 2,
              gradient: LinearGradient(colors: [
                Color(0xFFFF1A45),
                Color(0xFFFF17D6),
              ])),
          borderRadius: BorderRadiusDirectional.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.maxFinite,
            margin:
                const EdgeInsetsDirectional.only(start: 11, end: 11, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        Tr.app_str_day.trArgs([(data.vipDays ?? 0).toString()]),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                      if (data.showValue != 0)
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5),
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color(0xFF822CFE),
                                Color(0xFFD500FE),
                              ]),
                              borderRadius:
                                  BorderRadiusDirectional.circular(7)),
                          child: Row(
                            children: [
                              Text(
                                "+${data.showValue}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppConstants.fontsRegular,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(start: 2),
                                child: Image.asset(
                                  Assets.iconDiamond,
                                  width: 14,
                                  height: 14,
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    PointUtils.instance.toRenewPointB();
                    toQuickVIPPayChannel(data, createPath: widget.path ?? "");
                  },
                  child: Container(
                    height: 32,
                    constraints: const BoxConstraints(minWidth: 90),
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x4DFF33A7),
                              offset: Offset(2, 2),
                              blurRadius: 18,
                              spreadRadius: 4)
                        ],
                        gradient: const LinearGradient(
                            colors: [Color(0xFFFF741A), Color(0xFFFF17D6)]),
                        borderRadius: BorderRadiusDirectional.circular(30)),
                    margin: const EdgeInsetsDirectional.only(
                        start: 5, end: 5, top: 4, bottom: 6),
                    child: AutoSizeText(
                      data.showPrice,
                      softWrap: true,
                      maxFontSize: 14,
                      minFontSize: 7,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 30,
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            alignment: AlignmentDirectional.centerStart,
            decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(14),
                    bottomEnd: Radius.circular(14)),
                gradient: LinearGradient(
                    colors: [Color(0xFFFF1A45), Color(0xFFFF6E17)])),
            child: Text(
              Tr.app_off.trArgs([(data.discount ?? 0).toString()]),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppConstants.fontsBold,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  @Deprecated("old")
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
}
