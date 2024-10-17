import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oliapro/common/app_constants.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/entities/app_charge_quick_entity.dart';
import 'package:oliapro/generated/assets.dart';

class BuildAddCard extends StatelessWidget {
  final DiamondCardBean? diamondCard;
  const BuildAddCard(this.diamondCard, {super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint("buildAddCard===>> ${diamondCard?.toJson()}");
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xFFFF741A),
            Color(0xFFFF17D6),
          ]),
          borderRadius: BorderRadiusDirectional.circular(12)),
      padding: const EdgeInsetsDirectional.all(6),
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 6, vertical: 7),
            decoration: BoxDecoration(
                color: const Color(0x33000000),
                borderRadius: BorderRadiusDirectional.circular(12)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 6),
                  child: Image.asset(
                    Assets.iconAddCardSmall,
                    matchTextDirection: true,
                    width: 26,
                    height: 27,
                  ),
                ),
                Expanded(
                    child: AutoSizeText(
                  Tr.app_prop_add_title
                      .trArgs(["${diamondCard?.propDuration ?? "0"}"]),
                  maxFontSize: 14,
                  minFontSize: 6,
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.symmetric(
                horizontal: 6, vertical: 12),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                    child: AutoSizeText(
                  Tr.app_prop_add_content
                      .trArgs(["${diamondCard?.propDuration ?? "0"}"]),
                  maxFontSize: 14,
                  minFontSize: 6,
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 10, end: 5),
                  child: Row(
                    children: [
                      Text(
                        "+${diamondCard?.increaseDiamonds ?? 0}",
                        style: TextStyle(
                            color: const Color(0xFFFFE986),
                            fontFamily: AppConstants.fontsRegular,
                            fontSize: 14),
                      ),
                      Image.asset(
                        Assets.iconDiamond,
                        width: 16,
                        height: 16,
                        matchTextDirection: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white10,
            indent: 6,
            endIndent: 6,
            height: 1,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                start: 6, end: 6, bottom: 6, top: 12),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                    child: AutoSizeText(
                  Tr.app_total.tr,
                  maxFontSize: 14,
                  minFontSize: 6,
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 10, end: 5),
                  child: Row(
                    children: [
                      Text(
                        "${diamondCard?.totalDiamonds ?? 0}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppConstants.fontsRegular,
                            fontSize: 14),
                      ),
                      Image.asset(
                        Assets.iconDiamond,
                        width: 16,
                        height: 16,
                        matchTextDirection: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget addCard(DiamondCardBean? diamondCard) {
  return Container(
    width: double.maxFinite,
    height: 64,
    padding: const EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 0),
    decoration: const BoxDecoration(color: Color(0x33FFAB50)),
    child: Row(
      children: [
        Expanded(
            child: Container(
          height: double.maxFinite,
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                child: Image.asset(
                  Assets.imgAddCard2,
                  matchTextDirection: true,
                  width: 60,
                  height: 48,
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    Tr.app_prop_add_title
                        .trArgs(["${diamondCard?.propDuration ?? "0"}"]),
                    maxFontSize: 14,
                    minFontSize: 6,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text.rich(TextSpan(
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      children: [
                        const TextSpan(
                          text: "+",
                          style: TextStyle(
                            color: Color(0xFFFFF890),
                          ),
                        ),
                        TextSpan(
                          text: "${diamondCard?.increaseDiamonds ?? 0}",
                          style: const TextStyle(
                            color: Color(0xFFFFF890),
                          ),
                        ),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.asset(
                              Assets.imgDiamond,
                              matchTextDirection: true,
                              width: 12,
                              height: 12,
                            )),
                      ])),
                ],
              )),
            ],
          ),
        )),
        Container(
          height: double.maxFinite,
          alignment: AlignmentDirectional.centerEnd,
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: AutoSizeText(
                      "${diamondCard?.totalDiamonds ?? 0}",
                      maxFontSize: 18,
                      minFontSize: 12,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFF890),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 2),
                    child: Image.asset(
                      Assets.imgDiamond,
                      matchTextDirection: true,
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
              Text(
                Tr.app_total.tr,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
