import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class BaseTopEmpty extends StatelessWidget {
  final double? h;
  const BaseTopEmpty({super.key, this.h});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: h ?? 80,
        ),
        Image.asset(
          Assets.imgBaseEmpty,
          width: 120,
          height: 120,
          matchTextDirection: true,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          Tr.app_no_more.tr,
          style: const TextStyle(color: Color(0xFF736F77), fontSize: 14),
        ),
      ],
    );
  }
}
