part of 'index.dart';

@RouteName(AppPages.changePassword)
class ChangePasswordPage extends GetView<ChangePasswordLogic> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BaseAppBar(
          title: Tr.app_change_pwd.tr,
        ),
        backgroundColor: Colors.white,
        body: SetPassWord(),
      );
}
