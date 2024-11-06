import 'package:flutter/material.dart';
import 'package:nyako/generated/assets.dart';
import 'package:nyako/utils/translate/app_translate_util.dart';

class BuildSelectIcon extends StatefulWidget {
  final bool? isTranslated;
  final String? content;
  final Function(String)? fun;

  const BuildSelectIcon({super.key, this.isTranslated, this.content, this.fun});

  @override
  State<BuildSelectIcon> createState() => _BuildSelectState();
}

class _BuildSelectState extends State<BuildSelectIcon> {
  @override
  Widget build(BuildContext context) {
    return widget.isTranslated == true
        ? Image.asset(
            Assets.iconTranslated,
            matchTextDirection: true,
            width: 32,
            height: 32,
          )
        : GestureDetector(
            onTap: () {
              Future.delayed(const Duration(seconds: 3), () {
                AppTranslateUtil()
                    .translate(widget.content ?? "")
                    .then((value) {
                  if (value.isNotEmpty) {
                    widget.fun?.call(value.first);
                  }
                });
              });
            },
            child: Image.asset(
              Assets.iconTranslate,
              matchTextDirection: true,
              width: 32,
              height: 32,
            ),
          );
  }
}
