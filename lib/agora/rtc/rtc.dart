part of 'index.dart';

mixin class Rtc {
  Rtc._internal();

  static final Rtc _instance = Rtc._internal();

  static Rtc get instance => _instance;

  late RtcEngine rtcEngine;

  void createRtc({
    String? appId,
    required String token,
    required String channelId,
    required int uid,
  }) async {
    RtcEngineContext rtcContext = RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting);
    //TestRtcUtils.userRtcCreate(text: "RtcEngineContext");
    rtcEngine = createAgoraRtcEngine();
    //TestRtcUtils.userRtcCreate(text: "createAgoraRtcEngine");
    await rtcEngine.initialize(rtcContext);
    //TestRtcUtils.userRtcCreate(text: " rtc initialize");
    rtcEngine.registerEventHandler(RtcEngineEventHandler(
        // onJoinChannelSuccess: joinChannelSuccess,
        onUserJoined: userJoined,
        onUserOffline: userOffline,
        onLeaveChannel: onLeaveChannel,
        onConnectionLost: connectionLost,
        onRemoteVideoStats: remoteVideoStats,
        onConnectionBanned: connectionBanned,
        onStreamMessage: onStreamMessage,
        onError: onError,
        onConnectionStateChanged: onConnectionStateChanged));
    await rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 160, height: 120),
        degradationPreference: DegradationPreference.maintainFramerate,
        orientationMode: OrientationMode.orientationModeFixedPortrait,
      ),
    );
    await rtcEngine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await rtcEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await rtcEngine.enableVideo();
    await rtcEngine.startPreview();
    //TestRtcUtils.userRtcCreate(text: " rtc joinChannel");
    joinChannel(token: token, channelId: channelId, uid: uid);
  }

  ///加入频道
  void joinChannel(
      {required String token, required String channelId, required int uid}) {
    rtcEngine.joinChannel(
        token: token,
        channelId: channelId,
        uid: uid,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  ///切换摄像头
  void switchCamera() async {
    await rtcEngine.switchCamera();
  }

  ///离开频道
  void leaveChannel() async {
    await rtcEngine.leaveChannel();
  }

  ///释放
  void releaseChannel() async {
    await rtcEngine.stopPreview();
    await rtcEngine.leaveChannel();
    await rtcEngine.release();
  }

  ///刷新token
  void renewToken(String token) async {
    await rtcEngine.renewToken(token);
  }

  ///设置音量
  void setVolume({required int volume}) async {
    await rtcEngine.adjustRecordingSignalVolume(volume);
  }

  ///视频中发送消息(互动视频)
  Future sendMsg({required String content}) async {
    ///streamId 可以在加入频道时获取
    final streamId = await rtcEngine.createDataStream(
        const DataStreamConfig(syncWithAudio: false, ordered: false));
    final data = Uint8List.fromList(utf8.encode(content));
    await rtcEngine.sendStreamMessage(
        streamId: streamId, data: data, length: data.length);
  }

  ///加入频道成功
  Function(RtcConnection connection, int elapsed)? joinChannelSuccess;

  ///有用户加入了频道
  Function(RtcConnection connection, int remoteUid, int elapsed)? userJoined;

  ///有用户离开了频道
  Function(RtcConnection connection, int uid, UserOfflineReasonType reason)?
      userOffline;

  Function(RtcConnection connection)? connectionLost;

  Function(RtcConnection connection, RemoteVideoStats stats)? remoteVideoStats;

  Function(RtcConnection connection)? connectionBanned;

  ///视频中收到消息(互动视频)
  Function(RtcConnection connection, int remoteUid, int streamId,
      Uint8List data, int length, int sentTs)? onStreamMessage;
  // var message = utf8.decode(data);

  ///离开频道
  Function(RtcConnection connection, RtcStats stats)? onLeaveChannel;

  ///判断错误类型和错误信息
  Function(ErrorCodeType err, String msg)? onError;

  ///连接状态变化监听
  void onConnectionStateChanged(RtcConnection connection,
      ConnectionStateType state, ConnectionChangedReasonType reason) {
    //TestRtcUtils.showRtcStatus(status: state);
    switch (state) {
      case ConnectionStateType.connectionStateConnecting:
        debugPrint("rtc建立网络连接中");
        break;
      case ConnectionStateType.connectionStateConnected:
        debugPrint("rtc网络已连接");
        break;
      case ConnectionStateType.connectionStateFailed:
        debugPrint("rtc网络连接失败");
        break;
      case ConnectionStateType.connectionStateReconnecting:
        debugPrint("rtc重新建立网络连接中");
        break;
      case ConnectionStateType.connectionStateDisconnected:
        debugPrint("rtc网络连接断开");
        break;
      default:
        break;
    }
  }
}
