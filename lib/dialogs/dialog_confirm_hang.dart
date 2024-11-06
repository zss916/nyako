import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_common_type.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/pages/call/aiv/index.dart';

import '../common/language_key.dart';

void showHangDialog(
    {String? avatar,
    String? title,
    AppCallback<int>? callback,
    String? pathName}) {
  Get.dialog(
      AppDialogConfirmHang(
        avatar: avatar ?? "",
        title: title ?? Tr.app_call_hang_up_tip.tr,
        callback: (i) {
          if (i == 1) {
            callback?.call(i);
          }
        },
        isPick: false,
      ),
      routeSettings: RouteSettings(name: pathName ?? ""));
}

class AppDialogConfirmHang extends StatelessWidget {
  final AppCallback<int> callback;
  final String title;
  final bool isPick;
  final String avatar;

  const AppDialogConfirmHang({
    super.key,
    required this.callback,
    required this.title,
    required this.avatar,
    this.isPick = true,
  });

  @override
  Widget build(BuildContext context) {
    return AiVShowDialogWidget(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20, top: 20, bottom: 20, end: 100),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            matchTextDirection: true,
                            image: ExactAssetImage(Assets.iconHangBg))),
                    margin: const EdgeInsetsDirectional.only(
                        start: 25, end: 25, top: 25),
                    width: double.maxFinite,
                    height: 102,
                    child: AutoSizeText(
                      Tr.app_confirm_hang_up_tip.tr,
                      maxLines: 2,
                      maxFontSize: 18,
                      minFontSize: 14,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: AppConstants.fontsBold,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  PositionedDirectional(
                      top: 0,
                      end: 35,
                      child: Image.asset(
                        Assets.animaNyakoHang,
                        width: 110,
                        height: 110,
                        matchTextDirection: true,
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        callback.call(1);
                      },
                      child: Container(
                        width: 125,
                        height: 52,
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(30)),
                        child: Text(
                          Tr.app_base_confirm.tr,
                          style: TextStyle(
                              color: const Color(0xFF9341FF),
                              fontSize: 15,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        callback.call(0);
                      },
                      child: Container(
                        width: 125,
                        height: 52,
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 5, horizontal: 5),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            /*boxShadow: const [
                              BoxShadow(color: Color(0xA69341FF), blurRadius: 5)
                            ],*/
                            color: const Color(0xFF9341FF),
                            borderRadius: BorderRadiusDirectional.circular(30)),
                        child: Text(
                          Tr.app_base_cancel.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: AppConstants.fontsRegular,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AiVShowDialogWidget extends StatefulWidget {
  final Widget child;

  const AiVShowDialogWidget({super.key, required this.child});

  @override
  State<AiVShowDialogWidget> createState() => _AiVShowDialogWidgetState();
}

class _AiVShowDialogWidgetState extends State<AiVShowDialogWidget> {
  @override
  void initState() {
    super.initState();
    AivLogic.openHangDialog = true;
  }

  @override
  void dispose() {
    super.dispose();
    AivLogic.openHangDialog = false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
