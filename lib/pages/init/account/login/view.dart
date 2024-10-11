part of 'index.dart';

@RouteName(AppPages.accountLogin)
class AccountLoginPage extends GetView<AccountLoginLogic> {
  const AccountLoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        isSetBg: false,
        backgroundColor: Colors.transparent,
        leading: Get.arguments == true ? const SizedBox.shrink() : null,
      ),
      backgroundColor: AppColors.splashBg,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: AccountLoginBody(controller),
    );
  }
}
