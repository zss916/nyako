import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/add_card.dart';
import 'package:oliapro/dialogs/pay_channel/build_content.dart';
import 'package:oliapro/dialogs/pay_channel/widget/build_google_pay.dart';
import 'package:oliapro/dialogs/pay_select_area/sheet_select_area.dart';
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
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/widget/base_app_bar.dart';

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
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsetsDirectional.only(top: 23),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              Color(0xFF381853),
              Color(0xFF491E61),
            ]),
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(0), topEnd: Radius.circular(0)),
      ),
      width: Get.width,
      height: Get.height,
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1226),
        appBar: BaseAppBar(
          title: Tr.appPayOrder.tr,
          actions: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 15, start: 5),
              child: GestureDetector(
                onTap: () {
                  showSelectAreaSheet(data, (item) {
                    if (item != null) {
                      _loadCountryProduct(widget.commodite.productId ?? "",
                          (item.countryCode ?? -1), (data) {
                        if (mounted) {
                          setState(() {
                            widget.commodite = data;
                            path = item.path;
                            title = item.title;
                            countryCode = item.countryCode;
                          });
                        }
                      });
                    } else {
                      if (mounted) {
                        setState(() {
                          isDown = !isDown;
                        });
                      }
                    }
                  });
                  if (mounted) {
                    setState(() {
                      isDown = !isDown;
                    });
                  }
                },
                child: _selectArea(path, title),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              topTitle(),
              if (((widget.isVip && (widget.commodite.value ?? 0) != 0)) ||
                  (!widget.isVip && (widget.commodite.bonus ?? 0) != 0))
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsetsDirectional.all(12),
                  margin: const EdgeInsetsDirectional.only(start: 15, end: 15),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadiusDirectional.circular(12)),
                  child: Row(
                    children: [
                      Text(
                        Tr.appExtraSend.tr,
                        style: const TextStyle(
                            color: Color(0xFFC3A0FF),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 5),
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFFF40A3),
                              Color(0xFFFF8D1E),
                            ])),
                        child: UnconstrainedBox(
                          child: Row(
                            children: [
                              if (widget.isVip &&
                                  (widget.commodite.value ?? 0) != 0)
                                Text.rich(TextSpan(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: AppConstants.fontsRegular,
                                        fontWeight: FontWeight.normal),
                                    children: [
                                      TextSpan(text: Tr.appSend.tr),
                                      TextSpan(
                                        text: "${widget.commodite.value} ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Image.asset(
                                            Assets.imgDiamond,
                                            matchTextDirection: true,
                                            width: 14,
                                            height: 14,
                                          )),
                                    ])),
                              if (!widget.isVip &&
                                  (widget.commodite.bonus ?? 0) != 0)
                                Text.rich(TextSpan(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: AppConstants.fontsRegular,
                                        fontWeight: FontWeight.normal),
                                    children: [
                                      TextSpan(text: Tr.appSend.tr),
                                      TextSpan(
                                        text: "${widget.commodite.bonus} ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Image.asset(
                                            Assets.imgDiamond,
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
              BuildAddCard(widget.commodite.diamondCard),
              Container(
                margin: const EdgeInsetsDirectional.only(
                    start: 20, end: 10, top: 30),
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  Tr.app_order_channelName.tr,
                  style:
                      const TextStyle(color: Color(0xFFC3A0FF), fontSize: 14),
                ),
              ),
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
      ),
    );
  }

  Widget topTitle() {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          start: 15, end: 15, top: 15, bottom: 15),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.isVip == true
              ? Column(
                  children: [
                    Image.asset(
                      Assets.imgKing,
                      width: 90,
                      height: 90,
                      matchTextDirection: true,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      Tr.app_str_day
                          .trArgs([(widget.commodite.vipDays ?? 0).toString()]),
                      style: TextStyle(
                          color: Colors.white,
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
                        width: 50,
                        height: 50,
                        matchTextDirection: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "${widget.commodite.value ?? "--"}",
                      style: TextStyle(
                          color: Colors.white,
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
          color: const Color(0x26FFFFFF)),
      padding: const EdgeInsetsDirectional.only(start: 3, end: 3),
      child: Row(
        children: [
          path == null
              ? Image.asset(
                  Assets.imgLocationIcon,
                  matchTextDirection: true,
                  // color: Colors.black,
                  width: 20,
                  height: 20,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: cachedImage(path, width: 18, height: 18),
                ),
          isDown
              ? const Icon(Icons.arrow_drop_down_rounded,
                  size: 30, color: Color(0xB3FFFFFF))
              : const Icon(Icons.arrow_drop_up_rounded,
                  size: 30, color: Color(0xB3FFFFFF)),
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
      data.addAll(value);
    });
  }

  ///获取商品列表
  void _loadCountryProduct(
      String productId, int countryCode, Function(PayQuickCommodite) func) {
    Http.instance
        .post<PayQuickCommodite>(
      '${NetPath.getCountryProduct2}/$productId/$countryCode',
      errCallback: (err) {},
    )
        .then((value) {
      func.call(value);
    });
  }
}
