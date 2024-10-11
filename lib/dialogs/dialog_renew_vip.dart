import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_channel/sheet_pay_channel.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/utils/point/point_utils.dart';

class RenewVipDialog extends StatelessWidget {
  static show() {
    /*if (UserInfo.to.isRenewVip) {
      Http.instance
          .post<PayQuickData>('${NetPath.getCompositeProduct2}6',
              showLoading: false)
          .then((value) {
        if (value.discountVip != null) {
          Get.dialog(RenewVipDialog(data: (value.discountVip!)));
        }
      });
    }*/
  }

  final PayQuickCommodite data;

  const RenewVipDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 390,
          padding: const EdgeInsetsDirectional.only(bottom: 15),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  matchTextDirection: true,
                  fit: BoxFit.fill,
                  image: ExactAssetImage(
                    Assets.imgAppLogo,
                  ))),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 110),
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16, vertical: 7),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            matchTextDirection: true,
                            image: ExactAssetImage(Assets.imgAppLogo))),
                    child: Column(
                      children: [
                        AutoSizeText(
                          Tr.app_str_day
                              .trArgs([(data.vipDays ?? 0).toString()]),
                          maxFontSize: 20,
                          minFontSize: 10,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color(0xFFBB06FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        if (data.showValue != 0)
                          Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "+${data.showValue}",
                                  style: const TextStyle(
                                      color: Color(0xFFBB06FF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: 3),
                                  child: Image.asset(
                                    Assets.imgDiamond,
                                    width: 14,
                                    height: 14,
                                    matchTextDirection: true,
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    data.showOldPrice,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white54),
                  ),
                  const Spacer(),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    child: AutoSizeText(
                      data.showPrice,
                      maxLines: 1,
                      maxFontSize: 48,
                      minFontSize: 20,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 48),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      PointUtils.instance.toRenewPointA();
                      toQuickVIPPayChannel(data,
                          createPath: ChargePath.recharge_vip_discount);
                    },
                    child: Container(
                      margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 50, vertical: 12),
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
                      child: Text(
                        Tr.app_renew.tr,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF51350F),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    child: AutoSizeText(
                      Tr.appExclusiveDiscount.tr,
                      maxFontSize: 12,
                      minFontSize: 6,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  )
                ],
              ),
              PositionedDirectional(
                  top: 60,
                  end: 15,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      Assets.imgCloseDialog,
                      width: 25,
                      height: 25,
                    ),
                  )),
              if (data.showDiscount != 0)
                PositionedDirectional(
                    top: 10,
                    start: 0,
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsetsDirectional.only(
                          top: 12, start: 2, end: 2, bottom: 2),
                      alignment: AlignmentDirectional.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              matchTextDirection: true,
                              image: ExactAssetImage(Assets.imgAppLogo))),
                      child: AutoSizeText(
                        Get.locale?.languageCode == "tr"
                            ? "%${data.showDiscount}\nİndirim"
                            : "${data.showDiscount}%\nOFF",
                        maxFontSize: 18,
                        minFontSize: 8,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ))
            ],
          ),
        )
      ],
    );
  }
}
