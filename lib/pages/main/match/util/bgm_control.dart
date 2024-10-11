import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/pages/main/main/index.dart';
import 'package:oliapro/pages/main/match/index.dart';
import 'package:oliapro/routes/a_routes.dart';
import 'package:oliapro/utils/app_extends.dart';
import 'package:oliapro/utils/music/match_music_manager.dart';

mixin class BgmControl {
  late bool isBgm = true;
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  late String musicPath = Assets.ringMatchBg;

  initBgm() {
    player.openPlayer().then((value) {
      playBgm();
    });
    player.setVolume(1);
  }

  void playBgm() async {
    if (isBgm && player.isOpen()) {
      Uint8List? dataBuffer =
          (await rootBundle.load(musicPath)).buffer.asUint8List();
      await player.startPlayer(
          fromDataBuffer: dataBuffer,
          sampleRate: 8000,
          codec: Codec.mp3,
          whenFinished: () async {
            await player.seekToPlayer(const Duration(seconds: 0));
            playBgm();
          });
      //VolumeController().setVolume(0.8);
    }
  }

  resumeBgm() async {
    if (isBgm && player.isOpen()) {
      player.resumePlayer();
    }
  }

  pauseBgm() {
    if (player.isOpen()) {
      player.pausePlayer();
    }
  }

  stopBgm() {
    if (player.isOpen()) {
      player.stopPlayer();
    }
  }

  bgmState() {
    player.playerState;
  }

  setVolume(double volume) {
    if (player.isOpen()) {
      player.setVolume(volume);
    }
  }

  ///只用于被叫/主叫页面,主播/虚拟 视频通话页面,结算页面
  static callInBgmStart() {
    int select = (safeFind<MainLogic>()?.currentIndex) ?? 0;
    if (ARoutes.isMainPage && select == 2) {
      safeFind<MatchLogic>()?.setVolume(1);
      safeFind<MatchLogic>()?.playBgm();
      MatchMusicManager.instance.setVolume(1);
    }
  }

  ///只用于被叫页面
  static callInBgmClose() {
    safeFind<MatchLogic>()?.stopBgm();
    MatchMusicManager.instance.setVolume(0);
  }

  ///只用于在匹配页面打开主播详情
  static anchorDetailsBgmClose() {
    safeFind<MatchLogic>()?.stopBgm();
    MatchMusicManager.instance.setVolume(0);
  }

  ///只用于在匹配页面关闭主播详情
  static anchorDetailBgmStart() {
    int select = (safeFind<MainLogic>()?.currentIndex) ?? 0;
    if (ARoutes.isMainPage && select == 2) {
      safeFind<MatchLogic>()?.playBgm();
      MatchMusicManager.instance.setVolume(1);
    }
  }

  ///只用于在匹配结果/VIP dialog页面
  static setMatchVolume(bool open) {
    safeFind<MatchLogic>()?.setVolume(open ? 1 : 0);
    MatchMusicManager.instance.setVolume(open ? 1 : 0);
  }

  ///只用于在充值 dialog页面
  static setRechargeVolume(bool open) {
    safeFind<MatchLogic>()?.setVolume(open ? 1 : 0);
    MatchMusicManager.instance.setVolume(open ? 1 : 0);
  }
}
