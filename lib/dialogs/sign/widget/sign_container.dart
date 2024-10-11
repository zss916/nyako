import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sign/widget/base_sign_button.dart';
import 'package:oliapro/dialogs/sign/widget/sign_day_widget.dart';
import 'package:oliapro/dialogs/sign/widget/sign_switch_button.dart';
import 'package:oliapro/dialogs/sign/widget/vip_sign_button.dart';
import 'package:oliapro/dialogs/sign/widget/vip_sign_day_widget.dart';
import 'package:oliapro/entities/sign_entity.dart';
import 'package:oliapro/services/user_info.dart';

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
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    Color(0xFFFFD9A4),
                    Color(0xFFFF643E),
                    Color(0xFFFF0E40),
                  ]),
              borderRadius:
                  BorderRadiusDirectional.vertical(top: Radius.circular(16))),
          alignment: AlignmentDirectional.topCenter,
          padding: const EdgeInsetsDirectional.only(top: 25),
          constraints: const BoxConstraints(minHeight: 52),
          width: double.maxFinite,
          child: (!isOpenVip) ? vipTip : const SizedBox.shrink(),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsetsDirectional.only(top: 10),
          width: double.maxFinite,
          decoration: const BoxDecoration(
              color: Color(0xFFFFEADF),
              borderRadius: BorderRadiusDirectional.vertical(
                  bottom: Radius.circular(16))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
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
              /*Expanded(
                  child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.black,
              ))*/
            ],
          ),
        )),
      ],
    );
  }

  Widget commonAndVipTitle() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      width: double.maxFinite,
      height: 40,
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
              height: 36,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              width: double.maxFinite,
              alignment: AlignmentDirectional.center,
              decoration: showCommonSign
                  ? BoxDecoration(
                      gradient: const LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          stops: [
                            0.1,
                            1
                          ],
                          colors: [
                            Color(0xFFFF9848),
                            Color(0xFFFF1818),
                          ]),
                      borderRadius: BorderRadiusDirectional.circular(30))
                  : const BoxDecoration(),
              child: AutoSizeText(
                Tr.appSign.tr,
                textAlign: TextAlign.center,
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    color:
                        showCommonSign ? Colors.white : const Color(0xFFE35D5D),
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
              height: 36,
              width: double.maxFinite,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              alignment: AlignmentDirectional.center,
              decoration: showCommonSign
                  ? const BoxDecoration()
                  : BoxDecoration(
                      gradient: const LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          stops: [
                            0.1,
                            1
                          ],
                          colors: [
                            Color(0xFFFF9848),
                            Color(0xFFFF1818),
                          ]),
                      borderRadius: BorderRadiusDirectional.circular(30)),
              child: AutoSizeText(
                Tr.appVipSignTitle.tr,
                maxFontSize: 14,
                minFontSize: 12,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color:
                        showCommonSign ? const Color(0xFFE35D5D) : Colors.white,
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

  /* Widget commonAndVipTitle() {
    return showCommonSign
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 166,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showCommonSign = false;
                      });
                    },
                    child: const VipSignTitle(),
                  )),
              Expanded(flex: 133, child: SignTitle(isVip: !showCommonSign)),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 133, child: SignTitle(isVip: !showCommonSign)),
              Expanded(
                  flex: 166,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showCommonSign = true;
                      });
                    },
                    child: const CommonSignTitle(),
                  )),
            ],
          );
  }*/
}
