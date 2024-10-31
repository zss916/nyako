import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
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
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset(
                Assets.signNyakoSignTop,
                width: 315,
                height: 52,
                matchTextDirection: true,
              ),
              Container(
                width: double.maxFinite,
                height: 420,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Color(0xFFF1E9EC), offset: Offset(0, 6))
                    ],
                    gradient: const LinearGradient(
                        stops: [0.7, 1],
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [Color(0xFF4E3CFF), Color(0xFF9852FF)]),
                    border:
                        Border.all(width: 2, color: const Color(0xFFF1E9EC)),
                    borderRadius: BorderRadiusDirectional.circular(20)),
                margin: const EdgeInsetsDirectional.only(
                    start: 30, end: 30, bottom: 0, top: 52),
                child: SignContainer(
                  data: widget.data,
                ),
              ),
              PositionedDirectional(
                  top: 0,
                  end: 25,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(top: 0),
                      child: Image.asset(
                        Assets.iconCloseDialog,
                        width: 42,
                        height: 42,
                      ),
                    ),
                  )),
            ],
          )
        ],
      );
}
