part of '../index.dart';

class AgoraLocalVideoView extends StatelessWidget {
  final RtcEngine engine;

  const AgoraLocalVideoView({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    return AgoraVideoView(
        controller: VideoViewController(
            rtcEngine: engine, canvas: const VideoCanvas(uid: 0)));
  }
}
