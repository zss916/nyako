import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildFreeTip2 extends StatelessWidget {
  const BuildFreeTip2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xFFFF40A3),
            Color(0xFFFF8D1E),
          ]),
          borderRadius: BorderRadiusDirectional.only(
              topStart: const Radius.circular(20),
              topEnd: const Radius.circular(20),
              bottomEnd: (Get.locale?.languageCode == "ar")
                  ? Radius.zero
                  : const Radius.circular(20),
              bottomStart: (Get.locale?.languageCode == "ar")
                  ? const Radius.circular(20)
                  : Radius.zero)),
      child: const AutoSizeText(
        "Free",
        maxLines: 1,
        maxFontSize: 14,
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
