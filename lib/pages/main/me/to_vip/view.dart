part of 'index.dart';

@RouteName(AppPages.toVip)
class ToVipPage extends GetView<VipLogic> {
  const ToVipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        // title: Tr.app_buy_vip.tr,
        leading: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Image.asset(
                Assets.iconIcBack,
                matchTextDirection: true,
                width: 32,
                height: 32,
              ),
            )
          ],
        ),
        isDark: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: ToVipBody(),
    );
  }
}
