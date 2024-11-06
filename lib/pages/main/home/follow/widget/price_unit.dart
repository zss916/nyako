import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';

class PriceUnit extends StatelessWidget {
  final String price;

  const PriceUnit({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 0),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 3, vertical: 2),
      decoration: const BoxDecoration(
          color: Color(0x80982AFF),
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              bottomStart: Radius.circular(20),
              topEnd: Radius.circular(20),
              bottomEnd: Radius.circular(20))),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "",
          style: const TextStyle(color: Colors.white, fontSize: 12),
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 2),
                child: Image.asset(
                  Assets.iconDiamond,
                  matchTextDirection: true,
                  width: 14,
                  height: 14,
                ),
              ),
            ),
            TextSpan(
              text: price,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: Tr.app_video_time_unit.tr,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}
