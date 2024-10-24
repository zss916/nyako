part of 'index.dart';

@RouteName(AppPages.recharge)
class RechargePage extends GetView<RechargeLogic> {
  const RechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      child: Scaffold(
        appBar: BaseAppBar(
            backgroundColor: Colors.white,
            leading: (!AppConstants.isFakeMode) ? toBack : null,
            title: Tr.app_mine_my_diamond.tr,
            actions: [BuildAction(controller)]),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: RechargeBody(controller),
      ),
    );
  }

  Widget get toBack => Container(
        alignment: AlignmentDirectional.center,
        margin: const EdgeInsetsDirectional.all(2),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            if (AppConstants.isCreatePayOrder == false) {
              AppConstants.isCreatePayOrder = true;
              ChargeDialogManager.showChargeDialog(
                  ChargePath.android_recharge_center);
            } else {
              Get.back();
            }
          },
          child: SizedBox(
            width: 38,
            height: 38,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  Assets.iconBack,
                  width: 24,
                  height: 24,
                  matchTextDirection: true,
                )
              ],
            ),
          ),
        ),
      );
}
