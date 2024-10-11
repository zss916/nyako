import 'package:audioplayers/audioplayers.dart';

/// 记录播放地址的播放器
class AppAudioPlayer extends AudioPlayer {
  factory AppAudioPlayer() {
    return _audioCallingCenter;
  }

  static final _audioCallingCenter = AppAudioPlayer._intal();

  AppAudioPlayer._intal() {}
  String _currentUrl = "-9999999999999999";

  String get currentUrl {
    return _currentUrl;
  }

  _resetCurrentUrl() {
    _currentUrl = "-9999999999999999";
  }

  void stopAndReset() {
    stop();
    _resetCurrentUrl();
  }

  Future<void> playUrl(
    String url, {
    bool? isLocal,
    double volume = 1.0,
    Duration? position,
  }) {
    _currentUrl = url;
    return super.play(UrlSource(url), volume: volume, position: position);
  }
}
