part of 'index.dart';

@RouteName(AppPages.myMoment)
class DynamicPage extends GetView<DynamicLogic> {
  const DynamicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: Tr.app_my_moments.tr.tr, actions: const [BuildPublic()]),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: const DynamicBody(),
    );
  }
}
