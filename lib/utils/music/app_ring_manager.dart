import 'package:audioplayers/audioplayers.dart';

class AppRingManager {
  AppRingManager._internal();

  static final AppRingManager _instance = AppRingManager._internal();

  static AppRingManager get instance => _instance;

  static final AudioPlayer player = AudioPlayer();

  void playRing(
      {String filename = "ring/app_ring.MP3", double volume = 1}) async {
    await player.stop();
    await player.setPlayerMode(PlayerMode.lowLatency);
    await player.setReleaseMode(ReleaseMode.loop);
    await player.setVolume(volume);
    await player.setSource(AssetSource(filename));
    await player.resume();
  }

  bool get isPlaying => player.state == PlayerState.playing;

  void stopPlayRing() {
    player.stop();
  }

  void pauseRing() {
    player.pause();
  }

  void resumeRing() {
    if (!isPlaying) {
      player.resume();
    }
  }

  void setVolume(double volume) {
    player.setVolume(volume);
  }
}
