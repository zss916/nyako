import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.1),
                ),
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
                          Assets.imgDiamond,
                          matchTextDirection: true,
                          width: 13,
                          height: 13,
                        ),
                      ),
                      TextSpan(
                        text: " ${price ?? 0}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: Tr.app_video_time_unit.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
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
