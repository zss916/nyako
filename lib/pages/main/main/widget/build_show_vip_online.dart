import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/pages/main/main/widget/vip_up_online.dart';
import 'package:nyako/routes/app_pages.dart';
import 'package:nyako/routes/observer/route_extend.dart';
import 'package:nyako/services/user_info.dart';

void showVipOnlineDialog({Function? onNext}) {
  if (UserInfo.to.isUserVip) {
    Get.dialog(
        BuildShowVipOnline(
          onNext: onNext,
        ),
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: AppPages.vipOnlineDialog));
  } else {
    onNext?.call();
  }
}

class BuildShowVipOnline extends StatefulWidget {
  final Function? onNext;

  const BuildShowVipOnline({
    Key? key,
    this.onNext,
  }) : super(key: key);

  @override
  State<BuildShowVipOnline> createState() => _BuildShowVipOnlineState();
}

class _BuildShowVipOnlineState extends State<BuildShowVipOnline> {
  bool isShowVip = false;
  // bool isShowVipTitle = false;

  @override
  void initState() {
    super.initState();
    vipTimeCount();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onNext != null) {
      widget.onNext?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return SizedBox(
      width: Get.width,
      height: Get.height,
      child: VipUpOnline(),
    );*/
    return (isShowVip) ? const VipUpOnline() : const SizedBox.shrink();
  }

  vipTimeCount() {
    if (mounted) {
      setState(() {
        isShowVip = true;
      });
    }
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          isShowVip = false;
          Get.removeName(AppPages.vipOnlineDialog);
        });
      }
    });
  }
}
