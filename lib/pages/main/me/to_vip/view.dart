part of 'index.dart';

@RouteName(AppPages.toVip)
class ToVipPage extends GetView<VipLogic> {
  const ToVipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        // title: Tr.app_buy_vip.tr,
        isDark: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: ToVipBody(),
    );
  }
}
