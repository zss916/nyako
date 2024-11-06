import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/entities/app_gift_entity.dart';
import 'package:nyako/services/user_info.dart';
import 'package:nyako/utils/app_extends.dart';

class GiftPusher {
  // 在礼物横幅队列中增加
  GiftPusher.add(
      List<Map> giftBannerView, Map json, int removeTime, Function cb) {
    json['widget'] = GiftBanner(
      giftInfo: json['config'],
      queueLength: giftBannerView.length,
    );
    giftBannerView.add(json);
    cb(giftBannerView); // 将重新生成的礼物横幅队列Widget返回给直播间setState

    // 给定时间后从队列中将礼物移除
    Timer(Duration(milliseconds: removeTime), () {
      for (int i = 0; i < giftBannerView.length; i++) {
        if (json['stamp'] == giftBannerView[i]['stamp']) {
          giftBannerView.removeAt(i);
          cb(giftBannerView);
        }
      }
    });
  }
}

class GiftBanner extends StatefulWidget {
  final GiftEntity giftInfo;
  final int queueLength;
  const GiftBanner(
      {super.key, required this.giftInfo, required this.queueLength});

  @override
  _GiftBannerState createState() => _GiftBannerState();
}

// 单个礼物横幅的动画Widget
class _GiftBannerState extends State<GiftBanner>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationGiftNum_1,
      animationGiftNum_2,
      animationGiftNum_3;
  late AnimationController controller;
  bool hadInit = false;
  @override
  void initState() {
    super.initState();
    if (widget.queueLength >= 4) return;
    hadInit = true;
    controller = AnimationController(
        duration: const Duration(milliseconds: 1800), vsync: this);

    // 礼物数量图片变大
    animationGiftNum_1 = Tween(
      begin: 0.0,
      end: 1.7,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.75, 0.85, curve: Curves.easeOut),
    ));

    // 礼物数量图片变小
    animationGiftNum_2 = Tween(
      begin: 1.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
    ));

    // 横幅从屏幕外滑入
    double an3Begin = -244;
    animationGiftNum_3 = Tween(
      begin: an3Begin,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.65, 0.85, curve: Curves.easeIn),
    ));

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();

    if (hadInit) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return !hadInit
        ? const SizedBox.shrink()
        : AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              return PositionedDirectional(
                start: animationGiftNum_3.value,
                top: 145.0 + 80 * widget.queueLength,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      height: 55,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 10),
                      margin: const EdgeInsetsDirectional.only(start: 15),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFF9716FF),
                            Color(0xFFFF16BA),
                            Color(0xFFFF16BA),
                          ]), // 渐变色
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsetsDirectional.only(start: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: cachedImage(
                                  UserInfo.to.myDetail?.portrait ?? ''),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AutoSizeText(
                                    Tr.app_gift_send.tr,
                                    overflow: TextOverflow.ellipsis,
                                    maxFontSize: 12,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            widget.giftInfo.icon ?? '',
                            height: 50,
                            width: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Transform.scale(
                              scale: animationGiftNum_1.value >= 1.7
                                  ? animationGiftNum_2.value
                                  : animationGiftNum_1.value,
                              child: const Text(
                                '×',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: animationGiftNum_1.value >= 1.7
                                ? animationGiftNum_2.value
                                : animationGiftNum_1.value,
                            child: const Text(
                              '1',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
