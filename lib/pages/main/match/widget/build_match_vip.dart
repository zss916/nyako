import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/pay_vip/sheet_pay_vip.dart';
import 'package:oliapro/pages/main/match/index.dart';

class BuildMatchVip extends StatelessWidget {
  const BuildMatchVip({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchLogic>(
        id: "count",
        init: MatchLogic(),
        builder: (logic) {
          return Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                    bottom: 12.h, start: 10, end: 10),
                child: AutoSizeText(
                  logic.isUserVip ? Tr.app_get_vip.tr : Tr.appMatchTip2.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xFFC3A0FF),
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
              ),
              logic.isUserVip
                  ? SizedBox(
                      height: 25.h,
                    )
                  : GestureDetector(
                      onTap: () {
                        sheetToVip(
                            path: ChargePath.recharge_vip_dialog_match,
                            index: 0);
                      },
                      child: Container(
                        //color: Colors.blue,
                        padding: EdgeInsetsDirectional.only(
                            top: 8.h, start: 15.w, end: 15.w, bottom: 5.h),
                        child: Text(
                          Tr.app_to_vip.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFFFFE766),
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFFFE766),
                              fontSize: 12),
                        ),
                      ),
                    )
            ],
          );
        });
  }
}
