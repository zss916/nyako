import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oliapro/generated/assets.dart';

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
                maxFontSize: 20,
                minFontSize: 14,
                style: TextStyle(
                    color: isDark ? Colors.black : Colors.black,
                    fontSize: 20,
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
                      color: isDark ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
          centerTitle: centerTitle ?? true,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: systemOverlayStyle ??
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: isSetBg != null
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.topCenter,
                          end: AlignmentDirectional.bottomCenter,
                          colors: [
                          Color(0xFF381853),
                          Color(0xFF491E61),
                        ]))
                  : const BoxDecoration(),
            ),
          ),
        );
}
