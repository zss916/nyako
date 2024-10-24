import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oliapro/common/language_key.dart';
import 'package:oliapro/generated/assets.dart';

class BuildDiamondAddCardAnima extends StatefulWidget {
  final int num;

  const BuildDiamondAddCardAnima({Key? key, required this.num})
      : super(key: key);

  @override
  _BuildDiamondAddCardAnimaState createState() =>
      _BuildDiamondAddCardAnimaState();
}

class _BuildDiamondAddCardAnimaState extends State<BuildDiamondAddCardAnima> {
  bool isShowDiamondAddAnima = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          isShowDiamondAddAnima = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowDiamondAddAnima
        ? Container(
            width: Get.width,
            height: Get.height,
            color: Colors.black54,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                RepaintBoundary(
                  child: Lottie.asset(Assets.jsonDiamondAddAnima,
                      fit: BoxFit.fitWidth),
                ),
                RepaintBoundary(
                  child: Transform.rotate(
                    angle: -3 * pi / 180,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      width: double.maxFinite,
                      child: AutoSizeText(
                        Tr.appHasDiamondCard.trArgs(["${widget.num}"]),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        maxFontSize: 20,
                        minFontSize: 12,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
