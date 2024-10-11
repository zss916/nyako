part of 'index.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.splashBgNew,
      body: HomeBody2(),
    );
  }
}
