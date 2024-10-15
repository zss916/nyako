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
      backgroundColor: const Color(0xFFF4F5F6),
      body: RewardDetailsBody(controller),
    );
  }
}
