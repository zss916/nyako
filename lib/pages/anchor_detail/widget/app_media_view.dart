import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/dialogs/sheet_report.dart';
import 'package:oliapro/entities/app_host_entity.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/anchor_detail/widget/anchor_btn.dart';
import 'package:oliapro/pages/anchor_detail/widget/app_media_view_page.dart';
import 'package:oliapro/routes/app_pages.dart';
import 'package:oliapro/services/storage_service.dart';
import 'package:oliapro/utils/app_event_bus.dart';
import 'package:oliapro/widget/app_net_image.dart';
import 'package:oliapro/widget/base_app_bar.dart';
//import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class AppMediaViewPage extends StatefulWidget {
  final AppMediaViewBean bean;
  String? uid;

  AppMediaViewPage({super.key, required this.bean, this.uid});

  @override
  State<AppMediaViewPage> createState() => _AppMediaViewState();
}

class _AppMediaViewState extends State<AppMediaViewPage>
    with WidgetsBindingObserver, RouteAware {
  bool playing = false;
  bool pause = false;
  CachedVideoPlayerPlusController? _controller;
  late Function() listener;
  //VideoPlayerController? _controller;

  void playIt() {
    if (mounted) {
      setState(() {
        _controller?.play();
        playing = true;
      });
    }
  }

  bool isShowFrame = false;

  @override
  void initState() {
    super.initState();
    // 注册应用生命周期监听
    WidgetsBinding.instance.addObserver(this);
    WakelockPlus.enable();
    if (widget.bean.type == 1) {
      /*_controller = VideoPlayerController.network(
        widget.bean.path,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );*/

      _controller = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(widget.bean.path),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        invalidateCacheIfOlderThan: const Duration(hours: 1),
      );
      listener = () {
        if (mounted) {
          setState(() {
            isShowFrame = (_controller?.value.position.inMicroseconds ?? 0) > 0;
          });
        }
      };

      _controller?.addListener(listener);
      _controller?.setLooping(true);
      _controller?.initialize().then((value) {
        playIt();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 注册页面路由监听
    AppPages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Scaffold(
            appBar: BaseAppBar(
              leading: InkWell(
                onTap: () => Get.back(),
                child: UnconstrainedBox(
                  child: Image.asset(
                    Assets.imgCloseDialog,
                    width: 34,
                    height: 34,
                    matchTextDirection: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              actions: [
                _report(widget.uid ?? "", 0, widget.bean.type,
                    mid: widget.bean.mId),
              ],
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: playing
                ? GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          if (pause) {
                            pause = false;
                            _controller?.play();
                          } else {
                            pause = true;
                            _controller?.pause();
                          }
                        });
                      }
                    },
                    child: SizedBox.expand(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          /*if (_controller!.value.isInitialized)
                            Center(
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                            ),*/

                          Center(
                            child: (_controller!.value.isInitialized)
                                ? AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: CachedVideoPlayerPlus(_controller!),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          if (!isShowFrame)
                            AppNetImage(
                              widget.bean.cover ?? '',
                              fit: BoxFit.cover,
                              placeholderAsset: Assets.imgAnchorBigDefaultBg,
                            ),
                          if (pause)
                            const Center(
                              child: Icon(
                                Icons.play_circle_outline_rounded,
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                          VideoProgressIndicator(
                            _controller!,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                                playedColor: Color(0xFF7934F0),
                                bufferedColor: Color.fromRGBO(50, 50, 200, 0.2),
                                backgroundColor:
                                    Color.fromRGBO(200, 200, 200, 0.5)),
                          ),
                        ],
                      ),
                    ),
                  )
                : Hero(
                    tag: widget.bean.heroId,
                    child: SizedBox.expand(
                      child: widget.bean.type == 0
                          ? AppNetImage(
                              widget.bean.path,
                              fit: BoxFit.cover,
                              placeholderAsset: Assets.imgAnchorBigDefaultBg,
                            )
                          : GestureDetector(
                              onTap: playIt,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: AppNetImage(
                                      widget.bean.cover ?? '',
                                      fit: BoxFit.cover,
                                      placeholderAsset:
                                          Assets.imgAnchorBigDefaultBg,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.play_circle_outline_rounded,
                                    color: Color(0xFF7934F0),
                                    size: 100,
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
          ),
        ),
        if (widget.bean.data != null) btn(widget.bean.data!)
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // _controller?.play();
        break;
      case AppLifecycleState.inactive:

        ///非活跃

        break;
      case AppLifecycleState.hidden:

        ///前后台切换时调用

        break;
      case AppLifecycleState.paused:
        if (mounted) {
          setState(() {
            pause = true;
            _controller?.pause();
          });
        }
        break;
      case AppLifecycleState.detached:

        ///退出应用调用
        break;
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    if (mounted) {
      if (playing) _controller?.pause();
      setState(() {
        pause = true;
      });
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller?.removeListener(listener);
      _controller?.dispose();
    }
    // 移除生命周期监听
    WidgetsBinding.instance.removeObserver(this);
    // 移除页面路由监听
    AppPages.observer.unsubscribe(this);
    WakelockPlus.disable();
    super.dispose();
  }

  _report(String uid, int index, int type, {String? mid}) {
    // debugPrint("report===>>B type: $type , mid: ${mid},");
    return GestureDetector(
      /* onTap: () => ARoutes.toReport(
          uid: uid,
          mid: mid,
          index: index.toString(),
          type: ReportEnum.anchorDetailImage.index.toString()),*/
      onTap: () {
        showReportSheet(uid, close: () {
          StorageService.to.updateBlackList(uid, true);
          AppEventBus.eventBus.fire(BlackEvent(uid: uid));
          StorageService.to.updateMediaReportList(mid);
          AppEventBus.eventBus
              .fire(ReportEvent(ReportEnum.anchorDetailImage.index, mid: mid));
          Get.back();
        });
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        child: Image.asset(
          Assets.imgReportIcon,
          matchTextDirection: true,
          width: 34,
          height: 34,
        ),
      ),
    );
  }

  Widget btn(HostDetail data) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 20),
            child: AnchorBtn(data),
          ),
          if (data.isChat)
            PositionedDirectional(
                end: 30,
                bottom: 60,
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      color: const Color(0xFF260418),
                      border:
                          Border.all(width: 1, color: const Color(0xFFEF45A3)),
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(37),
                          bottomStart: Radius.circular(37),
                          topEnd: Radius.circular(37),
                          bottomEnd: Radius.circular(0))),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 2),
                            child: Image.asset(
                              Assets.imgDiamond,
                              matchTextDirection: true,
                              width: 14,
                              height: 14,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: "${data.charge ?? 0}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: Tr.app_video_time_unit.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}