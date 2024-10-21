part of 'index.dart';

@RouteName(AppPages.anchorDetails)
class AnchorDetailPage extends GetWidget<AnchorDetailLogic> {
  const AnchorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: AnchorDetailsBody(),
    );
  }
}
