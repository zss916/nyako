import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';

class BuildCallPrice extends StatelessWidget {
  final int? price;

  const BuildCallPrice({super.key, this.price});

  @override
  Widget build(BuildContext context) {
    return (price != null)
        ? Row(
            children: [
              const Spacer(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                        colors: [Color(0xFF822CFE), Color(0xFFD500FE)])),
                margin: const EdgeInsets.only(top: 3),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          Assets.iconDiamond,
                          matchTextDirection: true,
                          width: 15,
                          height: 15,
                        ),
                      ),
                      TextSpan(
                        text: " ${price ?? 0}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: Tr.app_video_time_unit.tr,
                        style: TextStyle(
                            fontFamily: AppConstants.fontsRegular,
                            color: Colors.white,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          )
        : const SizedBox.shrink();
  }
}
