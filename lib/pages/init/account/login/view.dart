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
        leading: const SizedBox.shrink(),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsetsDirectional.all(10),
              child: Image.asset(
                Assets.iconClosePage,
                width: 30,
                height: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: const Color(0xFFF3FCFE),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: AccountLoginBody(controller),
    );
  }
}
