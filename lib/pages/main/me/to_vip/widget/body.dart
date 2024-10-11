import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/charge_path.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/me/to_vip/index.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/benefit_list.dart';
import 'package:oliapro/pages/main/me/to_vip/widget/vip_list.dart';
import 'package:oliapro/services/user_info.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/app_some_extension.dart';

class ToVipBody extends StatelessWidget {
  ToVipBody({super.key});

  final String vipBenefits = Tr.app_to_update_vip.tr;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [buildInfo(), buildVip(), BenefitList()],
      ),
    );
  }

  Widget buildInfo() {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 114,
          margin: const EdgeInsetsDirectional.only(
              start: 15, end: 15, bottom: 10, top: 30),
          padding: const EdgeInsetsDirectional.only(
              start: 10, top: 10, bottom: 10, end: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  matchTextDirection: true,
                  image: ExactAssetImage(UserInfo.to.isUserVip
                      ? Assets.benefitReceiveVipBg
                      : Assets.benefitToVipBg))),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsetsDirectional.only(end: 10),
                    padding: const EdgeInsetsDirectional.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(50),
                      child: cachedImage(UserInfo.to.userPortrait,
                          width: 44, height: 44),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        UserInfo.to.nickName,
                        maxLines: 1,
                        maxFontSize: 18,
                        minFontSize: 6,
                        style: TextStyle(
                            color: UserInfo.to.isUserVip
                                ? const Color(0xFF745641)
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        margin:
                            const EdgeInsetsDirectional.only(start: 0, top: 4),
                        width: double.maxFinite,
                        child: Text(
                          "ID:${UserInfo.to.username}",
                          maxLines: 1,
                          style: TextStyle(
                              color: UserInfo.to.isUserVip
                                  ? const Color(0xFF745641)
                                  : Colors.white60,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 90,
                  )
                ],
              ),
              const Spacer(),
              Container(
                alignment: AlignmentDirectional.centerStart,
                margin: const EdgeInsetsDirectional.only(start: 0, top: 0),
                width: double.maxFinite,
                child: Text(
                  UserInfo.to.isUserVip
                      ? (Get.isInd
                          ? dateFormat((UserInfo.to.endTime),
                              formatStr: Get.isEn ? "dd/MM/yyyy" : 'yyyy.MM.dd')
                          : Tr.app_time_end.trArgs([
                              dateFormat((UserInfo.to.endTime),
                                  formatStr:
                                      Get.isEn ? "dd/MM/yyyy" : 'yyyy.MM.dd')
                            ]))
                      : vipBenefits,
                  maxLines: 2,
                  style: TextStyle(
                      color: UserInfo.to.isUserVip
                          ? const Color(0xFF745641)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        PositionedDirectional(
            top: 0,
            end: 20,
            child: Image.asset(
              UserInfo.to.isUserVip
                  ? Assets.benefitKing
                  : Assets.benefitVipToKing,
              width: 96,
              height: 96,
              matchTextDirection: true,
            ))
      ],
    );
  }

  Widget buildVip() {
    return GetBuilder<VipLogic>(
      init: VipLogic(),
      builder: (logic) => VipList(
        discountVip: logic.discountVip,
        data: logic.data,
        path: ChargePath.recharge_vip,
        selectIndex: 0,
        area: logic.area,
      ),
    );
  }
}
