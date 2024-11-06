import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_order_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/main/me/orderlist/order_detail/logic.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/route_name.dart';
import 'package:nyako/utils/app_format_util.dart';
import 'package:nyako/widget/base_app_bar.dart';

@RouteName(AppPages.orderDetail)
class OrderDetailPage extends GetView<OrderDetailLogic> {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderData data = Get.arguments[0];
    return Scaffold(
        appBar: BaseAppBar(
          title: Tr.app_order_one_details.tr,
        ),
        backgroundColor: const Color(0xFFF4F5F6),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.only(
              top: 20, start: 20, end: 20, bottom: 20),
          child: Column(
            children: [
              buildHeader(data.showTitleStr, data.showTxtColor, data),
              buildContent(data),
              buildService(),
            ],
          ),
        ));
  }

  Container buildHeader(String titleStr, Color txtColor, OrderData data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      constraints: const BoxConstraints(minHeight: 145),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            (data.vipDays == null) ? Assets.iconDiamond : Assets.iconKingBig,
            width: 48,
            height: 48,
            matchTextDirection: true,
          ),
          Container(
            child: (data.vipDays == null)
                ? Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${controller.data.diamonds ?? 0}',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppConstants.fontsBold,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.maxFinite,
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10),
                        // color: Colors.red,
                        child: Text(
                          titleStr,
                          style: TextStyle(
                              color: txtColor,
                              fontFamily: AppConstants.fontsRegular,
                              fontSize: 12),
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsetsDirectional.all(15),
                        child: Text(
                          Tr.app_str_day.trArgs(["${data.vipDays ?? 0}"]),
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: AppConstants.fontsBold,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                      ),
                      if (data.showDiamond != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "+${data.showDiamond}",
                              style: TextStyle(
                                  fontFamily: AppConstants.fontsRegular,
                                  color: const Color(0xFF9341FF),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13),
                            ),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 2),
                              child: Image.asset(
                                Assets.iconDiamond,
                                matchTextDirection: true,
                                width: 14,
                                height: 14,
                              ),
                            )
                          ],
                        )
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget buildContent(OrderData data) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Tr.app_order_price.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${AppFormatUtil.currencyToSymbol(data.currencyCode)} ${data.currencyFee != null ? data.currencyFee! / 100.0 : '--'}",
                style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Tr.app_order_product_info.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.fontsBold,
                    fontSize: 14),
              ),
              Text(
                "${data.diamonds}${Tr.app_diamond.tr}",
                style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: AppConstants.fontsRegular,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Tr.app_order_createAt.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                data.createdAtTime,
                style: TextStyle(
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.fontsRegular,
                    fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 180),
                child: Text(
                  Tr.app_order_channelName.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: AlignmentDirectional.centerEnd,
                margin: const EdgeInsetsDirectional.only(start: 20),
                child: Text(
                  (data.channelName ?? "--"),
                  style: TextStyle(
                      color: const Color(0xFF999999),
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConstants.fontsRegular,
                      fontSize: 14),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () => controller.copyId(),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Tr.app_order_tradeNo.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: AppConstants.fontsBold,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(
                        data.tradeNo ?? '--',
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: TextStyle(
                            color: const Color(0xFF999999),
                            fontFamily: AppConstants.fontsRegular,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      )),
                      const SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        Assets.iconCodeCopy,
                        width: 14,
                        height: 14,
                        matchTextDirection: true,
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Tr.app_order_orderNo.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                data.orderNo ?? '--',
                style: TextStyle(
                    color: const Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.fontsRegular,
                    fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildService() {
    return GestureDetector(
      onTap: () => controller.contactCs(),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.iconCustomer,
              matchTextDirection: true,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: AutoSizeText(
                Tr.app_order_customer_service.tr,
                maxLines: 2,
                maxFontSize: 14,
                minFontSize: 10,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Image.asset(
              matchTextDirection: true,
              Assets.iconNextB,
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
