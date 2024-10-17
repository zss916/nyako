part of 'index.dart';

@RouteName(AppPages.initial)
class SplashPage extends GetView<SplashLogic> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          leading: const SizedBox.shrink(),
          systemOverlayStyle: lightBarStyle,
        ),
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: const SplashBody());
  }
}
