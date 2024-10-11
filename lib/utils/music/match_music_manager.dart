import 'package:audioplayers/audioplayers.dart';

class MatchMusicManager {
  MatchMusicManager._internal();

  static final MatchMusicManager _instance = MatchMusicManager._internal();

  static MatchMusicManager get instance => _instance;

  static final AudioPlayer player = AudioPlayer();

  void start({String filename = "ring/match_ok.MP3", double volume = 1}) async {
    await player.stop();
    await player.setPlayerMode(PlayerMode.lowLatency);
    await player.setVolume(volume);
    await player.setSource(AssetSource(filename));
    await player.resume();
  }

  void stop() {
    player.stop();
  }

  void setVolume(double volume) {
    player.setVolume(volume);
  }
}
