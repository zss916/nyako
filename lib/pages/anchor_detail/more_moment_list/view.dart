part of more_moments_page;

@RouteName(AppPages.moreMoment)
class MoreDynamicPage extends GetView<MoreDynamicLogic> {
  const MoreDynamicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: Tr.app_dynamic_title.tr),
      backgroundColor: AppColors.pageBg,
      body: const MoreDynamicBody(),
    );
  }
}
