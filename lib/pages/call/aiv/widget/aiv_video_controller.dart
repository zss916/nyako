import 'package:video_player/video_player.dart';

class AivVideoController {
  VideoPlayerController playerController;

  AivVideoController.make(String url)
      : playerController = VideoPlayerController.networkUrl(Uri.parse(url));
}
