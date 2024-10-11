part of 'index.dart';

@RouteName(AppPages.call)
class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppPages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppPages.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    safeFind<CallLogic>()?.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.black,
        child: GetBuilder<CallLogic>(
            init: CallLogic(),
            initState: (_) {
              // AudioManager.instance.stopBgm();
            },
            dispose: (_) {},
            builder: (logic) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  logic.connecting ? Connecting(logic) : VideoPage(logic),
                  Center(
                    child: logic.showWarn
                        ? WarnTip(logic)
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
