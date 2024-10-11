import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sign/widget/sign_container.dart';
import 'package:oliapro/entities/sign_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/widget/scale_transform.dart';

void toSignDialog() {
  if (!AppConstants.isFakeMode) {
    Http.instance
        .post<SignData>(NetPath.getDailyConfigs, showLoading: true)
        .then((value) {
      // debugPrint("===>${value.signInDailyVip?.first.isVip}");
      /* debugPrint("sign=> ${value.signDay}");
      for (var value1 in value.signInDaily!.toList()) {
        debugPrint("sign=> ${value1.toJson()}");
      }*/

      Get.dialog(DialogSign(data: value),
          routeSettings: const RouteSettings(name: AppPages.signDialog),
          barrierDismissible: true);
    });
  }
}

class DialogSign extends StatefulWidget {
  final SignData data;
  const DialogSign({super.key, required this.data});

  @override
  State<DialogSign> createState() => _DialogSignState();
}

class _DialogSignState extends State<DialogSign> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransform(
      child: body(),
    );
  }

  Widget body() => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          PositionedDirectional(
              start: -25,
              end: -25,
              top: 0,
              bottom: 0,
              child: Image.asset(
                Assets.signSignBgBg,
                //fit: BoxFit.fitWidth,
              )),
          Column(
            children: [
              const Spacer(),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    width: 328,
                    height: 520 + 16,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFF5979), Color(0xFFFDADC1)]),
                            width: 4,
                          ),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      margin: const EdgeInsetsDirectional.only(
                          start: 5, end: 5, bottom: 5, top: 90),
                      child: SignContainer(
                        data: widget.data,
                      ),
                    ),
                  ),
                  Container(
                    width: 325,
                    height: 120,
                    padding: const EdgeInsetsDirectional.only(
                        start: 50, end: 50, top: 44),
                    alignment: AlignmentDirectional.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            matchTextDirection: true,
                            image: ExactAssetImage(Assets.signSignTitleBg))),
                    child: AutoSizeText(
                      Tr.app_setting_day_sign.tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      maxFontSize: 18,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6F3507),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  PositionedDirectional(
                      top: 10,
                      end: 10,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(top: 20),
                          child: Image.asset(
                            Assets.imgCloseDialog,
                            width: 34,
                            height: 34,
                          ),
                        ),
                      )),
                ],
              ),
              const Spacer()
            ],
          ),
        ],
      );
}
