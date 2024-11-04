import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/widget/app_net_image.dart';

class AppGiftFollowTipController {
  bool _hadSendGift = false;
  bool hadFollow = false;
  String? herId;
  String? portrait;
  AppCallback<int>? callback;

  AppGiftFollowTipController();

  void setUser(String? portrait, bool hadFollow) {
    this.portrait = portrait;
    this.hadFollow = hadFollow;
  }

  void hadSendGift() {
    _hadSendGift = true;
  }

  void listen(AppCallback<int> callback) {
    this.callback = callback;
  }
}

class AppGiftFollowTip extends StatefulWidget {
  AppGiftFollowTipController controller;

  AppGiftFollowTip({super.key, required this.controller});

  @override
  State<AppGiftFollowTip> createState() => _AppGiftFollowTipState();
}

class _AppGiftFollowTipState extends State<AppGiftFollowTip> {
  OverlayEntry? overlayEntry;
  Timer? _timer;
  int _time = 0;
  late AppCallback<int> _callback;

  void showFollowGift({bool type = false}) {
    overlayEntry?.remove();
    overlayEntry = null;
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Listener(
        onPointerMove: (event) {
          if (mounted) {
            overlayEntry?.remove();
            overlayEntry = null;
          }
        },
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          height: 80,
          padding: const EdgeInsetsDirectional.only(
            start: 15,
            end: 15,
          ),
          child: type
              ? AppSendGiftTip(
                  callback: _callback,
                )
              : YuliaFollowTip(
                  callback: _callback,
                  portrait: widget.controller.portrait,
                ),
        ),
      );
    });
    Overlay.of(context)?.insert(overlayEntry!);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _time++;
      // AppLog.debug('YuliaGiftFollowTip _time = $_time');
      if (_time == 10 && !widget.controller.hadFollow) {
        if (ARoutes.isCalling || ARoutes.isChat) {
          showFollowGift();
        }
      }
      // if (_time == 15) {
      //   overlayEntry?.remove();
      //   overlayEntry = null;
      // }
      if (_time == 20 && !widget.controller._hadSendGift) {
        if (ARoutes.isCalling || ARoutes.isChat) {
          showFollowGift(type: true);
        }
      }
      // if (_time == 25) {
      //   overlayEntry?.remove();
      //   overlayEntry = null;
      //   _timer?.cancel();
      //   _timer = null;
      // }
    });

    _callback = (i) {
      // 0关闭,1确定关注,2确定发礼物
      widget.controller.callback?.call(i);
      overlayEntry?.remove();
      overlayEntry = null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    overlayEntry?.remove();
  }
}

class YuliaFollowTip extends StatelessWidget {
  AppCallback<int> callback;
  String? portrait;

  YuliaFollowTip({Key? key, required this.callback, this.portrait})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(
              start: 14, end: 14, bottom: 15, top: 10),
          padding: const EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius:
                  const BorderRadiusDirectional.all(Radius.circular(8))),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: AppNetImage(
                    portrait ?? '',
                    height: 36,
                    width: 36,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  end: 24,
                ),
                child: Text.rich(TextSpan(
                    text: Tr.app_video_to_follow_tip.tr,
                    style: const TextStyle(
                        color: AppColors.textColor333, fontSize: 14))),
              )),
              GestureDetector(
                onTap: () {
                  //关注主播
                  callback.call(1);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.baseColorRed,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(14))),
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                  height: 28,
                  child: Text(
                    Tr.app_video_follow.tr,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                callback.call(0);
              },
              child: SizedBox(
                width: 36,
                height: 36,
                child: Image.asset(
                  Assets.iconCloseDialog,
                  fit: BoxFit.fill,
                ),
              ),
            ))
      ],
    );
  }
}

class AppSendGiftTip extends StatelessWidget {
  AppCallback<int> callback;
  String? portrait;
  AppSendGiftTip({Key? key, required this.callback, this.portrait})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(
              start: 14, end: 14, bottom: 15, top: 10),
          padding: const EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius:
                  const BorderRadiusDirectional.all(Radius.circular(8))),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  child: AppNetImage(
                    portrait ?? "",
                    height: 36,
                    width: 36,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  end: 24,
                ),
                child: Text.rich(TextSpan(
                    text: Tr.app_video_to_gift_tip.tr,
                    style: const TextStyle(
                        color: AppColors.textColor333, fontSize: 14))),
              )),
              GestureDetector(
                onTap: () {
                  //送礼
                  callback.call(2);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.colorFF890E,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(14))),
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
                  height: 28,
                  child: Text(
                    Tr.app_video_send_gift.tr,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const SizedBox(
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
        ),
        Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                callback.call(0);
              },
              child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  Assets.iconCloseDialog,
                  fit: BoxFit.fill,
                ),
              ),
            ))
      ],
    );
  }
}
