part of 'index.dart';

@RouteName(AppPages.rewardDetails)
class RewardDetailsPage extends GetView<RewardDetailsLogic> {
  const RewardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_reward_details.tr,
      ),
      backgroundColor: AppColors.splashBg,
      body: RewardDetailsBody(controller),
    );
  }
}
