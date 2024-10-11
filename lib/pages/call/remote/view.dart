part of 'index.dart';

@RouteName(AppPages.callCome)
class RemotePage extends GetView<RemoteLogic> {
  const RemotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: GetBuilder<RemoteLogic>(
            init: RemoteLogic(),
            initState: (_) {
              AppConstants.isBeCall = true;
              AppAudioPlayer().stop();
            },
            dispose: (_) {
              AppConstants.isBeCall = false;
              AppRingManager.instance.stopPlayRing();
            },
            builder: (logic) => Body(logic)),
      ),
    );
  }
}
