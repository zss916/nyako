import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/utils/app_some_extension.dart';
import 'package:video_player/video_player.dart';

class AppNetVideo extends StatefulWidget {
  final String video;
  final double width;
  final double height;
  final bool? showLoading;

  const AppNetVideo(this.video, this.width, this.height,
      {Key? key, this.showLoading})
      : super(key: key);

  @override
  _AppNetVideoPlayerState createState() => _AppNetVideoPlayerState();
}

class _AppNetVideoPlayerState extends State<AppNetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //debugPrint("initVideoCtrl====>>>> ${widget.video}");
    initVideoCtrl();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initVideoCtrl() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
    _controller.setPlaybackSpeed(0.8);
    _controller.setVolume(0);
  }

  double uiSize = (305.w) / (445.h);

  @override
  Widget build(BuildContext context) {
    return (!AppConstants.isFakeMode)
        ? Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: Center(
              child: _controller.value.isInitialized
                  ? Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.black,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Get.isTh ? matchSizePlayer() : fitXYPlayer()
                        ],
                      ),
                    )
                  : (widget.showLoading == true)
                      ? const CircularProgressIndicator(
                          color: Color(0xFf7934F0),
                        )
                      : const SizedBox.shrink(),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget scaleContent() => Builder(builder: (BuildContext context) {
        double videoSize =
            (_controller.value.size.width) / (_controller.value.size.height);
        double scale = uiSize / videoSize;

        return (!AppConstants.isFakeMode)
            ? Container(
                alignment: Alignment.center,
                child: Center(
                  child: _controller.value.isInitialized
                      ? scalePlayer(scale)
                      : (widget.showLoading == true)
                          ? const CircularProgressIndicator(
                              color: Color(0xFf7934F0),
                            )
                          : const SizedBox.shrink(),
                ),
              )
            : const SizedBox.shrink();
      });

  Widget scalePlayer(double scale) => Material(
        elevation: 0,
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: _controller.value.size.width ?? 0,
            height: _controller.value.size.height ?? 0,
            child: VideoPlayer(_controller),
          ),
        ),
      );

  Widget matchSizePlayer() => Material(
        elevation: 0,
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _controller.value.size.width ?? 0,
            height: _controller.value.size.height ?? 0,
            child: VideoPlayer(_controller),
          ),
        ),
      );

  Widget fitXYPlayer() => SizedBox(
        width: widget.width,
        height: widget.height,
        child: VideoPlayer(_controller),
      );
}
