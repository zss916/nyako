part of 'index.dart';

@RouteName(AppPages.inviteCode)
class InviteCodePage extends GetView<InviteCodeLogic> {
  const InviteCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_my_binding_code.tr,
      ),
      backgroundColor: AppColors.splashBg,
      body: InviteCodeBody(controller),
    );
  }
}
