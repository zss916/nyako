part of 'index.dart';

@RouteName(AppPages.report)
class ReportPage extends GetView<ReportLogic> {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Tr.app_report_title.tr,
      ),
      backgroundColor: AppColors.splashBg,
      body: ReportBody(controller),
    );
  }
}
