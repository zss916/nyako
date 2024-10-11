import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/utils/app_extends.dart';

class HeaderWidget extends StatelessWidget {
  final String portrait;
  const HeaderWidget(this.portrait, {super.key});
  @override
  Widget build(BuildContext context) => cachedImage(portrait,
      width: Get.width, height: Get.width, fit: BoxFit.cover);
}
