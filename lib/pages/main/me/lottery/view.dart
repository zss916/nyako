part of 'index.dart';

@RouteName(AppPages.lottery)
class LotteryPage extends GetView<LotteryLogic> {
  const LotteryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_lottery.tr,
        isDark: false,
      ),
      backgroundColor: const Color(0xFF27162C),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: LotteryBody(controller),
      ),
    );
  }
}
