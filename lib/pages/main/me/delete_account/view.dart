part of 'index.dart';

@RouteName(AppPages.deleteAccount)
class DeleteAccountPage extends GetView<DeleteAccountLogic> {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_account_cancellation.tr,
      ),
      backgroundColor: Colors.white,
      body: const DeleteAccountBody(),
    );
  }
}
