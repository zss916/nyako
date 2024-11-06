import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/dialogs/sign/widget/base_sign_button.dart';
import 'package:nyako/dialogs/sign/widget/sign_day_widget.dart';
import 'package:nyako/dialogs/sign/widget/sign_switch_button.dart';
import 'package:nyako/dialogs/sign/widget/vip_sign_button.dart';
import 'package:nyako/dialogs/sign/widget/vip_sign_day_widget.dart';
import 'package:nyako/entities/sign_entity.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/services/user_info.dart';
import 'package:widget_marquee/widget_marquee.dart';

class SignContainer extends StatefulWidget {
  final SignData data;
  const SignContainer({super.key, required this.data});

  @override
  State<SignContainer> createState() => _SignContainerState();
}

class _SignContainerState extends State<SignContainer> {
  bool showCommonSign = false;

  bool isOpenVip = UserInfo.to.isUserVip;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        showCommonSign = !UserInfo.to.isUserVip;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: 10),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius:
              BorderRadiusDirectional.vertical(bottom: Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            child: commonAndVipTitle(),
          ),
          const SizedBox(
            height: 12,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              showCommonSign
                  ? SignDayWidget(
                      data: widget.data.signInDaily ?? [],
                      signDay: widget.data.getSignNum(isVip: isOpenVip),
                    )
                  : VipSignDayWidget(
                      data: widget.data.signInDailyVip ?? [],
                      signDay: widget.data.getSignNum(isVip: isOpenVip),
                    ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // if (isOpenVip)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 7),
            decoration: const BoxDecoration(color: Color(0x1AFFFFFF)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 3),
                  child: Image.asset(
                    Assets.signNyakoBroadcast,
                    width: 20,
                    height: 20,
                    matchTextDirection: true,
                  ),
                ),
                Expanded(
                    child: Marquee(
                  delay: const Duration(seconds: 1),
                  pause: const Duration(seconds: 0),
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 3),
                    child: Text(
                      Tr.app_vip_sign_extra.tr,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          isOpenVip
              ? SignSwitchButton(
                  isShow: showCommonSign,
                  child: BaseSignButton(
                    widget.data.getVipSignData(isVip: isOpenVip),
                    isToSign: widget.data.isToSign(isVip: isOpenVip),
                    onSignBack: (data) {},
                  ),
                )
              : commonAndVipButton(),
        ],
      ),
    );
  }

  Widget commonAndVipTitle() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0x33FFFFFF),
          borderRadius: BorderRadius.circular(12)),
      width: double.maxFinite,
      height: 44,
      padding: const EdgeInsetsDirectional.all(2),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              if (mounted) {
                setState(() {
                  showCommonSign = true;
                });
              }
            },
            child: Container(
              height: 44,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              width: double.maxFinite,
              alignment: AlignmentDirectional.center,
              decoration: showCommonSign
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(10))
                  : const BoxDecoration(),
              child: AutoSizeText(
                Tr.appSignNow.tr,
                textAlign: TextAlign.center,
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    color:
                        showCommonSign ? const Color(0xFF9341FF) : Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )),
          const SizedBox.shrink(),
          Expanded(
              child: InkWell(
            onTap: () {
              if (mounted) {
                setState(() {
                  showCommonSign = false;
                });
              }
            },
            child: Container(
              height: 44,
              width: double.maxFinite,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              alignment: AlignmentDirectional.center,
              decoration: showCommonSign
                  ? const BoxDecoration()
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(10)),
              child: AutoSizeText(
                Tr.appVipSignTitle.tr,
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color:
                        showCommonSign ? Colors.white : const Color(0xFF9341FF),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget commonAndVipButton() {
    return showCommonSign
        ? BaseSignButton(
            widget.data.getCommonSignData(isVip: isOpenVip),
            isToSign: widget.data.isToSign(isVip: isOpenVip),
            onSignBack: (data) {},
          )
        : VipSignButton();
  }

  Widget get vipTitle => Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 0),
        alignment: AlignmentDirectional.center,
        child: AutoSizeText(
          Tr.appVipSignTitle.tr,
          textAlign: TextAlign.center,
          maxFontSize: 14,
          minFontSize: 10,
          maxLines: 1,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );

  //Usuários VIP podem receber recompensas adicionais todos os dias

  Widget get vipTip => Container(
        margin: const EdgeInsetsDirectional.only(start: 8, end: 8, bottom: 5),
        alignment: AlignmentDirectional.center,
        child: AutoSizeText(
          Tr.app_vip_sign_extra.tr,
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 12,
          minFontSize: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );
}
