import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';

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
    return Container(
      width: double.maxFinite,
      height: 420,
      margin: const EdgeInsetsDirectional.only(
          start: 30, end: 30, top: 0, bottom: 0),
      alignment: AlignmentDirectional.center,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 400,
            alignment: AlignmentDirectional.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.bottomStart,
                    end: AlignmentDirectional.topEnd,
                    colors: [
                      Color(0xFF8940FF),
                      Color(0xFFD34BFD),
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            margin: const EdgeInsetsDirectional.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //color: Colors.blue,
                  padding: const EdgeInsetsDirectional.only(
                      bottom: 5, start: 15, end: 15, top: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(
                            start: 15, end: 15, bottom: 0),
                        alignment: AlignmentDirectional.centerStart,
                        width: double.maxFinite,
                        child: AutoSizeText(
                          Tr.app_alert_tips.tr,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          maxLines: 1,
                          maxFontSize: 20,
                          minFontSize: 10,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 260,
                        // color: Colors.red,
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10),
                                child: Text(
                                  Tr.app_dialog_warning_text_1.tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFFEEE9),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(14))),
                                padding: const EdgeInsetsDirectional.all(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 8),
                                      child: Image.asset(
                                        Assets.imgWarmIcon1,
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
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFE2C55),
                                          fontSize: 14),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFFEEE9),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(14))),
                                padding: const EdgeInsetsDirectional.all(10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          end: 8),
                                      child: Image.asset(
                                        Assets.imgWarmIcon2,
                                        matchTextDirection: true,
                                        width: 42,
                                        height: 42,
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      Tr.app_dialog_warning_text_3.tr,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFE2C55),
                                          fontSize: 12),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: Text(
                                  Tr.app_dialog_warning_text_4.tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                    width: double.maxFinite,
                    height: 90,
                    alignment: AlignmentDirectional.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            matchTextDirection: true,
                            fit: BoxFit.fill,
                            image: ExactAssetImage(
                              Assets.imgWramDownBg,
                            ))),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.back(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: AlignmentDirectional.topCenter,
                                end: AlignmentDirectional.bottomCenter,
                                colors: [Colors.white, Color(0xFFFFCAF8)]),
                            borderRadius: BorderRadiusDirectional.circular(50)),
                        child: Text(
                          Tr.app_base_confirm.tr,
                          style: const TextStyle(
                              color: Color(0xFF8239FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          PositionedDirectional(
              top: 0,
              end: 0,
              child: Image.asset(
                Assets.imgWarmTipTitleTop,
                matchTextDirection: true,
                width: 134,
                height: 102,
              )),
        ],
      ),
    );
  }
}
