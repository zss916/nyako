part of 'index.dart';

@RouteName(AppPages.lottery)
class LotteryPage extends GetView<LotteryLogic> {
  const LotteryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(Assets.lotteryLotteryBg2),
              matchTextDirection: true,
              fit: BoxFit.fill)),
      child: Scaffold(
        appBar: BaseAppBar(
          title: Tr.app_lottery.tr,
          isDark: false,
          isSetBg: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: LotteryBody(controller),
        ),
      ),
    );
  }
}
