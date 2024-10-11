part of 'index.dart';

@RouteName(AppPages.prop)
class PropPage extends GetView<PropLogic> {
  const PropPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_mine_my_prop.tr,
      ),
      backgroundColor: AppColors.splashBg,
      //extendBodyBehindAppBar: true,
      body: const CardListBody(),
    );
  }
}
