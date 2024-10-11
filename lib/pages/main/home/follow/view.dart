part of 'index.dart';

@RouteName(AppPages.follow)
class FollowPage extends GetView<FollowLogic> {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: Tr.app_home_tab_follow.tr),
      backgroundColor: AppColors.pageBg,
      body: const FollowList(),
    );
  }
}
