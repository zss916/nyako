import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/pages/call/aiv/index.dart';
import 'package:video_player/video_player.dart';

///只能用在虚拟视频通话
class AppVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const AppVideoPlayer({super.key, required this.controller});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // ***只用在虚拟视频通话，不需要这里释放
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var aivController = Get.find<AivLogic>();
    return Material(
      elevation: 0,
      child: SizedBox.expand(
        child: (!aivController.playerInited)
            ? const ColoredBox(color: Colors.black)
            : FittedBox(
                // 这个做了满屏处理
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: widget.controller.value.size.width,
                  height: widget.controller.value.size.height,
                  child: VideoPlayer(widget.controller),
                ),
              ),
      ),
    );
  }
}
