import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/call/aiv/index.dart';

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
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: 305,
                height: 345,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(30),
                    gradient: const LinearGradient(
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter,
                        colors: [
                          Color(0xFF201436),
                          Color(0xFF0C0C32),
                        ])),
              ),
              Image.asset(
                Assets.imgHangUpBg,
                width: 293,
                height: 470,
                matchTextDirection: true,
              ),
              PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: 10,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: double.maxFinite,
                    padding: const EdgeInsetsDirectional.all(20),
                    margin:
                        const EdgeInsetsDirectional.only(start: 30, end: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 265,
                          height: 110,
                          padding: const EdgeInsetsDirectional.only(
                              top: 15, bottom: 15, start: 10, end: 10),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  matchTextDirection: true,
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage(
                                      Assets.imgHangUpContentBg))),
                          margin: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 30),
                          child: Container(
                            //color: Colors.black26,
                            width: 200,
                            height: 100,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              title,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            callback.call(0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            height: 57,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(30),
                                gradient: AppColors.btnGradient),
                            child: Text(
                              Tr.app_base_cancel.tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            callback.call(1);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            alignment: Alignment.center,
                            height: 46,
                            width: double.infinity,
                            child: AutoSizeText(
                              Tr.app_confirm_hang_up.tr,
                              maxLines: 1,
                              maxFontSize: 16,
                              minFontSize: 8,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
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
