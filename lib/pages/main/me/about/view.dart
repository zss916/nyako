part of 'index.dart';

@RouteName(AppPages.aboutUs)
class AboutPage extends GetView<AboutLogic> {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_setting_about_us.tr,
      ),
      backgroundColor: Colors.white,
      body: AboutBody(controller),
    );
  }
}
