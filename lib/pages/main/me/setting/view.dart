part of 'index.dart';

@RouteName(AppPages.setting)
class SetPage extends GetView<SetLogic> {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_mine_setting.tr,
        actions: [
          /*if (AppConstants.haveTestLogin)
            InkWell(
              onTap: () => Get.toNamed(AppPages.test),
              child: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )*/
        ],
      ),
      backgroundColor: const Color(0xFFF4F5F6),
      body: SetBody(controller),
    );
  }
}
