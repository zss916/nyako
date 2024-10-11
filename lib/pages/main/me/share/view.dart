part of 'index.dart';

@RouteName(AppPages.share)
class SharePage extends GetView<ShareLogic> {
  const SharePage({super.key});
  @override
  Widget build(BuildContext context) => const ShareBody();
}
