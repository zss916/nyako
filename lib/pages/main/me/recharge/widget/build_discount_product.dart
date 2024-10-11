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
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFFFF2753),
                  Color(0xFFFFC84E),
                ]),
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: Image.asset(
                    Assets.imgDiamond,
                    width: 48,
                    height: 48,
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
                                color: const Color(0xFFFFF890),
                                fontFamily: AppConstants.fontsRegular,
                                fontSize: 14),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 3),
                            child: Image.asset(
                              Assets.imgDiamond,
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
                      horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: Text(
                    data.showPrice,
                    style: TextStyle(
                        color: const Color(0xFF61300B),
                        fontSize: 14,
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
                        bottomEnd: Radius.circular(15),
                      ),
                      gradient: LinearGradient(colors: [
                        Color(0xFFB5FFFC),
                        Color(0xFFFFF66E),
                      ])),
                  child: Text(
                    Tr.app_off.trArgs(["${data.discount}"]),
                    style: TextStyle(
                        color: const Color(0xFF620F0F),
                        fontFamily: AppConstants.fontsRegular,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ))
        ],
      ),
    );
  }
}
