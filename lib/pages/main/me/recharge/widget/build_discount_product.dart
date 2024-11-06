import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/recharge/index.dart';

class BuildDiscountProduct extends StatelessWidget {
  final PayQuickCommodite data;

  final RechargeLogic logic;

  const BuildDiscountProduct(
      {Key? key, required this.data, required this.logic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => logic.createPay(data),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(top: 3),
            constraints: const BoxConstraints(minHeight: 72),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: const Color(0xFF721EFF),
                borderRadius: BorderRadiusDirectional.circular(16)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: Image.asset(
                    Assets.iconDiamond3,
                    width: 40,
                    height: 40,
                    matchTextDirection: true,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.value ?? "--"}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppConstants.fontsBold,
                          fontSize: 18),
                    ),
                    if (data.showBonus != 0)
                      Row(
                        children: [
                          Text(
                            '${Tr.appSend.tr}${data.showBonus}',
                            style: TextStyle(
                                color: const Color(0xFFFFE986),
                                fontFamily: AppConstants.fontsRegular,
                                fontSize: 14),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 3),
                            child: Image.asset(
                              Assets.iconDiamond,
                              width: 16,
                              height: 16,
                              matchTextDirection: true,
                            ),
                          )
                        ],
                      )
                  ],
                )),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 10),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: Text(
                    data.showPrice,
                    style: TextStyle(
                        color: const Color(0xFF9341FF),
                        fontSize: 15,
                        fontFamily: AppConstants.fontsBold,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          if (data.discount != null)
            PositionedDirectional(
                top: 0,
                start: 0,
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(15),
                        bottomEnd: Radius.circular(15),
                      ),
                      gradient: LinearGradient(colors: [
                        Color(0xFFFF1A45),
                        Color(0xFFFF17D6),
                      ])),
                  child: Text(
                    Tr.app_off.trArgs(["${data.discount}"]),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppConstants.fontsRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 11),
                  ),
                ))
        ],
      ),
    );
  }
}
