import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_colors.dart';
import 'package:oliapro/common/app_common_type.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';
import 'package:oliapro/http/index.dart';
import 'package:oliapro/routes/app_pages.dart';

class AppCallSexyDialog extends StatefulWidget {
  static void checkToShow(AppCallback<int> callback) async {
    if (AppConstants.isFakeMode) {
      return;
    }
    Get.dialog(
        AppCallSexyDialog(
          callback: callback,
        ),
        routeSettings: const RouteSettings(name: AppPages.selectSexDialog));
  }

  final AppCallback<int> callback;

  const AppCallSexyDialog({super.key, required this.callback});

  @override
  State<AppCallSexyDialog> createState() => _AppCallSexyDialogState();
}

class _AppCallSexyDialogState extends State<AppCallSexyDialog> {
  bool noMore = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(start: 30, end: 30),
            padding: const EdgeInsetsDirectional.only(
              bottom: 20,
              start: 30,
              end: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.error_outline_outlined,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
                  child: Text(
                    Tr.app_video_sex_warn.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        noMore = !noMore;
                      });
                    }
                  },
                  child: Text.rich(
                    TextSpan(children: [
                      WidgetSpan(
                          child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: Obx(
                          () => Image.asset(
                            noMore ? Assets.imgChecked : Assets.imgUncheck,
                            fit: BoxFit.fill,
                            height: 20,
                            width: 20,
                            color: Colors.red,
                          ),
                        ),
                      )),
                      TextSpan(
                          text: Tr.app_video_sex_warn_no_more.tr,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14))
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (noMore) {
                      Http.instance.post<String>(NetPath.noLongerReminds,
                          errCallback: (err) {});
                    }
                    Get.back();
                  },
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFFFF7AC2),
                          Color(0xFFFF43A9),
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      Tr.app_base_confirm.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                    widget.callback.call(0);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Text(
                      Tr.app_confirm_hang_up.tr,
                      style: const TextStyle(
                          color: AppColors.colorC28AFF,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
