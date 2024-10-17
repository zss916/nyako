part of 'index.dart';

@RouteName(AppPages.login)
class LoginPage extends GetView<LoginLogic> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        leading: const SizedBox.shrink(),
        systemOverlayStyle: darkBarStyle,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFE8F7FE),
      body: const LoginBody(),
    );
  }
}
