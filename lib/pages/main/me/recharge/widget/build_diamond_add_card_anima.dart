import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyako/common/app_constants.dart';
import 'package:nyako/common/language_key.dart';
import 'package:nyako/generated/assets.dart';

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
            width: double.maxFinite,
            height: Get.height,
            color: Colors.black54,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                RepaintBoundary(
                  child: Image.asset(
                    Assets.animaNyakoDiamondAddBg,
                    width: double.maxFinite,
                    height: 130,
                    fit: BoxFit.fill,
                    matchTextDirection: true,
                  ),
                ),
                RepaintBoundary(
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 15),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(
                                Assets.iconDiamondAddCard,
                                width: 90,
                                height: 80,
                                matchTextDirection: true,
                              ),
                              PositionedDirectional(
                                  top: 2,
                                  start: 3,
                                  child: SizedBox(
                                    width: 50,
                                    child: AutoSizeText(
                                      "+${widget.num}%",
                                      maxLines: 1,
                                      maxFontSize: 24,
                                      minFontSize: 18,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontFamily: AppConstants.fontsBold,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                            child: AutoSizeText(
                          Tr.appHasDiamondCard.trArgs(["${widget.num}"]),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          maxFontSize: 22,
                          minFontSize: 18,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: AppConstants.fontsBold,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
