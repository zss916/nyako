part of 'index.dart';

@RouteName(AppPages.initial)
class SplashPage extends GetView<SplashLogic> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: SplashBg(
          child: SplashBody(),
        ));
  }
}
