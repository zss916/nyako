import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/add_card.dart';
import 'package:oliapro/dialogs/pay_channel/build_content.dart';
import 'package:oliapro/dialogs/pay_channel/widget/build_google_pay.dart';
import 'package:oliapro/dialogs/reward_dialog/pdd_util.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/entities/app_hot_entity.dart';
import 'package:oliapro/game/game_dialog_manager.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/pages/charge/billing.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/user_info.dart';

///快捷支付(Google/三方)
toQuickPayChannel(PayQuickCommodite data,
    {String? createPath = ChargePath.android_recharge_center,
    String? upid,
    AreaData? area,
    bool isBot = false}) {
  // continueQPayChannel(data,createPath: createPath);

  if (UserInfo.to.isTransferApp) {
    ARoutes.openTransferAppDialog();
  } else {
    if (data.ppp!.length == 1) {
      ///直接购买
      Billing.createQPay(data.ppp!.first, upid: upid);
    } else {
      ///不同渠道购买
      continueQPayChannel(data,
          createPath: createPath, upid: upid, isBot: isBot, area: area);
    }
  }
}

///VIP快捷支付(Google/三方)
toQuickVIPPayChannel(
  PayQuickCommodite data, {
  String? createPath = ChargePath.android_recharge_center,
  String? upid,
  bool isBot = false,
  AreaData? area,
}) {
  if (UserInfo.to.isTransferApp) {
    ARoutes.openTransferAppDialog();
  } else {
    if (data.ppp!.length == 1) {
      ///直接购买
      Billing.createQPay(data.ppp!.first, upid: upid);
    } else {
      ///不同渠道购买
      toQVipPayChannel(data,
          createPath: createPath, upid: upid, isBot: isBot, area: area);
    }
  }
}

///VIP频道支付
toQVipPayChannel(
  PayQuickCommodite commodite, {
  String? createPath,
  String? upid,
  bool isBot = false,
  AreaData? area,
}) async {
  continueQPayChannel(
    commodite,
    createPath: createPath,
    isVip: true,
    isBot: isBot,
    area: area,
  );
}

///快捷频道支付(优惠三方支付)
continueQPayChannel(PayQuickCommodite commodite,
    {String? createPath = ChargePath.android_recharge_center,
    bool isVip = false,
    String? upid,
    AreaData? area,
    bool isBot = false}) async {
  if (isBot) {
    GameDialogManager.continuePayChannel(commodite,
        path: createPath, isVip: isVip, upid: upid);
  } else {
    Get.bottomSheet(
        PayChannel(
          commodite,
          createPath ?? ChargePath.android_recharge_center,
          isVip,
          upid: upid,
          area: area ?? commodite.area,
        ),
        isScrollControlled: true,
        enableDrag: false,
        settings: const RouteSettings(name: AppPages.rechargeChannelSheet));
  }
}

class PayChannel extends StatefulWidget {
  late PayQuickCommodite commodite;
  final String createPath;
  final bool isVip;
  final String? upid;

  final AreaData? area;
  PayChannel(this.commodite, this.createPath, this.isVip,
      {super.key, this.upid, this.area});

  @override
  State<PayChannel> createState() => _PayChannelState();
}

class _PayChannelState extends State<PayChannel> {
  late List<AreaData> data = [];

  String? path;
  String? title = "all";
  int? countryCode;
  bool isDown = true;

