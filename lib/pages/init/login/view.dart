part of 'index.dart';

@RouteName(AppPages.login)
class LoginPage extends GetView<LoginLogic> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.splashBg,
      body: LoginBody(),
    );
  }
}
