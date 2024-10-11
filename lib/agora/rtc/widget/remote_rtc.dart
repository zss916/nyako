part of '../index.dart';

class AgoraRemoteVideoView extends StatelessWidget {
  final RtcEngine engine;
  final int uid;
  final String? channelId;

  const AgoraRemoteVideoView(
      {super.key,
      required this.engine,
      required this.uid,
      required this.channelId});

  @override
  Widget build(BuildContext context) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine,
        canvas: VideoCanvas(
          uid: uid,
        ),
        connection: RtcConnection(channelId: channelId),
      ),
    );
  }
}
