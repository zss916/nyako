import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class BaseEmpty extends StatelessWidget {
  const BaseEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.iconEmpty,
            width: 97,
            height: 97,
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
      ),
    );
  }
}
