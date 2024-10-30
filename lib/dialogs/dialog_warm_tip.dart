import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_some_extension.dart';

void checkToWarmTipShow({Function? onEnd}) {
  // if (AppConstants.isFakeMode) {
  //   return;
  // }
  var hadShow = StorageService.to.prefs.getBool('firstTip');
  if (hadShow == true) {
    onEnd?.call();
    return;
  } else {
    StorageService.to.prefs.setBool('firstTip', true);
    //这里必须加延迟
    Future.delayed(const Duration(seconds: 1), () {
      Get.dialog(AppWarmTip(onEnd: () {
        onEnd?.call();
      }), routeSettings: const RouteSettings(name: AppPages.warmTipDialog));
    });
  }
}

//首次文明弹窗
class AppWarmTip extends StatefulWidget {
  final Function? onEnd;
  const AppWarmTip({super.key, this.onEnd});

  @override
  State<AppWarmTip> createState() => _AppFirstTipState();
}

class _AppFirstTipState extends State<AppWarmTip> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onEnd != null) {
      widget.onEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsetsDirectional.only(
                  start: 12, end: 12, bottom: 12, top: Get.isEs ? 118 : 95),
              margin:
                  const EdgeInsetsDirectional.only(start: 20, end: 20, top: 25),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      stops: [0, 0.4],
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [Color(0xFFFFC7E5), Color(0xFFFFF8D4)]),
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFE219),
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(16))),
                    padding: const EdgeInsetsDirectional.all(10),
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 8),
                          child: Image.asset(
                            Assets.iconWarmStop,
                            matchTextDirection: true,
                            width: 42,
                            height: 42,
                          ),
                        ),
                        Expanded(
                            child: Text(
                          Tr.app_dialog_warning_text_2.tr,
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF572727),
                              fontSize: 14),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFE219),
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(16))),
                    padding: const EdgeInsetsDirectional.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 8),
                          child: Image.asset(
                            Assets.iconWarmStop,
                            matchTextDirection: true,
                            width: 42,
                            height: 42,
                          ),
                        ),
                        Expanded(
                            child: AutoSizeText(
                          Tr.app_dialog_warning_text_3.tr,
                          maxFontSize: 14,
                          minFontSize: 12,
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF572727),
                              fontSize: 14),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 10),
                    child: Text(
                      Tr.app_dialog_warning_text_4.tr,
                      style: const TextStyle(
                          color: Color(0xFF9B989D), fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 255,
                      height: 54,
                      alignment: AlignmentDirectional.center,
                      margin:
                          const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              matchTextDirection: true,
                              image:
                                  ExactAssetImage(Assets.iconBindGoogleBtn))),
                      child: Text(
                        Tr.app_base_confirm.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            buildWarmTop(),
          ],
        )
      ],
    );
  }

  Widget buildWarmTop() {
    return UnconstrainedBox(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          PositionedDirectional(
              top: 0,
              start: 10,
              child: Image.asset(
                Assets.iconInverted,
                width: 64,
                height: 64,
                matchTextDirection: true,
              )),
          PositionedDirectional(
              top: 20,
              child: Image.asset(
                Assets.iconBeauty,
                width: 84,
                height: 95,
                matchTextDirection: true,
              )),
          Container(
            margin: const EdgeInsetsDirectional.only(end: 78, top: 40),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: 240,
                  //height: 100,
                  constraints:
                      const BoxConstraints(minHeight: 78, maxHeight: 100),
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  padding: const EdgeInsetsDirectional.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  child: AutoSizeText(
                    //es
                    //language_es[Tr.app_dialog_warning_text_1] ?? "",
                    Tr.app_dialog_warning_text_1.tr,
                    maxFontSize: 13,
                    minFontSize: 13,
                    style:
                        const TextStyle(color: Color(0xFF632E2E), fontSize: 13),
                  ),
                ),
                PositionedDirectional(
                    top: 30,
                    child: Image.asset(
                      Assets.iconTriangle,
                      width: 10,
                      height: 18,
                      matchTextDirection: true,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
