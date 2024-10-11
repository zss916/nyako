import 'package:flutter/material.dart';
import 'package:flutter_vap2/vap_view.dart';
import 'package:oliapro/entities/app_gift_entity.dart';
import 'package:oliapro/utils/app_queue_util.dart';
import 'package:oliapro/widget/app_cache_manager.dart';

import 'app_gift_animate.dart';

class AppVapController {
  _AppVapPlayerState? state;

  void playGift(GiftEntity gift) {
    // debugPrint('VapPlayer addGift ${gift.animEffectUrl}');
    if (state == null) return;
    state?.showPush(gift);
    if (gift.animEffectUrl == null || gift.animEffectUrl!.isEmpty) return;
    // debugPrint('VapPlayer isAddGift ${gift.animEffectUrl}');
    if ((gift.animEffectUrl ?? "").trim().isNotEmpty) {
      GiftCacheManager.instance
          .getSingleFile(gift.animEffectUrl ?? '')
          .then((value) {
        // debugPrint('VapPlayer getSingleFile ${value.path}');
        AppQueueUtil.get("vapQueue")?.addTask(() async {
          await state?.playPath2(value.path);
        });
      });
    }
  }

  void stop() {
    AppQueueUtil.get("vapQueue")?.cancelTask();
  }
}

class AppVapPlayer extends StatefulWidget {
  late AppVapController vapController;

  AppVapPlayer({super.key, required this.vapController});

  @override
  _AppVapPlayerState createState() => _AppVapPlayerState();
}

class _AppVapPlayerState extends State<AppVapPlayer> {
  bool playing = false;
  List<Map> giftBannerView = []; // 礼物横幅列表JSON
  // late VapViewController vapViewController;
  String path = '';

  @override
  void initState() {
    super.initState();
    widget.vapController.state = this;
  }

  void play(bool playing) {
    // AppLog.debug('VapPlayer play = ${playing}');
    setState(() {
      this.playing = playing;
    });
  }

  Future playPath(String path) async {
    //AppLog.debug('VapPlayer playPath = ${path}');
    setState(() {
      playing = true;
    });
    // await vapViewController.playPath(path);
    setState(() {
      playing = false;
    });
  }

  Future playPath2(String path) async {
    // AppLog.debug('VapPlayer playPath = ${path}');
    setState(() {
      playing = true;
      this.path = path;
    });
  }

  void showPush(GiftEntity gift) {
    var now = DateTime.now();
    var obj = {'stamp': now.millisecondsSinceEpoch, 'config': gift};
    GiftPusher.add(giftBannerView, obj, 6500, (giftBannerViewNew) {
      if (mounted) {
        setState(() {
          giftBannerView = giftBannerViewNew;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.vapController.state = null;
    widget.vapController.stop();
  }

  @override
  Widget build(BuildContext context) {
    // 这样目的是不动画时隐藏，防止出现意外遮挡
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: !playing
              ? const SizedBox.shrink()
              : IgnorePointer(
                  child: AppVapView(
                      path: path,
                      vapPlayCompleteCallBack: () {
                        setState(() {
                          playing = false;
                          path = '';
                        });
                      }),
                ),
        ),
        ..._setGiftBannerView(),
      ],
    );
  }

  List<Widget> _setGiftBannerView() {
    List<Widget> banner = [];
    for (var item in giftBannerView) {
      banner.add(item['widget']);
    }
    return banner;
  }
}

class AppVapView extends StatefulWidget {
  final String path;
  VoidCallback? vapPlayCompleteCallBack;

  AppVapView({Key? key, required this.path, this.vapPlayCompleteCallBack})
      : super(key: key);

  @override
  _AppVapViewState createState() => _AppVapViewState();
}

class _AppVapViewState extends State<AppVapView> {
  @override
  void initState() {
    super.initState();
  }

  playVap(VapViewController vapViewController) async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      var res = await vapViewController.playPath(widget.path);
      widget.vapPlayCompleteCallBack?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VapViewB(
      scaleType: 2,
      onVapViewCreated: (controller) {
        playVap(controller);
      },
    );
  }
}
