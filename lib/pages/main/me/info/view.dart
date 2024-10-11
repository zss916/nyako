part of 'index.dart';

@RouteName(AppPages.edit)
class EditPage extends GetView<EditLogic> {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_details_edit_info.tr,
      ),
      backgroundColor: Colors.white,
      body: EditBody(controller),
    );
  }
}
