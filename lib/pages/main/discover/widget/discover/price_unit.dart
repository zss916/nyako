import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class PriceUnit extends StatelessWidget {
  final String price;

  const PriceUnit({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      height: 20,
      margin: const EdgeInsetsDirectional.only(start: 0),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 1),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(20),
            topStart: Radius.circular(20),
            bottomStart: Radius.circular(20),
            bottomEnd: Radius.zero),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "",
          style: const TextStyle(color: Colors.white, fontSize: 12),
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                margin: const EdgeInsetsDirectional.only(bottom: 0),
                child: Image.asset(
                  Assets.imgDiamond,
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
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: Tr.app_video_time_unit.tr,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