  @override
  void initState() {
    super.initState();
    _loadSelectArea();
    AppConstants.isChannelPay = true;
    PddUtil.instance.channelPayOpen();
    if (mounted) {
      setState(() {
        path = widget.area?.path ?? '';
        title = widget.area?.title ?? '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    AppConstants.isChannelPay = false;
    PddUtil.instance.channelPayClose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: const Color(0xFFF4F5F6),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [Color(0xFFFFE4AF), Color(0xFFF4F5F6)])),
                width: Get.width,
                height: 150,
              )),
          Column(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 48, bottom: 0),
                width: double.maxFinite,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(10),
                        margin: const EdgeInsetsDirectional.only(start: 2),
                        child: Image.asset(
                          Assets.iconBack,
                          width: 24,
                          height: 24,
                          matchTextDirection: true,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.only(end: 15, start: 5),
                      child: GestureDetector(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              isDown = !isDown;
                              List<AreaData> arr = [];
                              List<AreaData> data1 = data
                                  .where((e) => e.isSelect == true)
                                  .toList();
                              List<AreaData> data2 = data
                                  .where((e) => e.isSelect != true)
                                  .toList();
                              arr.addAll(data1);
                              arr.addAll(data2);
                              data.clear();
                              data.addAll(arr);
                            });
                          }
                        },
                        child: _selectArea(path, title),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 60,
                // color: Colors.green,
                child: isDown
                    ? const SizedBox.shrink()
                    : ListView.separated(
                        padding: const EdgeInsetsDirectional.only(
                            start: 12, end: 12, top: 15, bottom: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                          onTap: () {
                            setState(() {
                              for (var element in data) {
                                element.isSelect = false;
                              }
                              AreaData item = data[index]..isSelect = true;
                              path = item.path;
                              title = item.title;
                              countryCode = item.countryCode;
                              isDown = true;
                            });

                            _loadCountryProduct(
                                widget.commodite.productId ?? "",
                                (data[index].countryCode ?? -1), (data) {
                              setState(() {
                                widget.commodite = data;
                              });
                            });
                          },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 12),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                color: data[index].isSelect == true
                                    ? const Color(0xFF625969)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadiusDirectional.circular(8)),
                            child: Text(
                              data[index].title ?? "--",
                              style: TextStyle(
                                  color: data[index].isSelect == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const VerticalDivider(
                          width: 10,
                          color: Colors.transparent,
                        ),
                      ),
              ),
              Text(
                Tr.appPayOrder.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              topTitle(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (((widget.isVip &&
                            (widget.commodite.value ?? 0) != 0)) ||
                        (!widget.isVip && (widget.commodite.bonus ?? 0) != 0))
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsetsDirectional.all(12),
                        margin: const EdgeInsetsDirectional.only(
                            start: 15, end: 15),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFE986),
                            borderRadius: BorderRadiusDirectional.circular(12)),
                        child: Row(
                          children: [
                            Text(
                              Tr.appExtraSend.tr,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 5),
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 5, vertical: 3),
                              child: UnconstrainedBox(
                                child: Row(
                                  children: [
                                    if (widget.isVip &&
                                        (widget.commodite.value ?? 0) != 0)
                                      Text.rich(TextSpan(
                                          style: TextStyle(
                                              color: const Color(0xFF9341FF),
                                              fontSize: 15,
                                              fontFamily:
                                                  AppConstants.fontsRegular,
                                              fontWeight: FontWeight.normal),
                                          children: [
                                            TextSpan(
                                                text: Tr.appSend.tr,
                                                style: const TextStyle(
                                                  color: Color(0xFF9341FF),
                                                )),
                                            TextSpan(
                                              text:
                                                  "${widget.commodite.value} ",
                                              style: const TextStyle(
                                                color: Color(0xFF9341FF),
                                              ),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Image.asset(
                                                  Assets.iconDiamond,
                                                  matchTextDirection: true,
                                                  width: 14,
                                                  height: 14,
                                                )),
                                          ])),
                                    if (!widget.isVip &&
                                        (widget.commodite.bonus ?? 0) != 0)
                                      Text.rich(TextSpan(
                                          style: TextStyle(
                                              color: const Color(0xFF9341FF),
                                              fontSize: 15,
                                              fontFamily:
                                                  AppConstants.fontsRegular,
                                              fontWeight: FontWeight.normal),
                                          children: [
                                            TextSpan(
                                                text: Tr.appSend.tr,
                                                style: const TextStyle(
                                                  color: Color(0xFF9341FF),
                                                )),
                                            TextSpan(
                                              text:
                                                  "${widget.commodite.bonus} ",
                                              style: const TextStyle(
                                                color: Color(0xFF9341FF),
                                              ),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Image.asset(
                                                  Assets.iconDiamond,
                                                  matchTextDirection: true,
                                                  width: 14,
                                                  height: 14,
                                                )),
                                          ])),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.commodite.diamondCard != null)
                      BuildAddCard(widget.commodite.diamondCard),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 16, end: 16, top: 16, bottom: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(16),
                          color: Colors.white),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          if (UserInfo.to.isTransferApp)
                            BuildGooglePay(
                              price: widget.commodite.showPrice,
                            ),
                          BuildContent(
                            widget.commodite.ppp ?? [],
                            countryCode: countryCode,
                            createPath: widget.createPath,
                            upid: widget.upid,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget topTitle() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: 15, end: 15, top: 0, bottom: 15),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.isVip == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(end: 3),
                      child: Image.asset(
                        Assets.iconKingBig,
                        width: 42,
                        height: 42,
                        matchTextDirection: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      Tr.app_str_day
                          .trArgs([(widget.commodite.vipDays ?? 0).toString()]),
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: Image.asset(
                        widget.commodite.diamondIcon ?? Assets.imgBigDiamond,
                        width: 42,
                        height: 42,
                        matchTextDirection: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "${widget.commodite.value ?? "--"}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                )
        ],
      ),
    );
  }

  ///选中地区
  Widget _selectArea(String? path, String? title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: const Color(0xFFAC6712)),
      padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 3),
            child: Text(
              title ?? "--",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          isDown
              ? const Icon(Icons.arrow_drop_down_rounded,
                  size: 30, color: Colors.white)
              : const Icon(Icons.arrow_drop_up_rounded,
                  size: 30, color: Colors.white),
        ],
      ),
    );
  }

  ///点击选地区
  void _loadSelectArea() {
    data.clear();
    Http.instance
        .post<List<AreaData>>(NetPath.getPayCountry2, errCallback: (err) {})
        .then((value) {
      setState(() {
        //value.where((e) => e.showCanChoose)
        List<AreaData> map =
            value.map((e) => e..isSelect = (e.title == title)).toList();
        data.addAll(map);
      });
    });
  }

  ///获取商品列表
  void _loadCountryProduct(
      String productId, int countryCode, Function(PayQuickCommodite) func) {
    Http.instance
        .post<PayQuickCommodite>(
      '${NetPath.getCountryProduct2}/$productId/$countryCode',
      showLoading: true,
      errCallback: (err) {},
    )
        .then((value) {
      func.call(value);
    });
  }
}
