import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideo extends StatefulWidget {
  final String video;
  final double width;
  final double height;

  const AppVideo(this.video, this.width, this.height, {Key? key})
      : super(key: key);

  @override
  _AppVideoPlayerState createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    initVideoCtrl();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initVideoCtrl() {
    _controller = VideoPlayerController.asset(widget.video,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: widget.width,
                height: widget.height,
                child: VideoPlayer(_controller),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
