part of aiv_page;

@RouteName(AppPages.aivPage)
class AivPage extends GetView<AivLogic> {
  const AivPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        color: Colors.black,
        child: GetBuilder<AivLogic>(
            init: AivLogic(),
            initState: (_) {
              //  AudioManager.instance.stopBgm();
            },
            dispose: (_) {},
            builder: (logic) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // Connecting(logic),
                  logic.connecting ? Connecting(logic) : AivBody(logic),
                  Center(
                    child: logic.showWarn
                        ? WarnTip(logic)
                        : const SizedBox.shrink(),
                  )
                ],
              );
            }),
      ),
    );
  }
}
