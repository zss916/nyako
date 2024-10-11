import 'package:audioplayers/audioplayers.dart';

class RechargeSuccessManager {
  RechargeSuccessManager._internal();

  static final RechargeSuccessManager _instance =
      RechargeSuccessManager._internal();

  static RechargeSuccessManager get instance => _instance;

  static final AudioPlayer player = AudioPlayer();

  void start(
      {String filename = "ring/charge_success.mp3", double volume = 1}) async {
    await player.stop();
    await player.setPlayerMode(PlayerMode.lowLatency);
    await player.setVolume(volume);
    await player.setSource(AssetSource(filename));
    await player.resume();
  }

  void stop() {
    player.stop();
  }
}
