import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/generated/assets.dart';

class BaseAppBar extends AppBar {
  BaseAppBar(
      {super.key,
      String? title,
      Widget? leading,
      bool? centerTitle,
      super.actions,
      Color? backgroundColor,
      super.bottom,
      SystemUiOverlayStyle? systemOverlayStyle,
      Widget? titleWidget,
      bool isDark = true,
      Function? back,
      bool? isSetBg})
      : super(
          backgroundColor: backgroundColor ?? Colors.transparent,
          elevation: 0,
          title: titleWidget ??
              AutoSizeText(
                title ?? '',
                maxLines: 1,
                maxFontSize: 21,
                minFontSize: 14,
                style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontSize: 21,
                    fontFamily: AppConstants.fontsBold,
                    fontWeight: FontWeight.bold),
              ),
          leading: leading ??
              UnconstrainedBox(
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  // behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (back == null) {
                      Navigator.maybePop(Get.context!);
                    } else {
                      back.call();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    child: Image.asset(
                      Assets.iconBack,
                      matchTextDirection: true,
                      width: 24,
                      height: 24,
                      color: isDark ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
          centerTitle: centerTitle ?? true,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: systemOverlayStyle ??
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness:
                    isDark ? Brightness.dark : Brightness.light,
                statusBarIconBrightness:
                    isDark ? Brightness.dark : Brightness.light,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness:
                    isDark ? Brightness.dark : Brightness.light,
              ),
        );
}
